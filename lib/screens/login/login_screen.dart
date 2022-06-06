import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/login/signin_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/custom_input.dart';
import 'package:food_line/widgets/custom_input_pwd.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final signInModelSignIn = ChangeNotifierProvider<ConnexionViewModel>(
  (ref) => ConnexionViewModel(),
);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool enablemail = false;
  MaskTextInputFormatter? maskEMpty = MaskTextInputFormatter();

  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool enablpwd = false;
  bool logoStartAnimation = false;
  bool toTheLeft = false;
  bool isExtended = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();

    final viewModel = ref.read(signInModelSignIn);
    Timer(
      const Duration(milliseconds: 20),
      () {
        setState(() {
          isExtended = true;
          changeOpacity = true;
        });
      },
    );
  }

  bool changeOpacity = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(signInModelSignIn);
    Timer(
        const Duration(milliseconds: 100),
        () => setState(() {
              logoStartAnimation = true;
            }));
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: my_black,
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: toTheLeft ? 2200 : 2000),
                top: logoStartAnimation ? 75.h : 800.h,
                right: 131.w,
                child: SvgPicture.asset(
                  'images/logo_food.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0.h,
                right: 0.w,
                left: 0.w,
                bottom: 0.h,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1800),
                  opacity: isExtended ? 1 : 0,
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 36.h,
                right: 36.w,
                child: AnimatedOpacity(
                  opacity: changeOpacity ? 1 : 0,
                  duration: const Duration(milliseconds: 1800),
                  child: MyWidgetButton(
                    onTap: () async {
                      viewModel.signInAnonymos(context);
                      // Navigator.pushReplacement(
                      //   context,
                      //   PageTransition(
                      //     child: const LocationScreen(),
                      //     type: PageTransitionType.fade,
                      //     duration: const Duration(
                      //       milliseconds: 500,
                      //     ),
                      //   ),
                      // );
                    },
                    color: Colors.white,
                    radius: 20,
                    height: 29,
                    width: 65,
                    widget: Center(
                      child: Text(
                        'Passer',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: toTheLeft ? 200 : 2000),
                top: logoStartAnimation ? 250.h : 900.h,
                right: 36.w,
                left: 36.w,
                child: Container(
                    // height: 233.h,
                    width: 303.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomInput(
                            formater: maskEMpty,
                            onTap: () {
                              setState(() {
                                enablemail = true;
                              });
                            },
                            enableField: enablemail,
                            hintText: "E-mail",
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (v) {
                              return Validators.validateEmail(
                                  v!.replaceAll(' ', ''));
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomInputPwd(
                            onTap: () {
                              setState(() {
                                enablpwd = true;
                              });
                            },
                            labelText: "Mot de passe",
                            enableField: enablpwd,
                            obscureText: !_showPassword,
                            controller: pwdController,
                            suffixIcon: IconButton(
                              iconSize: 15,
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: this._showPassword ? my_green : my_hint,
                              ),
                              onPressed: () {
                                setState(() => _showPassword = !_showPassword);
                              },
                            ),
                            validator: (v) {
                              return Validators.validatePwd(v!);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          MyWidgetButton(
                              width: 303,
                              height: 50,
                              color: my_green,
                              widget: Center(
                                child: Text('Se connecter',
                                    style: TextStyle(
                                        color: my_white,
                                        fontFamily: "Robot",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp)),
                              ),
                              onTap: () {
                                if ((_formKey.currentState!.validate())) {
                                  print("Hello");
                                  viewModel.onChangeData(
                                      email: emailController.text
                                          .replaceAll(' ', ''),
                                      password: pwdController.text);
                                  viewModel.signInWithEmailAndPassword(context);
                                }
                              }),
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Vous avez oublier votre mot de passe?",
                                style: TextStyle(
                                    color: my_white,
                                    fontFamily: 'Roboto',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/forgetPwdOne');
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    )),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: toTheLeft ? 200 : 2000),

                bottom: logoStartAnimation ? 36.h : -500.h,
                // bottom: 36.h,
                right: 36.w,
                left: 36.w,
                child: Container(
                    height: 233.h,
                    width: 303.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: my_white_opacity,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 28.h),
                        MyWidgetButton(
                          width: 257.w,
                          height: 47.h,
                          color: my_white_grey,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 23.w,
                              ),
                              SvgPicture.asset(
                                'images/google_icon.svg',
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 8.w),
                              Text('Connectez-vous avec google',
                                  style: TextStyle(
                                      color: my_black,
                                      fontFamily: "Robot",
                                      fontSize: 13.sp))
                            ],
                          ),
                          onTap: () {
                            viewModel.signInMethod(
                                authProvider: "google", context: context);
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        MyWidgetButton(
                            width: 257.w,
                            height: 47.h,
                            color: my_white_grey,
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 23.w,
                                ),
                                SvgPicture.asset(
                                  'images/fb_icon.svg',
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Connectez-vous avec Facebook',
                                  style: TextStyle(
                                      color: my_black,
                                      fontFamily: "Robot",
                                      fontSize: 13.sp),
                                ),
                              ],
                            ),
                            onTap: () {
                              viewModel.signInMethod(
                                  authProvider: "facebook", context: context);
                            }),
                        SizedBox(
                          height: 15.h,
                        ),
                        SvgPicture.asset(
                          'images/or.svg',
                          width: 257.w,
                          height: 20.h,
                        ),
                        SizedBox(height: 19.h),
                        InkWell(
                          child: SizedBox(
                            height: 30.h,
                            child: Text('Inscrivez-vous avec E-mail',
                                style: TextStyle(
                                    color: my_black,
                                    fontFamily: "Robot",
                                    fontSize: 13.sp)),
                          ),
                          onTap: () =>
                              Navigator.pushNamed(context, '/inscription'),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
