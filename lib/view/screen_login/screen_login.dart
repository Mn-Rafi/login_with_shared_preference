import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pullrequests_projectct/helpers/constant_styles.dart';
import 'package:pullrequests_projectct/helpers/input_validator_mixin.dart';
import 'package:pullrequests_projectct/view/screen_dash/screen_dash.dart';
import 'package:pullrequests_projectct/widgets/custom_submit_botton.dart';
import 'package:pullrequests_projectct/widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> with TextFieldValidator {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  IconData hidePass = Icons.visibility_off;

  bool isObscure = true;
  bool isSubmitted = false;

  late Image image1;

  @override
  void initState() {
    super.initState();
    
    image1 = Image.network(
        "https://badcoffee.club/wp-content/uploads/2021/04/macOS-Big-Sur-Login-Screen-Background-Image.png");
  }

  // @override
  // void didChangeDependencies() {
  //   precacheImage(image1.image, context);
  //   super.didChangeDependencies();
  // }

  

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://badcoffee.club/wp-content/uploads/2021/04/macOS-Big-Sur-Login-Screen-Background-Image.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                      width: 100.w,
                    ),
                    Text(
                      'Hello Again!',
                      style: mainHeaderStyle,
                    ),
                    Text(
                      'Before continue, please sign in first',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 2.h),
                      child: CustomTextFormField(
                          iconData: Icons.email,
                          textController: emailController,
                          validator: (val) {
                            return isEmailValid(val);
                          },
                          hintText: 'Enter email',
                          keyBoardType: TextInputType.emailAddress),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: CustomTextFormField(
                          suffixAction: () {
                            if (isObscure == true) {
                              setState(() {
                                isObscure = false;
                                hidePass = Icons.visibility;
                              });
                            } else {
                              setState(() {
                                isObscure = true;
                                hidePass = Icons.visibility_off;
                              });
                            }
                          },
                          sufficiconData: hidePass,
                          nextAction: TextInputAction.done,
                          obscure: isObscure,
                          iconData: Icons.lock,
                          textController: passwordController,
                          validator: (val) {
                            return isPasswordValid(val);
                          },
                          hintText: 'Password',
                          keyBoardType: TextInputType.text),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 1.h),
                      child: GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                          final sharedprefs =
                              await SharedPreferences.getInstance();
                          await sharedprefs.setBool('isLoggedIn', true);
                            setState(() {
                              isSubmitted = true;
                              Timer(const Duration(seconds: 1), () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => ScreenDash(),
                                    ),
                                    (route) => false);
                              });
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter valid email and password')));
                          }
                        },
                        child: !isSubmitted
                            ? const CustomSubmitButton(
                                bgColor: kbuttonColor, text: 'SIGN IN')
                            : const CustomLoadingSubmitButton(
                                text: '', bgColor: kbuttonColor),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
