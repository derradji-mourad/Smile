import 'package:flutter/material.dart';
import 'package:flutter_application_6/controllers/appointment_controller.dart';
import 'package:flutter_application_6/res/components/custom_button.dart';
import 'package:flutter_application_6/res/components/custom_textfield.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class BookAppointmentView extends StatelessWidget {
  final String docId;
  final String docName;
  const BookAppointmentView(
      {super.key, required this.docId, required this.docName});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
            title: docName, color: AppColors.whiteColor, size: AppSizes.size18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.bold(title: "Select appointment Day"),
              5.heightBox,
              CustomTextField(
                  hint: "Select day",
                  textController: controller.appDayController),
              10.heightBox,
              AppStyles.bold(title: "Select appointment time"),
              5.heightBox,
              CustomTextField(
                hint: "Select time",
                textController: controller.appTimeController,
              ),
              20.heightBox,
              AppStyles.bold(title: "Phone Number"),
              5.heightBox,
              CustomTextField(
                hint: "Enter your mobile number",
                textController: controller.appMobileController,
              ),
              10.heightBox,
              AppStyles.bold(title: "Full Name:"),
              5.heightBox,
              CustomTextField(
                hint: "Enter your name",
                textController: controller.appNameController,
              ),
              10.heightBox,
              AppStyles.bold(title: "Message"),
              5.heightBox,
              CustomTextField(
                hint: "Enter your message",
                textController: controller.appMessageController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButton(
                  buttonText: "Book an appointment",
                  onTap: () async {
                    await controller.bookAppointment(docId, docName, context);
                  },
                ),
        ),
      ),
    );
  }
}
