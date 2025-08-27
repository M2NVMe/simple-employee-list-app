import 'package:amazingpeoplegroup_test/Controllers/AuthController.dart';
import 'package:amazingpeoplegroup_test/widgets/custom_button.dart';
import 'package:amazingpeoplegroup_test/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Employee List App',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff313131),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                // Email Header
                _buildHeader('Email'),
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: _authController.emailController,
                  onChanged: (value) {}, // Placeholder to keep existing functionality
                  borderColor: Color(0xff9A9A9A),
                  textColor: Color(0xff313131),
                  borderRadius: 14,
                ),
                SizedBox(height: 24),

                // Password Header
                _buildHeader('Password'),
                Obx(() {
                  return CustomTextField(
                    hintText: 'Enter your password',
                    controller: _authController.passwordController,
                    obscureText: !_authController.isPasswordVisible.value,
                    onChanged: (value) {}, // Placeholder to keep existing functionality
                    borderColor: Color(0xff9A9A9A),
                    textColor: Color(0xff313131),
                    borderRadius: 14,
                    maxLines: 1,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _authController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _authController.togglePasswordVisibility,
                    ),
                  );
                }),
                SizedBox(height: 32),
                // Login Button
                Obx(() {
                  return CustomButton(
                    text: _authController.isSigning.value
                        ? 'Signing In...'
                        : 'Log in',
                    onPressed: _authController.isSigning.value
                        ? null
                        : () => _authController.login(),
                    backgroundColor: Color(0xff313131),
                    textColor: Colors.white,
                    textSize: 16,
                    fontWeight: FontWeight.w600,
                    buttonType: ButtonType.elevated,
                    borderWidth: 0,
                    borderColor: Color(0xff313131),
                    buttonWidth: 365,
                    buttonHeight: 50,
                    borderRadius: 14,
                  );
                }),
                SizedBox(height: 24),
                // Divider with "Or"
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xff4D4D4D),
          ),
        ),
      ),
    );
  }
}
