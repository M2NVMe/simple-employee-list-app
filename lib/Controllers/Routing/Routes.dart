import 'package:amazingpeoplegroup_test/Pages/EmployeeExtended/detailed.dart';
import 'package:amazingpeoplegroup_test/Pages/EmployeeExtended/form.dart';
import 'package:amazingpeoplegroup_test/Pages/Homepage.dart';
import 'package:amazingpeoplegroup_test/Pages/LoginPage.dart';
import 'package:amazingpeoplegroup_test/Pages/Utamapage.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const utama = '/utama';
  static const dashboard = '/dashboard';
  static const employeeForm = '/employee-form';
  static const employeeDetail = '/employee-detail';

  static List<GetPage> Pages = [
    GetPage(name: login, page: () => Loginpage()),
    GetPage(name: utama, page: () => Utamapage()),
    GetPage(name: dashboard, page: () => Homepage()),
    GetPage(name: employeeForm, page: () => EmployeeFormScreen()),
    GetPage(name: employeeDetail, page: () => EmployeeDetailScreen()),
  ];
}