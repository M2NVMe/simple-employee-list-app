import 'package:amazingpeoplegroup_test/Controllers/AuthController.dart';
import 'package:amazingpeoplegroup_test/Controllers/EmployeeController.dart';
import 'package:amazingpeoplegroup_test/Controllers/Routing/Routes.dart';
import 'package:amazingpeoplegroup_test/Pages/Homepage.dart';
import 'package:amazingpeoplegroup_test/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Employee Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.Pages,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(EmployeeController());
      }),
    );
  }
}
