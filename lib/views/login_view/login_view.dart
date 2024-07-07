import 'package:flutter/material.dart';
import 'package:flutter_application_6/consts/images.dart';
import 'package:flutter_application_6/controllers/auth_controller.dart';
import 'package:flutter_application_6/res/components/custom_textfield.dart';
import 'package:flutter_application_6/res/components/custom_button.dart';
import 'package:flutter_application_6/consts/strings.dart';
import 'package:flutter_application_6/views/appointment_view/appointment_view.dart';
import 'package:flutter_application_6/views/home_view/home.dart';
// ignore: unused_import
import 'package:flutter_application_6/views/home_view/home_view.dart';
import 'package:flutter_application_6/views/signup_view/signup_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_6/consts/fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isDoc = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.icLogin,
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                    title: AppStrings.welcomeback, size: AppSizes.size18),
                AppStyles.bold(title: AppStrings.weAreExited)
              ],
            ),
            30.heightBox,
            Expanded(
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        hint: AppStrings.email,
                        textController: controller.emailController),
                    10.heightBox,
                    CustomTextField(
                        hint: AppStrings.password,
                        textController: controller.passwordController),
                    10.heightBox,
                    SwitchListTile(
                        value: isDoc,
                        onChanged: (newValue) {
                          setState(() {
                            isDoc = newValue;
                          });
                        },
                        title: "Sign in as a doctor".text.make()),
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppStyles.normal(title: AppStrings.forgetPassword),
                    ),
                    20.heightBox,
                    CustomButton(
                        buttonText: AppStrings.login,
                        onTap: () async {
                          await controller.loginUser();
                          if (controller.userCredential != null) {
                            if (isDoc) {
                              Get.to(() => const AppointmentView());
                            } else {
                              Get.to(() => const HOme());
                            }
                          }
                        }),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.dontHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const SignupView());
                          },
                          child: AppStyles.bold(title: AppStrings.signup),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
