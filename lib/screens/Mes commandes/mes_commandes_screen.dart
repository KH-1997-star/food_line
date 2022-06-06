import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/screens/Mes%20commandes/commande_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/center_footer_widget.dart';
import 'package:food_line/widgets/commande_widget.dart';
import 'package:food_line/widgets/footer_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

final commandeProvider = ChangeNotifierProvider<CommandeNotifier>(
  (ref) => CommandeNotifier(),
);

class MesCommandeScreen extends ConsumerStatefulWidget {
  const MesCommandeScreen({Key? key}) : super(key: key);

  @override
  _MesCommandeScreenState createState() => _MesCommandeScreenState();
}

class _MesCommandeScreenState extends ConsumerState<MesCommandeScreen> {
  bool goToMenu = false;
  bool isLoading = true;

  getCommande() {
    var viewmodel = ref.read(commandeProvider);
    viewmodel.listCommande(context).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getCommande();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.read(commandeProvider);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home_screen');
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
                    onTap: () => Navigator.pushNamed(context, '/home_screen'),
                  ),
                  SizedBox(
                    width: 54.w,
                  ),
                  Text(
                    'Mes commandes',
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 115.h),
            //   child: CommandeWidget(),
            // ),
            Container(
                padding: EdgeInsets.only(top: 115.h),
                child: isLoading
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
                        ))
                    : CommandeWidget())
          ],
        )),
      ),
    );
  }
}
