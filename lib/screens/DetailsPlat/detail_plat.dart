import 'dart:ui';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/models/selected_detail_menu.dart';
import 'package:food_line/models/user.dart';
import 'package:food_line/screens/DetailsPlat/detail_plat_repo.dart';
import 'package:food_line/screens/ListeMenu/detail_category_screen.dart';
import 'package:food_line/screens/Panier/panier_repo.dart';
import 'package:food_line/screens/Panier/panier_screen.dart';
import 'package:food_line/screens/location_command_screen.dart';
import 'package:food_line/screens/login/signin_repo.dart';
import 'package:food_line/screens/login/signup_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/const.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/custom_input.dart';
import 'package:food_line/widgets/custom_input_pwd.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/widgets/vertical_counter_widget.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

import 'list_radio.dart';

final detailMenuProvider = ChangeNotifierProvider<DetailMenuNotifier>(
  (ref) => DetailMenuNotifier(),
);
final panierProvider = ChangeNotifierProvider<PanierNotifier>(
  (ref) => PanierNotifier(),
);

class DetailsPlatScreen extends ConsumerStatefulWidget {
  final String? id;
  final String? img;
  final bool? ispanier;
  final String? idpanier;
  final String? idMenuPanier;
  final int? qtUpdate;
  final bool? dispo;
  final bool? like;
  final String? idResto;
  final String? name;
  final int? numab;
  final int? rest;

  const DetailsPlatScreen(
      {Key? key,
      this.dispo = true,
      this.idResto,
      this.name,
      this.numab,
      this.id,
      this.rest,
      this.qtUpdate,
      this.idpanier,
      this.idMenuPanier,
      this.img,
      this.like,
      this.ispanier = false})
      : super(key: key);

  @override
  _DetailsPlatScreenState createState() => _DetailsPlatScreenState();
}

