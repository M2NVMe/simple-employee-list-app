import 'package:amazingpeoplegroup_test/Controllers/PageController.dart';
import 'package:amazingpeoplegroup_test/Pages/Profilepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';

class Utamapage extends StatelessWidget {
  Utamapage({super.key});

  final Changepagecontroller changePageController = Get.put(Changepagecontroller());
  List<Widget> pages = [Homepage(), Profilepage()];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages[changePageController.selectedindex.value],
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              // Drawer Header - User Info Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF212121)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'Selamat Datang',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),

              // Navigation Items
              Expanded(
                child: Column(
                  children: [
                    _buildDrawerItem(
                      icon: Icons.list_alt_rounded,
                      title: 'Employee List',
                      isSelected: changePageController.selectedindex.value == 0,
                      onTap: () {
                        changePageController.changeMenu(0);
                        Navigator.pop(context);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.person,
                      title: 'Profile',
                      isSelected: changePageController.selectedindex.value == 1,
                      onTap: () {
                        changePageController.changeMenu(1);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.black12,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black12 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}