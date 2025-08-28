import 'package:amazingpeoplegroup_test/Apis/apiservice.dart';
import 'package:amazingpeoplegroup_test/Controllers/Routing/Routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final storage = GetStorage();

  final RxBool isSigning = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// 🔹 Check if user already logged in from previous session
  void checkLoginStatus() {
    String? token = storage.read('token');
    String? savedEmail = storage.read('userEmail');

    if (token != null) {
      isLoggedIn.value = true;
      userEmail.value = savedEmail ?? '';
      // Auto-redirect to main page if already logged in
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(AppRoutes.utama);
      });
    } else {
      isLoggedIn.value = false;
    }
  }

  /// 🔹 Login and persist credentials
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    final result = await _apiService.login(
      emailController.text.trim(),
      passwordController.text,
    );

    isLoading.value = false;

    if (result['success']) {
      isLoggedIn.value = true;
      userEmail.value = emailController.text.trim();

      // ✅ persist token + email
      storage.write('userEmail', emailController.text.trim());
      storage.write('token', result['token']);

      Get.offAllNamed(AppRoutes.utama);
      Get.snackbar('Success', 'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Error', result['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  /// 🔹 Logout and clear storage
  void logout() {
    _apiService.logout();
    storage.remove('userEmail');
    storage.remove('token');

    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar('Success', 'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
