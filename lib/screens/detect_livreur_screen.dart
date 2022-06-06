import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/services/livreur_loc.dart';
import 'package:food_line/utils/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Mes commandes/suivi_commande_screen.dart';

class DetectLivreurScreen extends StatefulWidget {
  final String id, cmdId;
  final List<double> positionList;
  const DetectLivreurScreen({
    required this.id,
    required this.cmdId,
    required this.positionList,
    Key? key,
  }) : super(key: key);

  @override
  State<DetectLivreurScreen> createState() => _DetectLivreurScreenState();
}

class _DetectLivreurScreenState extends State<DetectLivreurScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;

  Timer? timer;
  Marker marker = const Marker(
    markerId: MarkerId('home'),
    position: LatLng(49.409393, 1.084645),
  );
  Marker stationMarker = const Marker(
    markerId: MarkerId('station'),
    position: LatLng(49.409393, 1.084645),
  );
  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load(
      'images/car.jpg',
    );
    return byteData.buffer.asUint8List();
  }

  Circle? circle;
  late Polyline polyline =
      const Polyline(polylineId: PolylineId('polyline'), points: [
    LatLng(49.409393, 1.084645),
    LatLng(49.409393, 1.084645),
  ]);
  Map<String, dynamic>? livreurPosData = {
    'response': false,
    'message': '',
  };
  LivreurLocation livreurLocation = LivreurLocation();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(49.409393, 1.084645),
    zoom: 13,
  );
  getLivreurPos() async {
    livreurPosData = await livreurLocation.getLivreurPosition(widget.id);
    cameraPosition = CameraPosition(
      target: LatLng(livreurPosData?['lat'] ?? 0, livreurPosData?['lng'] ?? 0),
      zoom: 13,
    );
    stationMarker = Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'images/bus-stop.png'),
      markerId: const MarkerId('station'),
      position: LatLng(
        widget.positionList[0],
        widget.positionList[1],
      ),
    );
    Uint8List imageData = await getMarker();
    setState(() {
      circle = Circle(
        circleId: const CircleId('car'),
        radius: 2,
        zIndex: 1,
        strokeColor: Colors.blue,
        center:
            LatLng(livreurPosData?['lat'] ?? 0, livreurPosData?['lng'] ?? 0),
        fillColor: Colors.blue.withAlpha(70),
      );
      marker = Marker(
        icon: BitmapDescriptor.fromBytes(imageData),
        markerId: const MarkerId('home'),
        position:
            LatLng(livreurPosData?['lat'] ?? 0, livreurPosData?['lng'] ?? 0),
      );
      polyline = Polyline(polylineId: const PolylineId('polyline'), points: [
        LatLng(livreurPosData?['lat'] ?? 0, livreurPosData?['lng'] ?? 0),
        LatLng(widget.positionList[0], widget.positionList[1]),
      ]);
    });

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getLivreurPos();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _animation = Tween<double>(begin: -1, end: 0)
        .chain(
          CurveTween(
            curve: Curves.elasticOut,
          ),
        )
        .animate(_animationController);

    timer = Timer.periodic(const Duration(milliseconds: 500), (v) {
      getLivreurPos();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        timer?.cancel();
        _animationController.dispose();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SuiviCommandeScreen(id: widget.cmdId),
          ),
        );

        return false;
      },
      child: Scaffold(
        body: livreurPosData?['response']
            ? Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: cameraPosition,
                    markers: {
                      marker,
                      stationMarker,
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        double x = _animation.value *
                                MediaQuery.of(context).size.width,
                            y = _animation.value *
                                MediaQuery.of(context).size.width;

                        return Transform(
                          transform: Matrix4.translationValues(0, x / 6, 0),
                          child: child,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            timer?.cancel();
                            _animationController.dispose();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SuiviCommandeScreen(id: widget.cmdId),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 80.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2.w, color: my_green),
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant,
                                  color: Colors.white,
                                ),
                                Text(
                                  'voir détail\ncommande',
                                  style: TextStyle(
                                    color: my_green,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
