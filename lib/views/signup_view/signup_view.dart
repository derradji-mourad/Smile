import 'package:flutter/material.dart';
import 'package:flutter_application_6/consts/consts.dart';
import 'package:flutter_application_6/consts/images.dart';
import 'package:flutter_application_6/controllers/auth_controller.dart';
import 'package:flutter_application_6/res/components/custom_textfield.dart';
import 'package:flutter_application_6/res/components/custom_button.dart';
import 'package:flutter_application_6/consts/strings.dart';
import 'package:flutter_application_6/views/home_view/home.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_6/consts/fonts.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
                  AppAssets.imgSignup,
                  width: 200,
                ),
                10.heightBox,
                AppStyles.bold(
                    title: AppStrings.signupNow,
                    size: AppSizes.size18,
                    alignment: TextAlign.center)
              ],
            ),
            30.heightBox,
            Expanded(
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        hint: AppStrings.fullname,
                        textController: controller.fullnameController),
                    10.heightBox,
                    CustomTextField(
                        hint: AppStrings.email,
                        textController: controller.emailController),
                    10.heightBox,
                    CustomTextField(
                      hint: AppStrings.password,
                      textController: controller.passwordController,
                    ),
                    10.heightBox,
                    SwitchListTile(
                        title: "Sign up as a doctor".text.make(),
                        value: isDoc,
                        onChanged: (newValue) {
                          setState(() {
                            isDoc = newValue;
                          });
                        }),
                    Visibility(
                      visible: isDoc,
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: "About",
                            textController: controller.aboutController,
                          ),
                          10.heightBox,
                          CustomTextField(
                            hint: "Category",
                            textController: controller.categoryController,
                          ),
                          10.heightBox,
                          CustomTextField(
                            hint: "Services",
                            textController: controller.servicesController,
                          ),
                          CustomTextField(
                            hint: 'Address',
                            textController: controller.addressController,
                          ),
                          10.heightBox,
                          CustomTextField(
                            hint: 'Phone Number',
                            textController: controller.phoneController,
                          ),
                          10.heightBox,
                          CustomTextField(
                            hint: 'Timing',
                            textController: controller.timingController,
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    CustomButton(
                        buttonText: AppStrings.signup,
                        onTap: () async {
                          await controller.signupUser(isDoc);
                          if (controller.userCredential != null) {
                            Get.offAll(() => const HOme());
                          }
                        }),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppStyles.normal(title: AppStrings.alreadyHaveAccount),
                        8.widthBox,
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppStyles.bold(title: AppStrings.login),
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
