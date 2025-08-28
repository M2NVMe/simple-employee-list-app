import 'package:amazingpeoplegroup_test/Controllers/EmployeeController.dart';
import 'package:amazingpeoplegroup_test/Controllers/Routing/Routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.find<EmployeeController>();

    // attach listener to detect scroll to bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent &&
          !employeeController.isLoading.value &&
          employeeController.currentPage.value < employeeController.totalPages.value) {
        employeeController.goToNextPage();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              employeeController.prepareFormForAdd();
              Get.toNamed(AppRoutes.employeeForm);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => employeeController.onSearchChanged(value),
              decoration: InputDecoration(
                hintText: 'Search employees...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (employeeController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return RefreshIndicator(
                onRefresh: () => employeeController.loadEmployees(),
                child: ListView.builder(
                  itemCount: employeeController.filteredEmployees.length,
                  itemBuilder: (context, index) {
                    final employee = employeeController.filteredEmployees[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(employee.avatar),
                        ),
                        title: Text(
                          employee.fullName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(employee.email),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'edit') {
                              employeeController.prepareFormForEdit(employee);
                              Get.toNamed(AppRoutes.employeeForm);
                            }
                          },
                        ),
                        onTap: () {
                          employeeController.selectedEmployee.value = employee;
                          Get.toNamed(AppRoutes.employeeDetail);
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          // Container(
          //   padding: EdgeInsets.all(16),
          //   child: Obx(() => Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       ElevatedButton(
          //         onPressed: employeeController.currentPage.value > 1
          //             ? () => employeeController.goToPreviousPage()
          //             : null,
          //         child: Text('Previous'),
          //       ),
          //       Text('Page ${employeeController.currentPage.value} of ${employeeController.totalPages.value}'),
          //       ElevatedButton(
          //         onPressed: employeeController.currentPage.value < employeeController.totalPages.value
          //             ? () => employeeController.goToNextPage()
          //             : null,
          //         child: Text('Next'),
          //       ),
          //     ],
          //   )),
          // ),
        ],
      ),
    );
  }
}
