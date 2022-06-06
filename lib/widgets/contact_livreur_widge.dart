import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line/screens/Mes%20commandes/commande_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';

final commandeProvider = ChangeNotifierProvider<CommandeNotifier>(
  (ref) => CommandeNotifier(),
);

class ContactLivreurWidget extends ConsumerStatefulWidget {
  final String? id;
  const ContactLivreurWidget({Key? key, this.id}) : super(key: key);

  @override
  _ContactLivreurWidgetState createState() => _ContactLivreurWidgetState();
}

class _ContactLivreurWidgetState extends ConsumerState<ContactLivreurWidget> {
  getDetais() {
    var viewmodel = ref.read(commandeProvider);
    viewmodel.detailsCommandeLivreur(widget.id!, context).then((value) {
      setState(() {
        isLoading = false;
        print("hello phone");
        print(viewmodel.detailsCmd?[0]);
        people.add(viewmodel.detailsCmdLivreur?[0].livreur?[0].phone ?? "");

        print(viewmodel.detailsCmdLivreur?[0].livreur?[0].phone);
      });
    });
  }

  List<String> people = [];

  _callNumber(String? number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number!);
  }

  @override
  void initState() {
    getDetais();
    // TODO: implement initState
    super.initState();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    var viewModel = ref.read(commandeProvider);
    return Row(
      children: [
        Container(
          height: 58.h,
          width: 58.w,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                viewModel.detailsCmdLivreur?[0].livreur?[0].photoProfil ?? ""),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            Container(
              width: 100.w,
              child: isLoading
                  ? SizedBox()
                  : Text(
                      '${viewModel.detailsCmdLivreur?[0].livreur?[0].nom ?? ""} ${viewModel.detailsCmdLivreur?[0].livreur?[0].prenom ?? ""}',
                      style: TextStyle(
                          color: my_white,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // SizedBox(
            //   height: 20.h,
            //   width: 100.w,
            //   child: ListView.builder(
            //       padding: EdgeInsets.zero,
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 5,
            //       itemBuilder: (context, index) {
            //         return Container(
            //             width: 11.w,
            //             height: 10.h,
            //             child: Image.asset("images/star.png"));
            //       }),
            // )
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        InkWell(
            child: Image.asset('images/message.png'),
            onTap: () {
              print(
                  viewModel.detailsCmdLivreur?[0].livreur?[0].phone.toString());

              _sendSMS();
            }
            //_callNumber(viewModel.detailsCmd?[0].livreur?[0].phone),
            ),
        SizedBox(
          width: 10.w,
        ),
        InkWell(
            child: Image.asset('images/call.png'),
            onTap: () {
              print(
                  viewModel.detailsCmdLivreur?[0].livreur?[0].phone.toString());

              FlutterPhoneDirectCaller.callNumber(viewModel
                      .detailsCmdLivreur?[0].livreur?[0].phone
                      .toString() ??
                  "");
            }),
      ],
    );
  }

  _sendSMS() async {
    try {
      print(people);
      String _result = await sendSMS(message: "", recipients: people);
    } catch (error) {
      print("error");
    }
  }
}
