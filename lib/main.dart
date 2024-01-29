import 'package:flutter/material.dart';
import 'package:flutter_venturo/controller/api_controller.dart';
import 'package:flutter_venturo/views/screen_home.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mealController = Get.put(MealController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ScreenHome(),
    );
  }
}
