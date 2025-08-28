import 'package:amazingpeoplegroup_test/Controllers/EmployeeController.dart';
import 'package:amazingpeoplegroup_test/widgets/detailrow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeController = Get.find<EmployeeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          final employee = employeeController.selectedEmployee.value;
          if (employee == null) {
            return Center(child: Text('No employee selected'));
          }

          return Column(
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
                          value: employee.position ?? 'Software Engineer'
                      ),
                      DetailRow(
                          label: 'Salary',
                          value: employee.salary != null
                              ? 'Rp ${employee.salary!.toStringAsFixed(0)}'
                              : 'Rp 5,000,000'
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}