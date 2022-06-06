import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/Mes%20commandes/commande_repo.dart';
import 'package:food_line/screens/Mes%20commandes/suivi_commande_screen.dart';
import 'package:food_line/utils/colors.dart';

final commandeProvider = ChangeNotifierProvider<CommandeNotifier>(
  (ref) => CommandeNotifier(),
);

class CommandeWidget extends ConsumerStatefulWidget {
  final String? title;
  final String? qt;
  final String? image;
  final String? num;
  final int? index;
  CommandeWidget({this.title, this.qt, this.image, this.num, this.index});
  _CommandeWidgetState createState() => _CommandeWidgetState();
}

class _CommandeWidgetState extends ConsumerState<CommandeWidget> {
  bool isLoading = true;
  @override
  void initState() {
    getCommande();
    // TODO: implement initState
    super.initState();
  }

  getCommande() {
    var viewmodel = ref.read(commandeProvider);
    viewmodel.listCommande(context).then((value) {
      setState(() {
        print("helllo");
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = ref.read(commandeProvider);
    return Container(
      padding: EdgeInsets.only(left: 36.w, right: 36.w),
      child: ListView.separated(
        separatorBuilder: (context, child) => SizedBox(
          height: 19.h,
        ),
        physics: ScrollPhysics(),
        primary: true,
        itemCount: viewModel.listCmd?.results?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuiviCommandeScreen(
                    id: viewModel.listCmd?.results?[index].identifiant ?? ""),
              ),
            ),
            child: Container(
                height: 80.h,
                width: 303.w,
                decoration: BoxDecoration(
                    color: my_white,
                    border: Border.all(color: my_white_grey),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(viewModel.listCmd
                                  ?.results?[index].livreur?[0].photoProfil ??
                              ""),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: Container(
                              child: Text(
                                  '${viewModel.listCmd?.results?[index].quantite ?? 0} X',
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500))),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Container(
                      width: 201.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 200.w,
                              child: Text(
                                  "Commande Nº ${viewModel.listCmd?.results?[index].numeroCommande ?? 0}",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500))),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // Container(
                          //   width: 200.w,
                          //   child: Text("2 Menus +9 Kings Nuggets",
                          //       style: TextStyle(
                          //           fontFamily: "Roboto",
                          //           fontSize: 14.sp,
                          //           fontWeight: FontWeight.w500)),
                          // ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          // Container(
                          //   width: 200.w,
                          //   child: Text("Medium-Bacon Lover - Frites ",
                          //       style: TextStyle(
                          //           fontFamily: "Roboto",
                          //           fontSize: 14.sp,
                          //           color: my_grey)),
                          // )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
