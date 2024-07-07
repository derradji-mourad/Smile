import 'package:flutter/material.dart';
import 'package:flutter_application_6/consts/consts.dart';
import 'package:flutter_application_6/consts/images.dart';
import 'package:flutter_application_6/consts/lists.dart';
import 'package:flutter_application_6/controllers/auth_controller.dart';
import 'package:flutter_application_6/controllers/settings_controller.dart';
import 'package:flutter_application_6/views/login_view/login_view.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
            title: AppStrings.settings,
            color: AppColors.whiteColor,
            size: AppSizes.size18),
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Image.asset(AppAssets.imgSignup)),
            title: AppStyles.bold(title: controller.username.value),
            subtitle: AppStyles.normal(title: controller.email.value),
          ),
          const Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                settingsList.length,
                (index) => ListTile(
                      onTap: () {
                        if (index == 2) {
                          AuthController().signout();
                          Get.offAll(() => const LoginView());
                        }
                      },
                      leading: Icon(
                        settingsListIcon[index],
                        color: AppColors.blueColor,
                      ),
                      title: AppStyles.bold(title: settingsList[index]),
                    )),
          ),
        ],
      ),
    );
  }
}
