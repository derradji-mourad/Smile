import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/views/doctor_profile_view/doctor_profile_view.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  const CategoryDetailsView({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
            title: catName, color: AppColors.whiteColor, size: AppSizes.size18),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('doctors')
            .where('docCategory', isEqualTo: catName)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 170,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: AppColors.bgDarkColor,
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(right: 8),
                    height: 100,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: AppColors.blueColor,
                          child: Image.asset(
                            AppAssets.imgSignup,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        5.heightBox,
                        AppStyles.normal(title: data![index]['docName']),
                        VxRating(
                          selectionColor: AppColors.yellowColor,
                          onRatingUpdate: (value) {},
                          maxRating: 5,
                          count: 5,
                          value:
                              double.parse(data[index]['docRating'].toString()),
                          stepInt: true,
                        )
                      ],
                    ),
                  ).onTap(() {
                    Get.to(() => DoctorProfileView(doc: data[index]));
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
