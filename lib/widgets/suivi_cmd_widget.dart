import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/Mes%20commandes/commande_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/widgets/suivicmdline_widget.dart';

final commandeProvider = ChangeNotifierProvider<CommandeNotifier>(
  (ref) => CommandeNotifier(),
);

class SuiviCommandeWidget extends ConsumerStatefulWidget {
  final String? title;
  final String? idCmd;
  SuiviCommandeWidget({this.title, this.idCmd});
  _SuiviCommandeWidgetState createState() => _SuiviCommandeWidgetState();
}

class _SuiviCommandeWidgetState extends ConsumerState<SuiviCommandeWidget> {
  bool isLoading = true;
  getStatus() {
    var viewmodel = ref.read(commandeProvider);
    viewmodel.statusCommande(widget.idCmd!, context).then((value) {
      setState(() {
        isLoading = false;
        for (var i = 0; i < 5; i++) {
          status.add(viewmodel.statusCmd?.results?[i].statut);
        }
        isLoading = false;
      });
    });
  }

  List<String?> status = [];
  List<String> statusTitle = [
    "Demande de livraison reçue",
    "Commande récupérée",
    "Livraison en cours d'acheminement",
    "Livreur sur le lieu de livraison",
    "Livreur parti"
  ];
  @override
  void initState() {
    getStatus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewmodel = ref.read(commandeProvider);

    return isLoading
        ? Container()
        : Container(
            height: 382.h,
            padding: EdgeInsets.only(right: 36.w),
            child: Stack(
              children: [
                Positioned(
                    left: 60.w,
                    top: 20.h,
                    child: Container(
                      height: 279.h,
                      child: Image.asset(
                        "images/line.png",
                        fit: BoxFit.contain,
                        height: 279.h,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(
                    left: 55.w,
                    top: 19.h,
                  ),
                  height: 400.h,
                  width: 500.w,
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, child) => SizedBox(
                            height: 30.h,
                          ),
                      // physics: ScrollPhysics(),
                      primary: true,
                      itemCount: statusTitle.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SuiviCommandeLineWidget(
                          title: statusTitle[index],
                          // subtitle: "Lyon, France",
                          status: status[index],
                        );
                      }),
                ),
              ],
            ));
  }
}
