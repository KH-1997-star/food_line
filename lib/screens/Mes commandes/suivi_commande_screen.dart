import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/screens/Mes%20commandes/commande_repo.dart';
import 'package:food_line/screens/Mes%20commandes/mes_commandes_screen.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/screens/detect_livreur_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/center_footer_widget.dart';
import 'package:food_line/widgets/commande_widget.dart';
import 'package:food_line/widgets/contact_livreur_widge.dart';
import 'package:food_line/widgets/footer_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:food_line/widgets/suivi_cmd_widget.dart';
import 'package:food_line/widgets/suivicmd_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

final commandeProvider = ChangeNotifierProvider<CommandeNotifier>(
  (ref) => CommandeNotifier(),
);

class SuiviCommandeScreen extends ConsumerStatefulWidget {
  final String? id;
  const SuiviCommandeScreen({Key? key, this.id}) : super(key: key);

  @override
  _SuiviCommandeScreenState createState() => _SuiviCommandeScreenState();
}

class _SuiviCommandeScreenState extends ConsumerState<SuiviCommandeScreen> {
  String? idLivreur;
  List<double>? positionList;
  getDetais() {
    var viewmodel = ref.read(commandeProvider);

    viewmodel.detailsCommandeLivreur(widget.id!, context).then((value) async {
      var data = await viewmodel.getPositionStation(widget.id!, context);
      print("STATIOOOOOOON POSOOOOOOORIITBT");

      positionList = data['data'];
      position = data['position'];
      print(position);
      print('HEEERRRREE KHAAAYRIIII');

      setState(() {
        idLivreur = viewmodel.detailsCmdLivreur?[0].livreur?[0].identifiant;
        isLoading = false;
        numCmd = viewmodel.detailsCmdLivreur?[0].numeroCommande.toString();
      });
    });
  }

  String? position;
  bool isLoadingStat = true;
  getStat() {
    var viewmodel = ref.read(commandeProvider);
    viewmodel.statusCommande(widget.id!, context).then((value) {
      setState(() {
        isLoadingStat = false;
        // numCmd = viewmodel.detailsCmd?[0].results?[0].numeroCommande.toString();
      });
    });
  }

  String? numCmd;
  @override
  void initState() {
    getDetais();
    getStat();
    super.initState();
  }

  bool isLoading = true;
  bool goToMenu = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MesCommandeScreen()));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 40.h,
                left: 32.w,
                child: Row(
                  children: [
                    MyWidgetButton(
                      widget: SvgPicture.asset(
                        'images/arrowback.svg',
                        height: 2.h,
                        width: 2.w,
                        fit: BoxFit.none,
                        color: my_white,
                      ),
                      color: my_green,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MesCommandeScreen())),
                    ),
                    SizedBox(
                      width: 54.w,
                    ),
                    Text(
                      'Suivi commande',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    MyWidgetButton(
                      widget: SvgPicture.asset(
                        'icons/location.svg',
                        height: 2.h,
                        width: 2.w,
                        fit: BoxFit.none,
                        color: my_white,
                      ),
                      color: my_grey,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetectLivreurScreen(
                            id: idLivreur ?? '',
                            positionList: positionList ?? [0, 0],
                            cmdId: widget.id ?? '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 500.h,
                padding: EdgeInsets.only(top: 115.h),
                child: isLoadingStat
                    ? Container(
                        color: Colors.white,
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: LoadingIndicator(
                              color: my_green,
                              indicatorType: Indicator.ballRotateChase,
                            ),
                          ),
                        ),
                      )
                    : SuiviCommandeWidget(idCmd: widget.id),
              ),
              Positioned(
                  top: 600.h, child: Container(color: Colors.red, height: 20)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 500.h),
                  // alignment: Alignment.bottomCenter,
                  height: 259.h,
                  decoration: BoxDecoration(
                      color: my_black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(25.r, 25.r),
                        topRight: Radius.elliptical(25.r, 25.r),
                      )),
                ),
              ),
              Positioned(
                top: 470.h,
                right: 10.w,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PanierScreen(
                        idCmd: widget.id,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text("Plus de détails",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: my_green)),
                      SizedBox(
                        width: 20.w,
                      ),
                      SvgPicture.asset("icons/forward.svg",
                          fit: BoxFit.fill, color: my_green),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 190.h,
                  left: 36.w,
                  child: ContactLivreurWidget(id: widget.id)),
              Positioned(
                bottom: 0.h,
                child: isLoading
                    ? const SizedBox()
                    : SuivicmdWidget(
                        position: position,
                        idCmd: widget.id,
                        numCmd: numCmd,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