class _DetailsPlatScreenState extends ConsumerState<DetailsPlatScreen>
    with AutomaticKeepAliveClientMixin<DetailsPlatScreen> {
  dynamic? totalPrice;
  List menuList = [];
  List<Taille> tailleList = [];
  List<Boison> sauceList = [];
  List<Boison> viandeList = [];
  List<Boison> garnitureList = [];
  List<Boison> boisonList = [];
  List tailleListAll = [];
  List sauceListAll = [];
  List viandeListAll = [];
  List garnitureListAll = [];
  List boisonListAll = [];
  List<bool> taillebool = [true, true, false];
  List<bool> getMyList(int l) {
    List<bool> myList = [];
    for (int i = 0; i < l; i++) {
      myList.add(false);
    }
    return myList;
  }

  dynamic? prixPanier;
  List<bool> myBoolListSauce = [];
  List<bool> myBoolListViande = [];
  List<bool> myBoolListGarniture = [];
  List<bool> myBoolListBoisson = [];
  int qte = 1;
  int? qtUpdate;
  @override
  void initState() {
    print("Quantiteeeee restante ${widget.rest}");
    qtUpdate = widget.qtUpdate ?? 1;
    print('idddddkhaaaaayriiiiii');
    print(widget.id ?? "");
    print('ICIIII SELECTED');
    widget.ispanier! ? getDetailSelected() : getdetailMenu();
    print("===============================>Detail Plat");

    super.initState();

    setState(() {});
  }

  double? prixMenu = 0;
  List<String> listeExtra = [
    "Tailles",
    "Suaces",
    "Viandes",
    "Garnitures",
    "Boisons",
    "Autres"
  ];
  bool isloading = true;
  String? idSpecialite;
  bool isCompleted = true;
  dynamic? prixPanierMenu;
  List<bool> checkedList = [];

  getDetailSelected() async {
    final viewModel = ref.read(panierProvider);
    await viewModel.getPanierSelected(widget.idpanier, context).then((value) {
      setState(() {
        qtePanier =
            int.parse(viewModel.listMenuSelected?[0].quantite.toString() ?? "");
        prixPanier = viewModel.listMenuSelected?[0].prixTtc ?? 0;
        prixPanierMenu = prixPanier / qtePanier;
        print("PRIIIIIIIIIXXXXXXX PANIER");
        print(prixPanierMenu);
        qtselTaille = viewModel.listMenuSelected![0].tailles!.length;
        qtselSauce = viewModel.listMenuSelected![0].sauces!.length;
        qtselboisson = viewModel.listMenuSelected![0].boisons!.length;
        qtselgarniture = viewModel.listMenuSelected![0].garnitures!.length;
        qtselviande = viewModel.listMenuSelected![0].viandes!.length;
        print(qtselboisson);
      });
      for (int i = 0;
          i < viewModel.listMenuSelected![0].tailles!.length;
          i += 1) {
        print('ICIIII SELECTED123456');
        tailleListAll.add(viewModel.listMenuSelected?[0].tailles?[i].id);
        tailleList.add(viewModel.listMenuSelected![0].tailles![i]);
      }
      for (int i = 0;
          i < viewModel.listMenuSelected![0].sauces!.length;
          i += 1) {
        sauceListAll.add(viewModel.listMenuSelected?[0].sauces?[i].id);
        print(viewModel.listMenuSelected?[0].sauces?[i].id);
        sauceList.add(viewModel.listMenuSelected![0].sauces![i]);
      }
      for (int i = 0;
          i < viewModel.listMenuSelected![0].viandes!.length;
          i += 1) {
        viandeListAll.add(viewModel.listMenuSelected?[0].viandes?[i].id);
        print(viewModel.listMenuSelected?[0].viandes?[i].id);

        viandeList.add(viewModel.listMenuSelected![0].viandes![i]);
      }
      for (int i = 0;
          i < viewModel.listMenuSelected![0].garnitures!.length;
          i += 1) {
        garnitureListAll.add(viewModel.listMenuSelected?[0].garnitures?[i].id);
        print(viewModel.listMenuSelected?[0].garnitures?[i].id);

        garnitureList.add(viewModel.listMenuSelected![0].garnitures![i]);
      }
      for (int i = 0;
          i < viewModel.listMenuSelected![0].boisons!.length;
          i += 1) {
        boisonListAll.add(viewModel.listMenuSelected?[0].boisons?[i].id);
        boisonList.add(viewModel.listMenuSelected![0].boisons![i]);
      }
    });
    print(tailleListAll);
    getdetailMenu();
  }

  int? qtePanier;
  getdetailMenu() async {
    final viewModel = ref.read(detailMenuProvider);
    await viewModel.getDetailMenu(widget.id).then((value) {
////////Set Initial price
      setState(() {
        prixMenu = viewModel.detailMenu?[0].prix ?? 0;

        totalPrice = viewModel.detailMenu?[0].prix ?? 0;
      });

      viewModel.detailMenu?[0].tailles!.length == 0
          ? checkedList = []
          : checkedList =
              getMyList(viewModel.detailMenu?[0].tailles!.length ?? 0);
      print(checkedList);
      viewModel.detailMenu?[0].sauces!.length == 0
          ? myBoolListSauce = []
          : myBoolListSauce = getMyList(
              viewModel.detailMenu?[0].sauces?[0].produits?.length ?? 0);
      print(myBoolListSauce);
      print(viewModel.detailMenu?[0].viandes!.length == 0);
      viewModel.detailMenu?[0].viandes!.length == 0
          ? myBoolListViande = []
          : myBoolListViande = getMyList(
              viewModel.detailMenu?[0].viandes?[0].produits?.length ?? 0);
      print(myBoolListViande);
      viewModel.detailMenu?[0].garnitures!.length == 0
          ? myBoolListGarniture = []
          : myBoolListGarniture = getMyList(
              viewModel.detailMenu?[0].garnitures?[0].produits?.length ?? 0);
      viewModel.detailMenu?[0].boisons!.length == 0
          ? myBoolListBoisson = []
          : myBoolListBoisson = getMyList(
              viewModel.detailMenu?[0].boisons?[0].produits?.length ?? 0);
      if (widget.ispanier!) {
        int len = 0;
        viewModel.detailMenu?[0].tailles!.length != 0
            ? len = viewModel.detailMenu![0].tailles!.length
            : len = 0;
        int lensauce = 0;
        viewModel.detailMenu?[0].sauces!.length != 0
            ? lensauce = viewModel.detailMenu![0].sauces![0].produits!.length
            : lensauce = 0;
        int lenviande = 0;
        viewModel.detailMenu?[0].viandes!.length != 0
            ? lenviande = viewModel.detailMenu![0].viandes![0].produits!.length
            : lenviande;
        int lengar = 0;
        viewModel.detailMenu?[0].garnitures!.length != 0
            ? lengar = viewModel.detailMenu![0].garnitures![0].produits!.length
            : lengar;
        int lenboisson = 0;
        viewModel.detailMenu?[0].boisons!.length != 0
            ? lenboisson = viewModel.detailMenu![0].boisons![0].produits!.length
            : lenboisson;
        print(lensauce);

        if (viewModel.detailMenu?[0].tailles?.length != 0) {
          for (int i = 0; i < len; i += 1) {
            print("===========================>Start");
            print(tailleListAll);
            if (tailleListAll.contains(
                viewModel.detailMenu?[0].tailles?[i].id.toString() ?? "")) {
              checkedList[i] = true;
            } else {
              checkedList[i] = false;
            }
          }
        }

        print(lensauce);
        print(lensauce != 0);
        print('ALLLLLLLLSAUCCEEEEEE');
        print(sauceListAll);
        if (lensauce != 0) {
          print("===========================>Start Suace");
          print(lensauce);
          for (int i = 0; i < lensauce; i += 1) {
            print("===========================>Start");
            //sauceListAll.add(viewModel.detailMenu?[0].sauces?[0].produits?[i].id);
            if (sauceListAll.contains(viewModel
                    .detailMenu?[0].sauces?[0].produits?[i].id
                    .toString() ??
                "")) {
              myBoolListSauce[i] = true;
            } else {
              myBoolListSauce[i] = false;
            }
          }
          print('booolliste Sauuuuuuce');
          print(myBoolListSauce);
        }

        print("===========================>Sauce Save");
        // print(sauceListAll.first);
        if (viewModel.detailMenu?[0].viandes?.length != 0) {
          for (int i = 0; i < lenviande; i += 1) {
            // sauceListAll.add(viewModel.detailMenu?[0].viandes?[0].produits?[i].id);
            if (viandeListAll.contains(viewModel
                    .detailMenu?[0].viandes?[0].produits?[i].id
                    .toString() ??
                "")) {
              myBoolListViande[i] = true;
            } else {
              myBoolListViande[i] = false;
            }
          }
        }
        print("===========================>Viande Save");
        print(viewModel.detailMenu?[0].garnitures?.length);
        print(lengar);
        if (viewModel.detailMenu?[0].garnitures?.length != 0) {
          for (int i = 0; i < lengar; i += 1) {
            // garnitureListAll
            //   .add(viewModel.detailMenu?[0].garnitures?[0].produits?[i].id);
            if (garnitureListAll.contains(viewModel
                    .detailMenu?[0].garnitures?[0].produits?[i].id
                    .toString() ??
                "")) {
              myBoolListGarniture[i] = true;
            } else {
              myBoolListGarniture[i] = false;
            }
          }
        }
        print("===========================>Boisson Save");
        print(lenboisson);
        if (viewModel.detailMenu?[0].boisons?.length != 0) {
          for (int i = 0; i < lenboisson; i += 1) {
            print(boisonListAll);
            // boisonListAll.add(viewModel.detailMenu?[0].boisons?[0].produits?[i].id);
            if (boisonListAll.contains(viewModel
                    .detailMenu?[0].boisons?[0].produits?[i].id
                    .toString() ??
                "")) {
              myBoolListBoisson[i] = true;
            } else {
              myBoolListBoisson[i] = false;
            }
          }
        }
      }
      print("===========================>End");
      print("LIIIIIISTE ");
      print(tailleListAll);
      print("kikouuuuuuuu");
      print(tailleListAll);
      print(viewModel.detailMenu?[0] ?? "");
      setState(() {
        isloading = false;
        isCompleted = false;
      });
    });
    print("===========================>");
    print(tailleList.toString());
    print(sauceList.toString());
    print(viandeList.toString());
    print(garnitureList.toString());
    print(boisonList.toString());
    print(checkedList);
    print(myBoolListBoisson);
    print(myBoolListViande);
    print(myBoolListSauce);
    print(myBoolListGarniture);
    print("===========================>");
  }

  int qtselSauce = 0;
  int qtselviande = 0;
  int qtselboisson = 0;
  int qtselgarniture = 0;
  int qtselautre = 0;
  int qtselTaille = 0;
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    print('ohlalalalalal');
    print(checkedList);
    print(myBoolListBoisson);
    print(myBoolListViande);
    print(myBoolListSauce);
    print(myBoolListGarniture);
    Size size = MediaQuery.of(context).size;
    final viewModel = ref.read(detailMenuProvider);
    final ViewModelPanier = ref.read(panierProvider);
    return viewModel.detailMenu == null || isCompleted
        ? Container(
            color: my_white,
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
        : WillPopScope(
            onWillPop: () async {
              widget.ispanier!
                  ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => LocationCommand()),
                      (Route<dynamic> route) => false)
                  : Navigator.push(
                      context,
                      PageTransition(
                        child: MenutScreen(
                          numab: widget.numab,
                          id: widget.idResto,
                          img: widget.img,
                          name: widget.name,
                          like: widget.like,
                          qteRest: widget.rest,
                        ),
                        type: PageTransitionType.leftToRightWithFade,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        reverseDuration: const Duration(microseconds: 500),
                      ),
                    );
              return false;
            },
            child: Scaffold(
              body: Container(
                  color: my_white,
                  height: size.height,
                  width: size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0.h,
                        right: 0.w,
                        left: 0.w,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.network(
                              viewModel.detailMenu?[0].image ?? "",
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                            return Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                            );
                          },
                              fit: BoxFit.fill,
                              colorBlendMode: BlendMode.darken),
                        ),
                      ),
                      Column(
                        children: [
                          Container(height: 76.h, color: Colors.transparent),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0.r),
                              topRight: Radius.circular(25.0.r),
                            ),
                            child: Container(
                              height: 736.h,
                              color: my_white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 36.h,
                                    left: 36.w,
                                    child: MyWidgetButton(
                                        radius: 15.sp,
                                        widget: Container(
                                          child: SvgPicture.asset(
                                            'images/arrowback.svg',
                                            color: my_white,
                                            height: 3.h,
                                            width: 3.w,
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                        color: my_green,
                                        onTap: () {
                                          widget.ispanier!
                                              ? Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LocationCommand()),
                                                      (Route<dynamic> route) =>
                                                          false)
                                              : Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: MenutScreen(
                                                      numab: widget.numab,
                                                      id: widget.idResto,
                                                      img: widget.img,
                                                      name: widget.name,
                                                      like: widget.like,
                                                      qteRest: widget.rest,
                                                    ),
                                                    type: PageTransitionType
                                                        .leftToRightWithFade,
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.decelerate,
                                                    reverseDuration:
                                                        const Duration(
                                                            microseconds: 500),
                                                  ),
                                                );
                                        }),
                                  ),
                                  Positioned(
                                    top: 43.h,
                                    left: 90.w,
                                    child: Container(
                                      child: Text(
                                        viewModel.detailMenu?[0].titre ?? "",
                                        style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 643.h,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 100.h,
                                          ),
                                          Container(
                                            //height: 50,
                                            child: Image.network(
                                              viewModel.detailMenu?[0].image ??
                                                  "",
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                return Container(
                                                  color: Colors.black,
                                                  alignment: Alignment.center,
                                                );
                                              },
                                              height: 145.h,
                                              width: 225.w,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: 303.w,
                                                child: Text(
                                                    viewModel.detailMenu?[0]
                                                            .titre ??
                                                        "",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Container(
                                                  width: 303.w,
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      viewModel.detailMenu?[0]
                                                              .description ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: TextStyle(
                                                        color: my_hint,
                                                        fontFamily: "Roboto",
                                                        fontSize: 14.sp,
                                                      )))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                          ),
                                          Expanded(
                                              // height: 300,
                                              child: ListView(
                                                  padding: EdgeInsets.zero,
                                                  children: [
                                                Column(
                                                  children: [
                                                    viewModel
                                                                .detailMenu?[0]
                                                                .tailles
                                                                ?.isEmpty ==
                                                            true
                                                        ? const SizedBox()
                                                        : Container(
                                                            height: 40,
                                                            color:
                                                                my_white_grey,
                                                            width: size.width,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        36.w),
                                                                Text(
                                                                    "Tailles :",
                                                                    style: TextStyle(
                                                                        color:
                                                                            my_black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                    SizedBox(height: 10.h),
                                                    SizedBox(
                                                      width: 303.w,
                                                      child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        addAutomaticKeepAlives:
                                                            wantKeepAlive,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Affiche_grille(
                                                            onChecked: () {
                                                              setState(() {
                                                                print(
                                                                    checkedList[
                                                                        index]);
                                                                checkedList[
                                                                        index] =
                                                                    !checkedList[
                                                                        index];
                                                              });
                                                              return checkedList[
                                                                  index];
                                                            },
                                                            checked:
                                                                checkedList[
                                                                    index],
                                                            stopChecking:
                                                                (qtselTaille <
                                                                    1),
                                                            qtSelected:
                                                                qtselTaille
                                                                    .toString(),
                                                            onSelect: (v) {
                                                              setState(() {
                                                                qtselTaille +=
                                                                    v;
                                                                print(
                                                                    qtselTaille);
                                                              });
                                                              print("1");
                                                              int ent = 1;
                                                              print(ent <
                                                                  qtselTaille);
                                                            },
                                                            qtmax: "1",
                                                            prix: viewModel
                                                                    .detailMenu?[
                                                                        0]
                                                                    .tailles?[
                                                                        index]
                                                                    .prix
                                                                    .toString() ??
                                                                "",
                                                            supp: viewModel
                                                                    .detailMenu?[
                                                                        0]
                                                                    .tailles?[
                                                                        index]
                                                                    ?.name ??
                                                                "",
                                                            onMenuChoose:
                                                                (burger, add) {
                                                              if (add) {
                                                                tailleList.add(Taille(
                                                                    id: viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .tailles?[
                                                                            index]
                                                                        ?.id,
                                                                    prix: viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .tailles?[
                                                                            index]
                                                                        ?.prix,
                                                                    name: viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .tailles?[
                                                                            index]
                                                                        ?.name));
                                                                print(
                                                                    tailleList);
                                                                setState(() {
                                                                  if (widget
                                                                      .ispanier!) {
                                                                    prixPanierMenu =
                                                                        prixPanierMenu +
                                                                            (double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                                ""));
                                                                    prixPanier =
                                                                        (qtePanier! *
                                                                            double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                                ""));
                                                                  } else {
                                                                    prixMenu = (double.parse(viewModel
                                                                            .detailMenu?[0]
                                                                            .tailles?[index]
                                                                            .prix
                                                                            .toString() ??
                                                                        ""));
                                                                    totalPrice = (qte *
                                                                        double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                            ""));
                                                                    // if (prixMenu ==
                                                                    //     double.parse(viewModel
                                                                    //             .detailMenu?[0]
                                                                    //             .tailles?[index]
                                                                    //             .prix
                                                                    //             .toString() ??
                                                                    //         "")) {
                                                                    //   prixMenu =
                                                                    //       prixMenu;
                                                                    //   totalPrice =
                                                                    //       totalPrice;
                                                                    // } else {
                                                                    //   totalPrice = qte *
                                                                    //       double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                    //           "");
                                                                    //   prixMenu = double.parse(viewModel
                                                                    //           .detailMenu?[0]
                                                                    //           .sauces?[0]
                                                                    //           ?.produits?[index]
                                                                    //           .prixFacculatitf
                                                                    //           .toString() ??
                                                                    //       "");
                                                                    // }
                                                                  }

                                                                  // widget.ispanier!
                                                                  //     ? prixPanierMenu = prixPanier = prixPanier +
                                                                  //         (qtePanier! *
                                                                  //             double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                  //                 ""))
                                                                  //     : totalPrice = prixMenu ==
                                                                  //             double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                  //                 "")
                                                                  //         ? prixMenu =
                                                                  //             prixMenu
                                                                  //         : prixMenu =
                                                                  //             double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                  //                 "");
                                                                });
                                                              } else {
                                                                tailleList.removeWhere((element) =>
                                                                    element
                                                                        .id ==
                                                                    viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .tailles?[
                                                                            index]
                                                                        .id);
                                                                print(
                                                                    "REMOVE TAILLLLLLLE");
                                                                setState(() {
                                                                  if (!widget
                                                                      .ispanier!) {
                                                                    prixMenu = prixMenu! -
                                                                        (double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                            ""));
                                                                    totalPrice =
                                                                        totalPrice! -
                                                                            (qte *
                                                                                double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ?? ""));
                                                                  } else {
                                                                    prixPanierMenu =
                                                                        prixPanierMenu -
                                                                            (double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ??
                                                                                ""));
                                                                    prixPanier =
                                                                        prixPanier -
                                                                            (qtePanier! *
                                                                                double.parse(viewModel.detailMenu?[0].tailles?[index].prix.toString() ?? ""));
                                                                  }
                                                                });
                                                                print(tailleList
                                                                    .toList()
                                                                    .toString());
                                                              }
                                                            },
                                                          );
                                                        },
                                                        itemCount: viewModel
                                                                .detailMenu?[0]
                                                                .tailles
                                                                ?.length ??
                                                            0,
                                                        // scrollDirection: Axis.vertical,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                viewModel.detailMenu?[0].sauces
                                                            ?.isEmpty ==
                                                        true
                                                    ? const SizedBox()
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            color:
                                                                my_white_grey,
                                                            width: size.width,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        36.w),
                                                                Text("Sauces :",
                                                                    style: TextStyle(
                                                                        color:
                                                                            my_black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          SizedBox(
                                                            width: 303.w,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,

                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Affiche_grille(
                                                                  onChecked:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      myBoolListSauce[
                                                                              index] =
                                                                          !myBoolListSauce[
                                                                              index];
                                                                    });
                                                                    return myBoolListSauce[
                                                                        index];
                                                                  },
                                                                  prix: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .sauces?[
                                                                              0]
                                                                          .produits?[
                                                                              index]
                                                                          .prixFacculatitf
                                                                          .toString() ??
                                                                      "",
                                                                  checked:
                                                                      myBoolListSauce[
                                                                          index],
                                                                  stopChecking: (qtselSauce <
                                                                      int.parse(viewModel
                                                                              .detailMenu?[0]
                                                                              .sauces?[0]
                                                                              .qteMax
                                                                              .toString() ??
                                                                          "")),
                                                                  qtmax: viewModel
                                                                      .detailMenu?[
                                                                          0]
                                                                      .sauces?[
                                                                          0]
                                                                      .qteMax
                                                                      .toString(),
                                                                  qtSelected:
                                                                      qtselSauce
                                                                          .toString(),
                                                                  supp: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .sauces?[
                                                                              0]
                                                                          ?.produits?[
                                                                              index]
                                                                          .name ??
                                                                      "",
                                                                  onMenuChoose:
                                                                      (burger,
                                                                          add) {
                                                                    if (add) {
                                                                      print(
                                                                          "ADDDDDD");
                                                                      sauceList.add(Boison(
                                                                          qte:
                                                                              1,
                                                                          prixFacculatitf: viewModel
                                                                              .detailMenu?[
                                                                                  0]
                                                                              .sauces?[
                                                                                  0]
                                                                              ?.produits?[
                                                                                  index]
                                                                              .prixFacculatitf,
                                                                          id: viewModel
                                                                              .detailMenu?[0]
                                                                              .sauces?[0]
                                                                              ?.produits?[index]
                                                                              .id));
                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            'Calcul========>');
                                                                        print(
                                                                            prixMenu);
                                                                        print(double.parse(viewModel.detailMenu?[0].sauces?[0]?.produits?[index].prixFacculatitf.toString() ??
                                                                            ""));
                                                                        print(
                                                                            'Calcul========>');
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu + (qtePanier! * double.parse(viewModel.detailMenu?[0].sauces?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanierMenu =
                                                                              prixPanierMenu + (qtePanier! * double.parse(viewModel.detailMenu?[0].sauces?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              qte * double.parse(viewModel.detailMenu?[0].sauces?[0]?.produits?[index].prixFacculatitf.toString() ?? "") + totalPrice!;
                                                                          prixMenu =
                                                                              qte * double.parse(viewModel.detailMenu?[0].sauces?[0]?.produits?[index].prixFacculatitf.toString() ?? "") + prixMenu!;
                                                                        }
                                                                      });
                                                                    } else {
                                                                      print(
                                                                          "REMOVE TAILLLLLLLE");
                                                                      sauceList.removeWhere((element) =>
                                                                          element
                                                                              .id ==
                                                                          viewModel
                                                                              .detailMenu?[0]
                                                                              .sauces?[0]
                                                                              ?.produits?[index]
                                                                              .id);

                                                                      print(
                                                                          "REMOVE TAILLLLLLLE");

                                                                      print(sauceList
                                                                          .toList()
                                                                          .toString());

                                                                      // sauceList
                                                                      //     .remove({
                                                                      //   "qte":
                                                                      //       qtselSauce,
                                                                      //   "prixFacculatitf": viewModel
                                                                      //       .detailMenu?[0]
                                                                      //       .sauces?[0]
                                                                      //       ?.produits?[index]
                                                                      //       .prixFacculatitf,
                                                                      //   "id": viewModel
                                                                      //       .detailMenu?[0]
                                                                      //       .sauces?[0]
                                                                      //       ?.produits?[index]
                                                                      //       .id
                                                                      // });
                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu - (qtePanier! * double.parse(viewModel.detailMenu?[0].sauces?[0].produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier - (qtePanier! * double.parse(viewModel.detailMenu?[0].sauces?[0].produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! - qte * double.parse(viewModel.detailMenu?[0].sauces?[0].produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              qte * prixMenu! - double.parse(viewModel.detailMenu?[0].sauces?[0].produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    }
                                                                  },
                                                                  onSelect:
                                                                      (v) {
                                                                    setState(
                                                                        () {
                                                                      qtselSauce +=
                                                                          v;
                                                                      print(
                                                                          qtselSauce);
                                                                    });
                                                                    print("1");
                                                                    int ent = 1;
                                                                    print(ent <
                                                                        qtselSauce);
                                                                  },
                                                                );
                                                              },
                                                              itemCount: viewModel
                                                                  .detailMenu?[
                                                                      0]
                                                                  .sauces?[0]
                                                                  .produits
                                                                  ?.length,
                                                              // scrollDirection: Axis.vertical,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                viewModel.detailMenu?[0].viandes
                                                            ?.isEmpty ==
                                                        true
                                                    ? const SizedBox()
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            color:
                                                                my_white_grey,
                                                            width: size.width,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        36.w),
                                                                Text(
                                                                    "Viandes :",
                                                                    style: TextStyle(
                                                                        color:
                                                                            my_black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          SizedBox(
                                                            width: 303.w,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,

                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                List<
                                                                    bool> myBoolList = getMyList(viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .viandes?[
                                                                            0]
                                                                        .produits
                                                                        ?.length ??
                                                                    0);
                                                                return Affiche_grille(
                                                                  onChecked:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      myBoolListViande[
                                                                              index] =
                                                                          !myBoolListViande[
                                                                              index];
                                                                    });
                                                                    return myBoolListViande[
                                                                        index];
                                                                  },
                                                                  prix: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .viandes?[
                                                                              0]
                                                                          .produits?[
                                                                              index]
                                                                          .prixFacculatitf
                                                                          .toString() ??
                                                                      "",
                                                                  checked:
                                                                      myBoolListViande[
                                                                          index],
                                                                  stopChecking: (qtselviande <
                                                                      int.parse(viewModel
                                                                              .detailMenu?[0]
                                                                              .viandes?[0]
                                                                              .qteMax
                                                                              .toString() ??
                                                                          "")),
                                                                  qtmax: viewModel
                                                                      .detailMenu?[
                                                                          0]
                                                                      .viandes?[
                                                                          0]
                                                                      .qteMax
                                                                      .toString(),
                                                                  qtSelected:
                                                                      qtselviande
                                                                          .toString(),
                                                                  supp: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .viandes?[
                                                                              0]
                                                                          .produits?[
                                                                              index]
                                                                          .name ??
                                                                      "",
                                                                  onMenuChoose:
                                                                      (burger,
                                                                          add) {
                                                                    if (add) {
                                                                      print(
                                                                          "ADDDDDD VIANDEEEEE");
                                                                      viandeList.add(Boison(
                                                                          qte:
                                                                              1,
                                                                          prixFacculatitf: viewModel
                                                                              .detailMenu?[
                                                                                  0]
                                                                              .viandes?[
                                                                                  0]
                                                                              ?.produits?[
                                                                                  index]
                                                                              .prixFacculatitf,
                                                                          id: viewModel
                                                                              .detailMenu?[0]
                                                                              .viandes?[0]
                                                                              ?.produits?[index]
                                                                              .id));
                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu + (qtePanier! * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier + (qtePanier! * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! + qte * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              prixMenu! + qte * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    } else {
                                                                      print(
                                                                          "REMOVE VIANDEEEEE");
                                                                      viandeList.removeWhere((element) =>
                                                                          element
                                                                              .id ==
                                                                          viewModel
                                                                              .detailMenu?[0]
                                                                              .viandes?[0]
                                                                              ?.produits?[index]
                                                                              .id);

                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu - (qtePanier! * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier - (qtePanier! * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! - qte * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              prixMenu! - qte * double.parse(viewModel.detailMenu?[0].viandes?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    }
                                                                  },
                                                                  onSelect:
                                                                      (v) {
                                                                    setState(
                                                                        () {
                                                                      qtselviande +=
                                                                          v;
                                                                    });
                                                                    print(
                                                                        qtselviande);
                                                                    print(int.parse(viewModel
                                                                            .detailMenu?[0]
                                                                            .viandes?[0]
                                                                            .qteMax
                                                                            .toString() ??
                                                                        ""));
                                                                  },
                                                                );
                                                              },
                                                              itemCount: viewModel
                                                                  .detailMenu?[
                                                                      0]
                                                                  .viandes?[0]
                                                                  .produits
                                                                  ?.length,
                                                              // scrollDirection: Axis.vertical,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                viewModel
                                                            .detailMenu?[0]
                                                            .garnitures
                                                            ?.isEmpty ==
                                                        true
                                                    ? const SizedBox()
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            color:
                                                                my_white_grey,
                                                            width: size.width,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        36.w),
                                                                Text(
                                                                    "Garnitures :",
                                                                    style: TextStyle(
                                                                        color:
                                                                            my_black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          SizedBox(
                                                            width: 303.w,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,

                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                List<
                                                                    bool> myBoolList = getMyList(viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .garnitures?[
                                                                            0]
                                                                        .produits
                                                                        ?.length ??
                                                                    0);
                                                                return Affiche_grille(
                                                                  onChecked:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      myBoolListGarniture[
                                                                              index] =
                                                                          !myBoolListGarniture[
                                                                              index];
                                                                    });
                                                                    return myBoolListGarniture[
                                                                        index];
                                                                  },
                                                                  prix: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .garnitures?[
                                                                              0]
                                                                          .produits?[
                                                                              index]
                                                                          .prixFacculatitf
                                                                          .toString() ??
                                                                      "",
                                                                  checked:
                                                                      myBoolListGarniture[
                                                                          index],
                                                                  stopChecking: (qtselgarniture <
                                                                      int.parse(viewModel
                                                                              .detailMenu?[0]
                                                                              .garnitures?[0]
                                                                              .qteMax
                                                                              .toString() ??
                                                                          "")),
                                                                  qtmax: viewModel
                                                                      .detailMenu?[
                                                                          0]
                                                                      .garnitures?[
                                                                          0]
                                                                      .qteMax
                                                                      .toString(),
                                                                  qtSelected:
                                                                      qtselgarniture
                                                                          .toString(),
                                                                  supp: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .garnitures?[
                                                                              0]
                                                                          ?.produits?[
                                                                              index]
                                                                          .name ??
                                                                      "",
                                                                  onMenuChoose:
                                                                      (burger,
                                                                          add) {
                                                                    if (add) {
                                                                      garnitureList.add(Boison(
                                                                          qte:
                                                                              1,
                                                                          prixFacculatitf: viewModel
                                                                              .detailMenu?[
                                                                                  0]
                                                                              .garnitures?[
                                                                                  0]
                                                                              ?.produits?[
                                                                                  index]
                                                                              .prixFacculatitf,
                                                                          id: viewModel
                                                                              .detailMenu?[0]
                                                                              .garnitures?[0]
                                                                              ?.produits?[index]
                                                                              .id));
                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu + (qtePanier! * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier + (qtePanier! * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! + qte * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              prixMenu! + qte * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    } else {
                                                                      garnitureList.removeWhere((element) =>
                                                                          element
                                                                              .id ==
                                                                          viewModel
                                                                              .detailMenu?[0]
                                                                              .garnitures?[0]
                                                                              .produits?[index]
                                                                              .id);

                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu - (qtePanier! * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier - (qtePanier! * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! - qte * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              prixMenu! - qte * double.parse(viewModel.detailMenu?[0].garnitures?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    }
                                                                    print(
                                                                      garnitureList
                                                                          .join(
                                                                              ','),
                                                                    );
                                                                  },
                                                                  onSelect:
                                                                      (v) {
                                                                    setState(
                                                                        () {
                                                                      qtselgarniture +=
                                                                          v;
                                                                    });
                                                                    print(
                                                                        qtselgarniture);
                                                                    print(int.parse(viewModel
                                                                            .detailMenu?[0]
                                                                            .garnitures?[0]
                                                                            .qteMax
                                                                            .toString() ??
                                                                        ""));
                                                                    int ent = int.parse(viewModel
                                                                            .detailMenu?[0]
                                                                            .garnitures?[0]
                                                                            .qteMax
                                                                            .toString() ??
                                                                        "");
                                                                    print(ent <
                                                                        qtselgarniture);
                                                                  },
                                                                );
                                                              },
                                                              itemCount: viewModel
                                                                  .detailMenu?[
                                                                      0]
                                                                  .garnitures?[
                                                                      0]
                                                                  .produits
                                                                  ?.length,
                                                              // scrollDirection: Axis.vertical,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                viewModel.detailMenu?[0].boisons
                                                            ?.isEmpty ==
                                                        true
                                                    ? const SizedBox()
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            color:
                                                                my_white_grey,
                                                            width: size.width,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        36.w),
                                                                Text(
                                                                    "Boissons :",
                                                                    style: TextStyle(
                                                                        color:
                                                                            my_black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          SizedBox(
                                                            width: 303.w,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,

                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                List<
                                                                    bool> myBoolList = getMyList(viewModel
                                                                        .detailMenu?[
                                                                            0]
                                                                        .boisons?[
                                                                            0]
                                                                        .produits
                                                                        ?.length ??
                                                                    0);
                                                                return Affiche_grille(
                                                                  onChecked:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      myBoolListBoisson[
                                                                              index] =
                                                                          !myBoolListBoisson[
                                                                              index];
                                                                    });
                                                                    return myBoolListBoisson[
                                                                        index];
                                                                  },
                                                                  prix: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .boisons?[
                                                                              0]
                                                                          .produits?[
                                                                              index]
                                                                          .prixFacculatitf
                                                                          .toString() ??
                                                                      "",
                                                                  checked:
                                                                      myBoolListBoisson[
                                                                          index],
                                                                  stopChecking: (qtselboisson <
                                                                      int.parse(viewModel
                                                                              .detailMenu?[0]
                                                                              .boisons?[0]
                                                                              .qteMax
                                                                              .toString() ??
                                                                          "")),
                                                                  qtmax: viewModel
                                                                      .detailMenu?[
                                                                          0]
                                                                      .boisons?[
                                                                          0]
                                                                      .qteMax
                                                                      .toString(),
                                                                  qtSelected:
                                                                      qtselboisson
                                                                          .toString(),
                                                                  supp: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .boisons?[
                                                                              0]
                                                                          ?.produits?[
                                                                              index]
                                                                          .name ??
                                                                      "",
                                                                  onMenuChoose:
                                                                      (burger,
                                                                          add) {
                                                                    if (add) {
                                                                      boisonList.add(Boison(
                                                                          qte:
                                                                              1,
                                                                          prixFacculatitf: viewModel
                                                                              .detailMenu?[
                                                                                  0]
                                                                              .boisons?[
                                                                                  0]
                                                                              ?.produits?[
                                                                                  index]
                                                                              .prixFacculatitf,
                                                                          id: viewModel
                                                                              .detailMenu?[0]
                                                                              .boisons?[0]
                                                                              ?.produits?[index]
                                                                              .id));
                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu + (qtePanier! * double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier + (qtePanier! * double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              qte * totalPrice! + double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              qte * prixMenu! + double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    } else {
                                                                      print(
                                                                          "REMOVE Boisson");
                                                                      boisonList.removeWhere((element) =>
                                                                          element
                                                                              .id ==
                                                                          viewModel
                                                                              .detailMenu?[0]
                                                                              .boisons?[0]
                                                                              ?.produits?[index]
                                                                              .id);

                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            boisonList);
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu - (qtePanier! * double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier - (qtePanier! * double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              qte * totalPrice! - double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              qte * prixMenu! - double.parse(viewModel.detailMenu?[0].boisons?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    }
                                                                  },
                                                                  onSelect:
                                                                      (v) {
                                                                    setState(
                                                                        () {
                                                                      qtselboisson +=
                                                                          v;
                                                                    });
                                                                    print(
                                                                        qtselboisson);
                                                                  },
                                                                );
                                                              },
                                                              itemCount: viewModel
                                                                  .detailMenu?[
                                                                      0]
                                                                  .boisons?[0]
                                                                  .produits
                                                                  ?.length,
                                                              // scrollDirection: Axis.vertical,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                viewModel.detailMenu?[0].autres
                                                            ?.isEmpty ==
                                                        true
                                                    ? const SizedBox()
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            height: 40,
                                                            color:
                                                                my_white_grey,
                                                            width: size.width,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        36.w),
                                                                Text("Autres :",
                                                                    style: TextStyle(
                                                                        color:
                                                                            my_black,
                                                                        fontFamily:
                                                                            "Roboto",
                                                                        fontSize: 13
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 10.h),
                                                          SizedBox(
                                                            width: 303.w,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,

                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Affiche_grille(
                                                                  onChecked:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      print(
                                                                          'check check check');
                                                                      print(
                                                                          "kikouuuuuuuu=====>${myBoolListSauce[index]}");
                                                                      myBoolListSauce[
                                                                              index] =
                                                                          !myBoolListSauce[
                                                                              index];
                                                                    });
                                                                    return myBoolListSauce[
                                                                        index];
                                                                  },
                                                                  checked:
                                                                      checkedList[
                                                                          index],
                                                                  prix: viewModel
                                                                          .detailMenu?[
                                                                              0]
                                                                          .sauces?[
                                                                              0]
                                                                          .produits?[
                                                                              index]
                                                                          .prixFacculatitf
                                                                          .toString() ??
                                                                      "",
                                                                  supp: viewModel
                                                                      .detailMenu?[
                                                                          0]
                                                                      .autres?[
                                                                          index]
                                                                      .name,
                                                                  onMenuChoose:
                                                                      (burger,
                                                                          add) {
                                                                    if (add) {
                                                                      menuList
                                                                          .add({
                                                                        "qte":
                                                                            1,
                                                                        "prixFacculatitf": viewModel
                                                                            .detailMenu?[0]
                                                                            .autres?[0]
                                                                            ?.produits?[index]
                                                                            .prixFacculatitf,
                                                                        "id": viewModel
                                                                            .detailMenu?[0]
                                                                            .autres?[0]
                                                                            ?.produits?[index]
                                                                            .id
                                                                      });
                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu + (qtePanier! * double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier + (qtePanier! * double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! + qte * double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              prixMenu! + qte * double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    } else {
                                                                      menuList
                                                                          .remove({
                                                                        "prixFacculatitf": viewModel
                                                                            .detailMenu?[0]
                                                                            .autres?[0]
                                                                            ?.produits?[index]
                                                                            .prixFacculatitf,
                                                                        "id": viewModel
                                                                            .detailMenu?[0]
                                                                            .autres?[0]
                                                                            ?.produits?[index]
                                                                            .id,
                                                                        "qte":
                                                                            qtselautre
                                                                      });
                                                                      setState(
                                                                          () {
                                                                        if (widget
                                                                            .ispanier!) {
                                                                          prixPanierMenu =
                                                                              prixPanierMenu - (qtePanier! * double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                          prixPanier =
                                                                              prixPanier - (qtePanier! * double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? ""));
                                                                        } else {
                                                                          totalPrice =
                                                                              totalPrice! - double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                          prixMenu =
                                                                              prixMenu! - double.parse(viewModel.detailMenu?[0].autres?[0]?.produits?[index].prixFacculatitf.toString() ?? "");
                                                                        }
                                                                      });
                                                                    }
                                                                    print(menuList
                                                                        .join(
                                                                            ','));
                                                                  },
                                                                );
                                                              },
                                                              itemCount: viewModel
                                                                  .detailMenu?[
                                                                      0]
                                                                  .autres?[0]
                                                                  .produits
                                                                  ?.length,
                                                              // scrollDirection: Axis.vertical,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              ])
                                              // }),
                                              ),
                                        ],
                                      )),
                                  Positioned(
                                      bottom: 0.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: my_white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        height: 93.h,
                                        width: size.width,
                                        child: Stack(children: [
                                          Positioned(
                                            left: 35.w,
                                            top: 22.h,
                                            child: HorizontalCounetrWidget(
                                              ispanier: widget.ispanier!,
                                              qt: widget.ispanier!
                                                  ? qtePanier
                                                  : 1,
                                              qtMax: widget.rest ?? 11111111,
                                              myCounter: (nombre, v) {
                                                print("QUANTITEEEEEEEEE");
                                                qtePanier = qte = nombre;
                                                print(nombre);
                                                setState(() {
                                                  if (v == true) {
                                                    print(qtePanier);
                                                    widget.ispanier!
                                                        ? 11111111111 >
                                                                qtePanier!
                                                            ? prixPanier = qte *
                                                                prixPanierMenu
                                                            : null
                                                        : widget.rest! > qte
                                                            ? totalPrice =
                                                                totalPrice! +
                                                                    prixMenu!
                                                            : null;
                                                  } else {
                                                    if (widget.ispanier!) {
                                                      if (qtePanier! > 0 &&
                                                          prixPanier >
                                                              prixPanierMenu) {
                                                        print(
                                                            "NOOOWWWWW QTEPanier $qtePanier");

                                                        print(prixPanier);
                                                        print(prixPanierMenu);
                                                        prixPanier =
                                                            (prixPanier -
                                                                prixPanierMenu);
                                                      }
                                                    } else {
                                                      print(
                                                          "NOOOWWWWW QTE $qte");
                                                      print(totalPrice);
                                                      print(prixMenu);
                                                      if (qte > 0 &&
                                                          totalPrice >
                                                              prixMenu) {
                                                        print(prixMenu);
                                                        print(totalPrice);
                                                        totalPrice =
                                                            totalPrice! -
                                                                prixMenu!;
                                                      }
                                                    }
                                                  }
                                                });
                                                print(qte);
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            left: 189.w,
                                            top: 22.h,
                                            child: MyWidgetButton(
                                              width: 160.w,
                                              height: 50.h,
                                              widget: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  InkWell(
                                                      child: Text(
                                                          !widget.ispanier!
                                                              ? "Ajouter"
                                                              : "Modifier",
                                                          style: TextStyle(
                                                              color: my_white,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 15.sp)),
                                                      onTap: () {
                                                        if (widget.dispo!) {
                                                          print('Ajouter');
                                                          print(idPanier);
                                                          print(
                                                              ' saucelist : $sauceList/n tailleList : $tailleList/n viandeList : $viandeList/n bossonList : $boisonList/n garnitureList : $garnitureList/n ');
                                                          widget.ispanier!
                                                              ? ViewModelPanier.updatePanier(
                                                                  sauceList
                                                                      .toList(),
                                                                  tailleList
                                                                      .toList(),
                                                                  viandeList
                                                                      .toList(),
                                                                  boisonList
                                                                      .toList(),
                                                                  garnitureList
                                                                      .toList(),
                                                                  qtePanier!,
                                                                  widget
                                                                      .idpanier,
                                                                  context)
                                                              : ViewModelPanier.ajoutPanier(
                                                                  sauceList
                                                                      .toList(),
                                                                  tailleList
                                                                      .toList(),
                                                                  viandeList
                                                                      .toList(),
                                                                  boisonList
                                                                      .toList(),
                                                                  garnitureList
                                                                      .toList(),
                                                                  qte,
                                                                  viewModel
                                                                      .detailMenu?[
                                                                          0]
                                                                      .identifiant,
                                                                  context,
                                                                  widget
                                                                      .idResto,
                                                                  widget.img,
                                                                  widget.name,
                                                                  widget.numab,
                                                                  widget.like,
                                                                  widget.rest);
                                                        }
                                                      }),
                                                  Container(
                                                      height: 30,
                                                      width: 30.w,
                                                      child: VerticalDivider(
                                                          color: Colors.white)),
                                                  Text(
                                                      widget.ispanier!
                                                          ? "${prixPanier.toStringAsFixed(2)}€"
                                                          : "${totalPrice.toStringAsFixed(2)}€",
                                                      style: TextStyle(
                                                          color: my_white,
                                                          fontFamily: "Roboto",
                                                          fontSize: 14.sp))
                                                ],
                                              ),
                                              onTap: () {},
                                              color: widget.dispo!
                                                  ? my_black
                                                  : my_grey,
                                            ),
                                          ),
                                        ]),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
