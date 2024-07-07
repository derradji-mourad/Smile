import 'package:flutter/material.dart';
import 'package:flutter_application_6/consts/colors.dart';
import 'package:flutter_application_6/views/appointment_view/appointment_view.dart';
import 'package:flutter_application_6/views/category_view.dart/category_view.dart';
import 'package:flutter_application_6/views/home_view/home_view.dart';
import 'package:flutter_application_6/views/settings_view/settings_view.dart';

class HOme extends StatefulWidget {
  const HOme({super.key});

  @override
  State<HOme> createState() => _HOmeState();
}

class _HOmeState extends State<HOme> {
  int selectedIndex = 0;
  List screenList = [
    const HomeView(),
    const AppointmentView(),
    const CategoryView(),
    const SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: AppColors.whiteColor,
        selectedLabelStyle: TextStyle(
          color: AppColors.whiteColor,
        ),
        selectedIconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.blueColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: "Appointments"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Cetegory"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
