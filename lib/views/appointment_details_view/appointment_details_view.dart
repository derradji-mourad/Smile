// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/res/components/custom_textfield.dart';

import '../../consts/consts.dart';

class AppointmentDetailsView extends StatelessWidget {
  final DocumentSnapshot doc;
  const AppointmentDetailsView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
            title: doc['appWithName'],
            color: AppColors.whiteColor,
            size: AppSizes.size18),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyles.bold(title: "Select appointment Day"),
            5.heightBox,
            AppStyles.normal(title: doc['appDay']),
            10.heightBox,
            AppStyles.bold(title: "Select appointment time"),
            5.heightBox,
            AppStyles.normal(title: doc['appTime']),
            20.heightBox,
            AppStyles.bold(title: "Phone Number"),
            5.heightBox,
            AppStyles.normal(title: doc['appMobile']),
            10.heightBox,
            AppStyles.bold(title: "Full Name:"),
            5.heightBox,
            AppStyles.bold(title: doc['appName']),
            10.heightBox,
            AppStyles.bold(title: "Message"),
            5.heightBox,
            AppStyles.normal(title: doc['appMsg']),
          ],
        ),
      ),
    );
  }
}
