import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/models/user.dart';
import 'package:food_line/screens/login/signin_repo.dart';
import 'package:food_line/screens/login/signup_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/upper_case_formatter.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/custom_input.dart';
import 'package:food_line/widgets/custom_input_pwd.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:food_line/widgets/my_title_button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'activate_account.dart';

final signUpModelSignUp = ChangeNotifierProvider<SignUpViewModel>(
  (ref) => SignUpViewModel(),
);

class SignUpScreen extends ConsumerStatefulWidget {
  final User? user;
  final String? type;
  const SignUpScreen({Key? key, this.type = "type", this.user})
      : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
  bool enablprenom = false;
  bool enablname = false;
  bool enablphone = false;
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String accessTokenn = "";
  String userIDD = "";
  User user = User();
  MaskTextInputFormatter? maskFormatter = MaskTextInputFormatter(
      mask: '+33 # ## ## ## ##', filter: {"#": RegExp(r'[0-9]')});
  MaskTextInputFormatter? maskEMpty = MaskTextInputFormatter();
  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.user != null) {
        accessTokenn = widget.user!.provider!.accessToken;
        userIDD = widget.user!.provider!.userId;
        typee = widget.user!.authProvider;
      }
    });
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
                top: 220.h,
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
                            isphone: true,
                            texte: 'Numéro de téléphone',
                            formater: maskFormatter,
                            //  formater: [],
                            keyboardType: TextInputType.number,
                            onTap: () {
                              setState(() {
                                enablphone = true;
                              });
                            },
                            enableField: enablphone,
                            hintText: "+33 0 00 00 00 00 ",
                            controller: phoneController,
                            validator: (String? v) {
                              return Validators.validatePhone(v!);
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomInputPwd(
                            // formater: maskFormatter,
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
                            validator: (String? v) {
                              return Validators.validatePassword(v!);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                      ),
                      MyWidgetButton(
                          width: 303,
                          height: 50,
                          color: my_green,
                          widget: Center(
                            child: Text("S'inscrire",
                                style: TextStyle(
                                    color: my_white,
                                    fontFamily: "Robot",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp)),
                          ),
                          onTap: () {
                            print(_formKey.currentState!.validate());
                            if ((_formKey.currentState!.validate())) {
                              print("send******************" +
                                  typee +
                                  userIDD +
                                  accessTokenn);
                              print(nameController.text +
                                  phoneController.text +
                                  firstNameController.text +
                                  emailController.text +
                                  adresseController.text +
                                  pwdController.text);

                              viewModel.onChange(
                                name: nameController.text,
                                type: typee,
                                phone: phoneController.text,
                                prenom: firstNameController.text,
                                email: emailController.text,
                                address: adresseController.text,
                                password: pwdController.text,
                                userID: userIDD,
                                accessToken: accessTokenn,
                              );
                              print("send******************" +
                                  typee +
                                  userIDD +
                                  accessTokenn);
                              viewModel.signUpWithEmailAndPassword(context);
                            }
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
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
}
