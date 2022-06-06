import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/screens/login/signup_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';

import 'package:food_line/widgets/my_button_widget.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pin_put/pin_put.dart';

final activateAccount = ChangeNotifierProvider<SignUpViewModel>(
  (ref) => SignUpViewModel(),
);

class ActivateAccountScreen extends ConsumerStatefulWidget {
  final String? email;
  final String? mdp;
  const ActivateAccountScreen({Key? key, this.email, this.mdp})
      : super(key: key);

  @override
  _ActivateAccountScreenState createState() => _ActivateAccountScreenState();
}

class _ActivateAccountScreenState extends ConsumerState<ActivateAccountScreen>
    with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;
  String? _email = "";
  String typee = "email";
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    animation = Tween<double>(begin: 1, end: 0)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(controller);
    controller.forward();
    setState(() {
      _email = widget.email;
    });
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: my_white_grey,
      border: Border.all(color: my_white_grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  BoxDecoration get _selectedpinPutDecoration {
    return BoxDecoration(
      color: my_white_grey,
      border: Border.all(color: my_white_grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = ref.read(activateAccount);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: my_black,
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 36.h,
                left: 36.w,
                child: MyWidgetButton(
                  widget: SvgPicture.asset(
                    'images/arrowback.svg',
                    height: 3.h,
                    width: 3.w,
                    fit: BoxFit.none,
                  ),
                  color: my_white,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 75.h,
                right: 131.w,
                child: SvgPicture.asset(
                  'images/logo_food.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 276.h,
                right: 36.w,
                left: 36.w,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    double x = animation.value * getWidth(context);
                    return Transform(
                      transform: Matrix4.translationValues(x, 0, 0),
                      child: child,
                    );
                  },
                  child: const Text(
                    "Entrez le code OTP à 4 chiffres envoyés",
                    style: TextStyle(
                        color: my_white,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                top: 315.h,
                right: 36.w,
                left: 36.w,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    double x = animation.value * getWidth(context);
                    return Transform(
                      transform: Matrix4.translationValues(x, 0, 0),
                      child: child,
                    );
                  },
                  child: PinPut(
                    eachFieldHeight: 58.h,
                    eachFieldWidth: 58.w,
                    fieldsCount: 4,
                    onSubmit: (String pin) => _showSnackBar(pin, context),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    selectedFieldDecoration: _selectedpinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10.0.r),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 400.h,
                left: 36.w,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    double x = animation.value * getWidth(context);
                    return Transform(
                      transform: Matrix4.translationValues(x, 0, 0),
                      child: child,
                    );
                  },
                  child: MyWidgetButton(
                      width: 303,
                      height: 50,
                      color: my_green,
                      widget: Center(
                        child: Text('Continuer',
                            style: TextStyle(
                                color: my_white,
                                fontFamily: "Robot",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp)),
                      ),
                      onTap: () {
                        print(
                            "email  $_email  code: ${_pinPutController.text} ");

                        viewModel.activateAccount(context, _email!,
                            _pinPutController.text, widget.mdp!);
                        print("Hello");
                        // viewModel.onChangeData(
                        //     email: emailController.text,
                        //     password: pwdController.text);
                        // viewModel.signInWithEmailAndPassword(context);
                      }),
                ),
              ),
              Positioned(
                top: 475.h,
                left: 79.w,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    double x = animation.value * getWidth(context);
                    return Transform(
                      transform: Matrix4.translationValues(x, 0, 0),
                      child: child,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous n'avez pas reçu de code?",
                        style: TextStyle(
                            color: my_white,
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                          child: SizedBox(
                            height: 30.h,
                            child: const Text(
                              "Cliquez ici",
                              style: TextStyle(
                                  color: my_green,
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            viewModel.resendCode(context, widget.email);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: SizedBox(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
