import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/upload_controller.dart';
import 'ui/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UploadController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}