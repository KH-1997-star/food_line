import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/custom_input.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'forgetpwd_repo.dart';

final signUpModelSignUp = ChangeNotifierProvider<ForgetPasswordViewModel>(
  (ref) => ForgetPasswordViewModel(),
);

class ForgetPwdOneScreen extends ConsumerStatefulWidget {
  final String? email;
  const ForgetPwdOneScreen({Key? key, this.email}) : super(key: key);

  @override
  _ForgetPwdOneScreenState createState() => _ForgetPwdOneScreenState();
}

class _ForgetPwdOneScreenState extends ConsumerState<ForgetPwdOneScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController adresseController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  String typee = "email";
  bool _showPassword = false;
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  MaskTextInputFormatter? maskEMpty = MaskTextInputFormatter();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: my_white,
      border: Border.all(color: my_white_grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  BoxDecoration get _selectedpinPutDecoration {
    return BoxDecoration(
      color: my_white,
      border: Border.all(color: my_white_grey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = ref.read(signUpModelSignUp);

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
                    widget: Container(
                      child: SvgPicture.asset(
                        'images/arrowback.svg',
                        height: 3.h,
                        width: 3.w,
                        fit: BoxFit.none,
                      ),
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
                    child: const Text(
                      "Entrez votre adresse E-mail",
                      style: TextStyle(
                          color: my_white,
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
                Positioned(
                  top: 315.h,
                  right: 36.w,
                  left: 36.w,
                  child: Form(
                    key: _formKey,
                    child: CustomInput(
                      formater: maskEMpty,
                      onTap: () {
                        setState(() {
                          enablemail = true;
                        });
                      },
                      enableField: enablemail,
                      hintText: "E-mail",
                      controller: emailController,
                      validator: (v) {
                        return Validators.validateEmail(v!);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 400.h,
                  left: 36.w,
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
                        print(_formKey.currentState!.validate());
                        if (_formKey.currentState!.validate()) {
                          print("Hello================>");
                        }
                        // print("Hello");
                        // Navigator.pushNamed(context, '/slide_screen');
                        viewModel.forgetPasswordOne(
                            context, emailController.text);
                        //     email: emailController.text,
                        //     password: pwdController.text);
                        // viewModel.signInWithEmailAndPassword(context);
                      }),
                ),
              ],
            )),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
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
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
