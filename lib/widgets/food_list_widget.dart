import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line/models/liste_resto_model.dart';
import 'package:food_line/screens/listeresto_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'other_food_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final signInModelSignIn = ChangeNotifierProvider<RestoNotifier>(
  (ref) => RestoNotifier(),
);

class FoodListWidget extends ConsumerStatefulWidget {
  final id;
  //final FoodListWidget? foodlist;
  const FoodListWidget({this.id, Key? key}) : super(key: key);

  @override
  _FoodListWidgetState createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends ConsumerState<FoodListWidget> {
  bool isloading = true;

  getlistResto() async {
    final viewModel = ref.read(signInModelSignIn);

    String filtre =
        widget.id == null ? "" : "?specialiteRestos[in]=" + widget.id;
    await viewModel.listeResto(filtre).then((value) {
      print("HELLO KIKOUUUU");
      print(viewModel.listResto?[0].listeRestaurant?[0].identifiant ?? 0);
      if (this.mounted) {
        setState(() {
          isloading = false;
        });
      }
    });
  }

  @override
  void initState() {
    getlistResto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final viewModel = ref.watch(signInModelSignIn);
      return viewModel.listResto == null && !viewModel.isSearch
          ? Container(
              child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: LoadingIndicator(
                  color: my_green,
                  indicatorType: Indicator.ballRotateChase,
                ),
              ),
            ))
          : SizedBox(
              height: 300.h *
                  num.parse(viewModel.listResto?.length.toString() ?? "0"),
              child: ListView.builder(
                //shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.listResto?.length,
                itemBuilder: (context, i) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.listResto?[i].name ?? "",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        height: 255.h,
                        child: ListView.builder(
                          itemCount:
                              viewModel.listResto?[i].listeRestaurant?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                OtherFoodWidget(
                                    idResto: viewModel
                                            .listResto?[i]
                                            .listeRestaurant?[index]
                                            .identifiant ??
                                        "",
                                    strPath: viewModel
                                            .listResto?[i]
                                            .listeRestaurant?[index]
                                            .photoCouverture ??
                                        "",
                                    menuName: viewModel.listResto?[i]
                                            .listeRestaurant?[index].titre ??
                                        "",
                                    marketPath:
                                        viewModel.listResto?[i].listeRestaurant?[index].logo ??
                                            "",
                                    dispo: viewModel.listResto?[i]
                                        .listeRestaurant?[index].disponible,
                                    qteMax: viewModel.listResto?[i]
                                        .listeRestaurant?[index].qteMax,
                                    qteRestante: viewModel.listResto?[i]
                                        .listeRestaurant?[index].qteRestant,
                                    like: viewModel.listResto?[i].listeRestaurant?[index].like),
                                SizedBox(
                                  width: 8.5.w,
                                ),
                              ],
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
