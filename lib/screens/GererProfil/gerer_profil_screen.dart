import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line/screens/GererProfil/profil_repo.dart';
import 'package:food_line/screens/ListeMenu/liste_menu_repo.dart';
import 'package:food_line/screens/menuPage/profil_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/commander_widget.dart';
import 'package:food_line/widgets/custom_input.dart';
import 'package:food_line/widgets/custom_input_pwd.dart';
import 'package:food_line/widgets/favori_widget.dart';
import 'package:food_line/widgets/menu_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:food_line/widgets/tags_menu_widget.dart';
import 'package:food_line/widgets/voir_panier_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:page_transition/page_transition.dart';

final profilProvider = ChangeNotifierProvider<ProfileNotifier>(
  (ref) => ProfileNotifier(),
);
final profilUpdateProvider = ChangeNotifierProvider<ProfilUpdateNotifier>(
  (ref) => ProfilUpdateNotifier(),
);

class ProfilScreen extends ConsumerStatefulWidget {
  const ProfilScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends ConsumerState<ProfilScreen>
    with TickerProviderStateMixin {
  MaskTextInputFormatter? maskFormatter = MaskTextInputFormatter(
      mask: '+33 # ## ## ## ##', filter: {"#": RegExp(r'[0-9]')});
  MaskTextInputFormatter? maskEMpty = MaskTextInputFormatter();
  TabController? _tabController;
  bool panierClicked = false;
  bool showPanier = false;
  bool _showPassword = false;
  bool enablpwd = false;
  bool enablemail = false;
  bool enablprenom = false;
  bool enablname = false;
  bool enablphone = false;
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formKeypwd = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController adresseController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController newpwdController = TextEditingController();

  @override
  void initState() {
    getProfil();

    super.initState();
  }

  getProfil() async {
    final viewModel = ref.read(profilProvider);
    await viewModel.getInfoClient(context).then(
      (value) {
        setState(() {
          emailController.text = value?.email ?? "";
          nameController.text = value?.nom ?? "";
          firstNameController.text = value?.prenom ?? "";
          phoneController.text = value?.phone ?? "";
          isloading = false;
        });
      },
    );
  }

  bool isloading = true;
  String? idSpecialite;
  getListeMenu() async {
    final viewModel = ref.read(profilProvider);
    // await viewModel.listeMenu().then((value) {
    //   print("myTabsOne=======================>");

    //   // print(viewModel.listMenu?.length);
    //   setState(() {

    //     isloading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(profilUpdateProvider);
    Size size = MediaQuery.of(context).size;

    return isloading
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
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                color: my_white,
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 40.h,
                      left: 32.w,
                      child: Row(
                        children: [
                          MyWidgetButton(
                            widget: Container(
                              child: SvgPicture.asset(
                                'images/arrowback.svg',
                                height: 2.h,
                                width: 2.w,
                                fit: BoxFit.none,
                                color: my_white,
                              ),
                            ),
                            color: my_green,
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 109.h,
                      left: 120.w,
                      child: Center(
                        child: Container(
                          height: 120.h,
                          width: 120.w,
                          child: CircleAvatar(
                            backgroundColor: my_grey,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 150.h,
                    //   left: 150.w,
                    //   child: Center(
                    //     child: Container(
                    //         height: 120.h,
                    //         width: 120.w,
                    //         child: IconButton(
                    //           icon: Icon(Icons.camera_alt_sharp),
                    //           onPressed: () {},
                    //         )),
                    //   ),
                    // ),
                    Positioned(
                      top: 300.h,
                      left: 180.w,
                      child: Center(
                        child: InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, StateSetter setState) {
                                  return BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        alignment: Alignment.center,
                                        //padding: EdgeInsets.only(bottom: 230),
                                        color:
                                            Color(0xFFAEA9A3).withOpacity(0.2),
                                        child: AlertDialog(
                                          scrollable: true,
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          content: Container(
                                              constraints: BoxConstraints(
                                                  minHeight: 250.0),
                                              //height: 200.h,
                                              width: 250.w,
                                              //padding: ,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Changer votre mot de passe',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24.h,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 20),
                                                    child: Form(
                                                      key: _formKeypwd,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          CustomInputPwd(
                                                            // formater: maskFormatter,
                                                            onTap: () {
                                                              setState(() {
                                                                enablpwd = true;
                                                              });
                                                            },
                                                            labelText:
                                                                "Ancien mot de passe",
                                                            enableField:
                                                                enablpwd,
                                                            obscureText:
                                                                !_showPassword,
                                                            controller:
                                                                pwdController,
                                                            suffixIcon:
                                                                IconButton(
                                                              iconSize: 15,
                                                              icon: Icon(
                                                                _showPassword
                                                                    ? Icons
                                                                        .visibility
                                                                    : Icons
                                                                        .visibility_off,
                                                                color: this
                                                                        ._showPassword
                                                                    ? my_green
                                                                    : my_hint,
                                                              ),
                                                              onPressed: () {
                                                                setState(() =>
                                                                    _showPassword =
                                                                        !_showPassword);
                                                              },
                                                            ),
                                                            validator:
                                                                (String? v) {
                                                              return Validators
                                                                  .validatePassword(
                                                                      v!);
                                                            },
                                                          ),
                                                          CustomInputPwd(
                                                            // formater: maskFormatter,
                                                            onTap: () {
                                                              setState(() {
                                                                enablpwd = true;
                                                              });
                                                            },
                                                            labelText:
                                                                "Nouveau mot de passe",
                                                            enableField:
                                                                enablpwd,
                                                            obscureText:
                                                                !_showPassword,
                                                            controller:
                                                                newpwdController,
                                                            suffixIcon:
                                                                IconButton(
                                                              iconSize: 15,
                                                              icon: Icon(
                                                                _showPassword
                                                                    ? Icons
                                                                        .visibility
                                                                    : Icons
                                                                        .visibility_off,
                                                                color: this
                                                                        ._showPassword
                                                                    ? my_green
                                                                    : my_hint,
                                                              ),
                                                              onPressed: () {
                                                                setState(() =>
                                                                    _showPassword =
                                                                        !_showPassword);
                                                              },
                                                            ),
                                                            validator:
                                                                (String? v) {
                                                              return Validators
                                                                  .validatePassword(
                                                                      v!);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  MyWidgetButton(
                                                      width: 303,
                                                      height: 50,
                                                      color: my_green,
                                                      widget: Center(
                                                        child: Text("Confirmer",
                                                            style: TextStyle(
                                                                color: my_white,
                                                                fontFamily:
                                                                    "Robot",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    15.sp)),
                                                      ),
                                                      onTap: () {
                                                        print(_formKeypwd
                                                            .currentState!
                                                            .validate());
                                                        if ((_formKeypwd
                                                            .currentState!
                                                            .validate())) {
                                                          viewModel.changePassword(
                                                              newpwdController
                                                                  .text,
                                                              emailController
                                                                  .text,
                                                              context);
                                                        }
                                                      }),
                                                ],
                                              )),
                                        ),
                                      ));
                                });
                              }),
                          child: Container(
                              height: 120.h,
                              width: 190.w,
                              child: Text(
                                "changer votre mot de passe",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: my_green),
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 330.h,
                        right: 36.w,
                        left: 36.w,
                        child: Container(
                          // height: 233.h,
                          width: 303.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),

                          child: Column(
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(children: [
                                    CustomInput(
                                      formater: maskEMpty,
                                      onTap: () {
                                        setState(() {
                                          enablemail = true;
                                        });
                                      },
                                      enableField: enablemail,
                                      hintText: "Nom",
                                      controller: nameController,
                                      validator: (String? v) {
                                        return Validators.validateName(v!);
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomInput(
                                      formater: maskEMpty,
                                      onTap: () {
                                        setState(() {
                                          enablprenom = true;
                                        });
                                      },
                                      enableField: enablprenom,
                                      hintText: "Prénom",
                                      controller: firstNameController,
                                      validator: (String? v) {
                                        return Validators.validateName(v!);
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomInput(
                                      formater: maskEMpty,
                                      onTap: () {
                                        setState(() {
                                          enablname = true;
                                        });
                                      },
                                      enableField: enablname,
                                      hintText: "E-mail",
                                      controller: emailController,
                                      validator: (String? v) {
                                        return Validators.validateEmail(v!);
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomInput(
                                      formater: maskFormatter,
                                      onTap: () {
                                        setState(() {
                                          enablphone = true;
                                        });
                                      },
                                      enableField: enablphone,
                                      hintText: "Numéro de Téléphone",
                                      controller: phoneController,
                                      validator: (String? v) {
                                        return Validators.validatePhone(v!);
                                      },
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  ])),
                              MyWidgetButton(
                                  width: 303,
                                  height: 50,
                                  color: my_green,
                                  widget: Center(
                                    child: Text("Confirmer",
                                        style: TextStyle(
                                            color: my_white,
                                            fontFamily: "Robot",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp)),
                                  ),
                                  onTap: () {
                                    // print(_formKey.currentState!.validate());
                                    if ((_formKey.currentState!.validate())) {
                                      viewModel.upadatePorfil(
                                          nameController.text,
                                          firstNameController.text,
                                          phoneController.text,
                                          emailController.text,
                                          context);
                                    }
                                  }),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
