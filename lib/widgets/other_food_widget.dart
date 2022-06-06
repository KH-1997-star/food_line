import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/DetailsCategorie/detail_category_screen.dart';
import 'package:food_line/screens/ListeMenu/detail_category_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/costum_page_route.dart';
import 'package:food_line/widgets/exclusive_food_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/widgets/panier_restant_widget.dart';
import 'package:page_transition/page_transition.dart';

class OtherFoodWidget extends ConsumerStatefulWidget {
  final String strPath;
  final String menuName;
  final String marketPath;
  final String idResto;
  final bool? dispo;
  final int? qteMax;
  final int? qteRestante;
  final bool? like;

  const OtherFoodWidget(
      {required this.strPath,
      required this.menuName,
      required this.marketPath,
      required this.idResto,
      required this.dispo,
      this.qteMax,
      this.like,
      this.qteRestante,
      Key? key})
      : super(key: key);

  @override
  _OtherFoodWidgetState createState() => _OtherFoodWidgetState();
}

class _OtherFoodWidgetState extends ConsumerState<OtherFoodWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("HElooooooooo kikouuuu");
    print(widget.idResto);
    print(widget.like);
    print(widget.dispo);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print("hellloooooooo");
        final viewModel = ref.read(menuProvider);
        await viewModel.listeMenu(widget.idResto).then((value) {
          print("NOWW HERRRE");
          print(viewModel.listMenu);
          print(viewModel.listMenu?.length);
          int numTab = viewModel.listMenu?.length ?? 0;
          Navigator.push(
            context,
            PageTransition(
              child: MenutScreen(
                  dispo: widget.dispo,
                  numab: numTab,
                  id: widget.idResto,
                  img: widget.strPath,
                  name: widget.menuName,
                  like: widget.like,
                  qteRest: widget.qteRestante),
              type: PageTransitionType.leftToRightWithFade,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              reverseDuration: const Duration(microseconds: 500),
            ),
          );
        });

        // Navigator.pushNamed(context, "/detailCategory");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 255.h,
              ),
              ExclusiveFoodWidget(myWidth: 358.w, myPath: widget.strPath),
              Padding(
                padding: EdgeInsets.only(left: 5.w),
              ),
              Positioned(
                top: 194.h,
                right: 35,
                child: Container(
                  height: 36.w,
                  width: 36.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0.r),
                    child: Image.network(
                      widget.marketPath,
                    ),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 180.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.menuName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     SvgPicture.asset('icons/little_clock.svg'),
                      //     SizedBox(
                      //       width: 5.w,
                      //     ),
                      //     Text(
                      //       '20min-30min',
                      //       style: TextStyle(
                      //         fontSize: 10.sp,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 3.6.h,
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       color: Color(0xffFFC529),
                      //       size: 15.w,
                      //     ),
                      //     SizedBox(
                      //       width: 2.5.w,
                      //     ),
                      //     Text(
                      //       '3,8',
                      //       style: TextStyle(
                      //         fontSize: 13.sp,
                      //         color: Color(0xffFFC529),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 2.w,
                      //     ),
                      //     Text(
                      //       '(+20 avis)',
                      //       style: TextStyle(
                      //         fontSize: 13.sp,
                      //         color: Color(0xffAFAFAF),
                      //       ),
                      //     )
                      // ],
                      //     )
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: !widget.dispo! ? 80.w : 20.w,
                  top: widget.dispo! ? 154.h : 124.h,
                  child: widget.dispo!
                      ? PanierRestantsWidget(
                          nombrePanier: 5,
                          qtMax: widget.qteMax,
                          qtRest: widget.qteRestante,
                        )
                      : Image.asset(
                          'icons/epuise.png',
                          width: 80.w,
                          height: 80.h,
                        ))
              // Positioned(
              //   right: 20,
              //   top: 154.h,
              //   child: PanierRestantsWidget(
              //     nombrePanier: 5,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
