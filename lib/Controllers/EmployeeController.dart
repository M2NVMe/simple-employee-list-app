import 'package:amazingpeoplegroup_test/Apis/Models/employeemodel.dart';
import 'package:amazingpeoplegroup_test/Apis/apiservice.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EmployeeController extends GetxController {
  final ApiService _apiService = ApiService();

  var employees = <Employee>[].obs;
  var filteredEmployees = <Employee>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var searchQuery = ''.obs;

  // Form controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final positionController = TextEditingController();
  final salaryController = TextEditingController();

  var isFormLoading = false.obs;
  var selectedEmployee = Rxn<Employee>();

  @override
  void onInit() {
    super.onInit();
    loadAllEmployees();
  }

  Future<void> loadAllEmployees() async {
    isLoading.value = true;
    employees.clear();

    int page = 1;
    bool more = true;

    while (more) {
      final result = await _apiService.getEmployees(page);
      if (result['success']) {
        employees.addAll(result['employees']);
        totalPages.value = result['totalPages'];
        page++;
        more = page <= totalPages.value;
      } else {
        more = false;
        Get.snackbar(
          'Error',
          result['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
    // Start with all employees visible
    filteredEmployees.value = List<Employee>.from(employees);
    isLoading.value = false;
  }

  void filterEmployees() {
    if (searchQuery.value.isEmpty) {
      // 👇 make a copy
      filteredEmployees.value = List<Employee>.from(employees);
    } else {
      filteredEmployees.value = employees.where((employee) {
        return employee.fullName
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            employee.email
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredEmployees.value = List<Employee>.from(employees);
    } else {
      filteredEmployees.value = employees.where((employee) {
        return employee.fullName.toLowerCase().contains(query.toLowerCase()) ||
            employee.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  Future<void> goToNextPage() async {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      await loadAllEmployees();
    }
  }

  Future<void> goToPreviousPage() async {
    if (currentPage.value > 1) {
      currentPage.value--;
      await loadAllEmployees();
    }
  }

  void prepareFormForAdd() {
    selectedEmployee.value = null;
    clearForm();
  }

  void prepareFormForEdit(Employee employee) {
    selectedEmployee.value = employee;
    firstNameController.text = employee.firstName;
    lastNameController.text = employee.lastName;
    emailController.text = employee.email;
    positionController.text = employee.position ?? '';
    salaryController.text = employee.salary?.toString() ?? '';
  }

  void clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    positionController.clear();
    salaryController.clear();
  }

  Future<void> saveEmployee() async {
    if (!_validateForm()) return;

    isFormLoading.value = true;

    final employeeData = {
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'email': emailController.text.trim(),
      'position': positionController.text.trim(),
      'salary': double.parse(salaryController.text),
    };

    final result = selectedEmployee.value == null
        ? await _apiService.createEmployee(employeeData)
        : await _apiService.updateEmployee(
            selectedEmployee.value!.id, employeeData);

    isFormLoading.value = false;

    if (result['success']) {
      final employee = result['employee'] as Employee;

      if (selectedEmployee.value == null) {
        employees.add(employee);
      } else {
        final index = employees.indexWhere((e) => e.id == employee.id);
        if (index != -1) {
          employees[index] = employee;
        }
      }

      filterEmployees();
      Get.back();
      Get.snackbar(
        'Success',
        selectedEmployee.value == null
            ? 'Employee created successfully!'
            : 'Employee updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
    else {
      Get.snackbar(
        'Error',
        result['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteEmployee(Employee employee) async {
    final result = await _apiService.deleteEmployee(employee.id);

    if (result['success']) {
      employees.removeWhere((e) => e.id == employee.id);
      filterEmployees();

      Get.snackbar(
        'Success',
        'Employee deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        result['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  bool _validateForm() {
    if (firstNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter first name');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter last name');
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter email');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return false;
    }
    if (positionController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter position');
      return false;
    }
    if (salaryController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter salary');
      return false;
    }

    double? salary = double.tryParse(salaryController.text);
    if (salary == null) {
      Get.snackbar('Error', 'Please enter a valid salary');
      return false;
    }
    if (salary < 1000000) {
      Get.snackbar('Error', 'Salary must be at least 1,000,000');
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    positionController.dispose();
    salaryController.dispose();
    super.onClose();
  }
}
