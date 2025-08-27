import 'package:amazingpeoplegroup_test/Pages/Homepage.dart';
import 'package:amazingpeoplegroup_test/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flutter Amazing People Group",
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => Loginpage()),
        GetPage(name: "/home", page: () => Homepage()),
      ],
    );
  }
}
