import 'package:amazingpeoplegroup_test/Controllers/EmployeeController.dart';
import 'package:amazingpeoplegroup_test/widgets/detailrow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeController = Get.find<EmployeeController>();

    return Obx(() {
      final employee = employeeController.selectedEmployee.value;
      if (employee == null) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Employee Details'),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          body: Center(child: Text('No employee selected')),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Employee Details'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                Get.defaultDialog(
                  title: "Confirm Delete",
                  middleText: "Are you sure you want to delete ${employee.fullName}?",
                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    await employeeController.deleteEmployee(employee);
                    Get.back(); // close dialog
                    Get.back(); // go back to employee list
                  },
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(employee.avatar),
                      ),
                      SizedBox(height: 16),
                      Text(
                        employee.fullName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        employee.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      DetailRow(label: 'ID', value: employee.id.toString()),
                      DetailRow(label: 'First Name', value: employee.firstName),
                      DetailRow(label: 'Last Name', value: employee.lastName),
                      DetailRow(label: 'Email', value: employee.email),
                      DetailRow(
                          label: 'Position',
                          value: employee.position ?? 'Software Engineer'),
                      DetailRow(
                          label: 'Salary',
                          value: employee.salary != null
                              ? 'Rp ${employee.salary!.toStringAsFixed(0)}'
                              : 'Rp 5,000,000'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
