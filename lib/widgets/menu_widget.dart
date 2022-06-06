import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/DetailsPlat/detail_plat.dart';
import 'package:food_line/screens/ListeMenu/liste_menu_repo.dart';
import 'package:food_line/screens/ListeMenu/detail_category_screen.dart';
import 'package:food_line/screens/home_screen.dart';
import 'package:food_line/utils/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

final menuProvider = ChangeNotifierProvider<MenuNotifier>(
  (ref) => MenuNotifier(),
);

class MenuWidget extends ConsumerStatefulWidget {
  final int? indexOne;
  final String? id;
  final String? imagee;
  final String? idResto;
  final String? name;
  final int? numab;
  final bool? dispo;
  final bool? like;
  final int? rest;

  MenuWidget(
      {this.indexOne,
      this.dispo,
      this.id,
      this.imagee,
      this.idResto,
      this.name,
      this.numab,
      this.like,
      this.rest});
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends ConsumerState<MenuWidget> {
  bool isloading = true;
  String? idSpecialite;
  getListeMenu() async {
    print("iciiiiii=====================>");
    print(widget.id);
    final viewModel = ref.read(menuProvider);
    await viewModel.listeMenu(widget.id).then((value) {
      isloading = false;
    });
  }

  @override
  void initState() {
    getListeMenu();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(menuProvider);

    print("iciiiiii   2222222222222222222=====================>");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        return false;
      },
      child: Scaffold(
        body: viewModel.listMenu == null || isloading
            ? Center(
                child: Container(
                    child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: LoadingIndicator(
                      color: my_green,
                      indicatorType: Indicator.ballRotateChase,
                    ),
                  ),
                )),
              )
            : Container(
                padding: EdgeInsets.only(left: 36.w),
                child: ListView.separated(
                  separatorBuilder: (context, child) => SizedBox(
                    height: 10.h,
                  ),
                  primary: true,
                  itemCount: viewModel
                          .listMenu?[widget.indexOne ?? 0].listeMenus?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailsPlatScreen(
                                idResto: widget.idResto,
                                name: widget.name,
                                numab: widget.numab,
                                img: widget.imagee ?? "",
                                id: viewModel.listMenu?[widget.indexOne ?? 0]
                                        .listeMenus?[index].identifiant ??
                                    "",
                                dispo: widget.dispo,
                                like: widget.like,
                                rest: widget.rest),
                            type: PageTransitionType.bottomToTop,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                            reverseDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Container(
                          height: 91.h,
                          width: 375.w,
                          child: Row(
                            children: [
                              Container(
                                width: 201.w,
                                child: Column(
                                  children: [
                                    Container(
                                        width: 200.w,
                                        child: Text(
                                            viewModel
                                                    .listMenu?[widget.indexOne!]
                                                    .listeMenus?[index]
                                                    .titre ??
                                                "",
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.sp,
                                            ))),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              viewModel
                                                      .listMenu?[
                                                          widget.indexOne ?? 0]
                                                      .listeMenus?[index]
                                                      .prix
                                                      .toString() ??
                                                  "" + "€",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14.sp,
                                              )),
                                          Text("€",
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14.sp,
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Expanded(
                                      child: Text(
                                          viewModel
                                                  .listMenu?[
                                                      widget.indexOne ?? 0]
                                                  .listeMenus?[index]
                                                  .description ??
                                              "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 12.sp,
                                              color: my_hint)),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 27.w,
                              ),
                              Image.network(
                                viewModel.listMenu?[widget.indexOne ?? 0]
                                        .listeMenus?[index].image ??
                                    "",
                                height: 100.h,
                                width: 100.w,
                                fit: BoxFit.cover,
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
