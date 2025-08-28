import 'package:amazingpeoplegroup_test/Controllers/EmployeeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeController = Get.find<EmployeeController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(employeeController.selectedEmployee.value == null
            ? 'Add Employee'
            : 'Edit Employee')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: employeeController.firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: employeeController.lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: employeeController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: employeeController.positionController,
                decoration: InputDecoration(
                  labelText: 'Position',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: employeeController.salaryController,
                decoration: InputDecoration(
                  labelText: 'Salary (IDR)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Obx(() => ElevatedButton(
                  onPressed: employeeController.isFormLoading.value
                      ? null
                      : () => employeeController.saveEmployee(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: employeeController.isFormLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                    employeeController.selectedEmployee.value == null
                        ? 'Add Employee'
                        : 'Update Employee',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}