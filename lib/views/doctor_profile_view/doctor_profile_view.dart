// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_6/consts/consts.dart';
import 'package:flutter_application_6/controllers/appointment_controller.dart';
import 'package:flutter_application_6/res/components/custom_button.dart';
import 'package:flutter_application_6/views/book_appointment_view/book_appointment_view.dart';
import 'package:flutter_application_6/views/model_data_view/model_data_view.dart';
import 'package:get/get.dart';

class DoctorProfileView extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfileView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      appBar: AppBar(
        title: AppStyles.bold(
            title: "Doctor Details",
            color: AppColors.whiteColor,
            size: AppSizes.size18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset(
                        AppAssets.imgSignup,
                      ),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStyles.bold(
                              title: doc['docName'],
                              color: AppColors.whiteColor,
                              size: AppSizes.size14),
                          AppStyles.bold(
                            title: doc['docCategory'],
                            color: AppColors.textColor.withOpacity(0.5),
                            size: AppSizes.size12,
                          ),
                          const Spacer(),
                          VxRating(
                            selectionColor: AppColors.yellowColor,
                            onRatingUpdate: (value) {},
                            maxRating: 5,
                            count: 5,
                            value: double.parse(doc['docRating'].toString()),
                            stepInt: true,
                          )
                        ],
                      ),
                    ),
                    AppStyles.bold(
                        title: "See alll reviews",
                        color: AppColors.blueColor,
                        size: AppSizes.size12),
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: AppStyles.bold(
                          title: "Phone Number", color: AppColors.textColor),
                      subtitle: AppStyles.normal(
                          title: doc['docPhone'],
                          color: AppColors.textColor.withOpacity(0.5),
                          size: AppSizes.size12),
                      trailing: Container(
                          width: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.yellowColor,
                          ),
                          child:
                              Icon(Icons.phone, color: AppColors.whiteColor)),
                    ),
                    10.heightBox,
                    AppStyles.bold(
                        title: "About",
                        color: AppColors.textColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: doc['docAbout'],
                        color: AppColors.textColor.withOpacity(0.5),
                        size: AppSizes.size12),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Address",
                        color: AppColors.textColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: doc['docAddress'],
                        color: AppColors.textColor.withOpacity(0.5),
                        size: AppSizes.size12),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Working Time",
                        color: AppColors.textColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(
                        title: doc['docTiming'],
                        color: AppColors.textColor.withOpacity(0.5),
                        size: AppSizes.size12),
                    10.heightBox,
                    AppStyles.bold(
                        title: "Services",
                        color: AppColors.textColor,
                        size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.bold(
                        title: doc['docServive'],
                        color: AppColors.textColor.withOpacity(0.5),
                        size: AppSizes.size12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              buttonText: "Traitment D'urgance",
              onTap: () {
                Get.to(() => DiagnosisFormScreen());
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              buttonText: "Book an Appointment",
              onTap: () {
                Get.to(() => BookAppointmentView(
                    docId: doc['docId'], docName: doc['docName']));
              },
            ),
          ],
        ),
      ),
    );
  }
}
