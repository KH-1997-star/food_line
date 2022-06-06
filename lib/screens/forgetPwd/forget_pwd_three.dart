import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/validator.dart';
import 'package:food_line/widgets/custom_input_pwd.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'forgetpwd_repo.dart';

final signUpModelSignUp = ChangeNotifierProvider<ForgetPasswordViewModel>(
  (ref) => ForgetPasswordViewModel(),
);

class ForgetPwdThreeScreen extends ConsumerStatefulWidget {
  final String? email;
  const ForgetPwdThreeScreen({Key? key, this.email}) : super(key: key);

  @override
  _ForgetPwdThreeScreenState createState() => _ForgetPwdThreeScreenState();
}

class _ForgetPwdThreeScreenState extends ConsumerState<ForgetPwdThreeScreen> {
  TextEditingController secondPwdController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  String typee = "email";
  bool _showPassword = false;
  bool _showPasswordTwo = false;
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
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
                      "Entrez votre nouveau mot de passe",
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
                      child: Column(
                        children: [
                          CustomInputPwd(
                            onTap: () {
                              setState(() {
                                enablpwd = true;
                              });
                            },
                            labelText: "Nouveau mot de passe",
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
                              return Validators.validatePassword(v!);
                            },
                          ),
                          CustomInputPwd(
                            onTap: () {
                              setState(() {
                                enablpwd = true;
                              });
                            },
                            labelText: "Nouveau mot de passe",
                            enableField: enablpwd,
                            obscureText: !_showPasswordTwo,
                            controller: secondPwdController,
                            suffixIcon: IconButton(
                              iconSize: 15,
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:
                                    this._showPasswordTwo ? my_green : my_hint,
                              ),
                              onPressed: () {
                                setState(
                                    () => _showPasswordTwo = !_showPasswordTwo);
                              },
                            ),
                            validator: (v) {
                              return Validators.validateConfirmPassword(
                                  v!, pwdController.text);
                            },
                          ),
                        ],
                      )),
                ),
                Positioned(
                  top: 500.h,
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

                          // print("Hello");
                          // Navigator.pushNamed(context, '/slide_screen');
                          viewModel.newPassword(
                              context, pwdController.text, widget.email);
                        }
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
