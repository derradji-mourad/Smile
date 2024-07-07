// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_6/consts/consts.dart';
import 'package:flutter_application_6/firebase_options.dart';
import 'package:flutter_application_6/res/components/waiting_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_6/views/login_view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: AppFonts.nunito),
      debugShowCheckedModeBanner: false,
      home: const WaitingScreen(),
    );
  }
}
