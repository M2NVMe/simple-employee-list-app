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
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    isLoading.value = true;

    final result = await _apiService.getEmployees(currentPage.value);

    if (result['success']) {
      employees.value = result['employees'];
      totalPages.value = result['totalPages'];
      filterEmployees();
    } else {
      Get.snackbar(
        'Error',
        result['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }

  void filterEmployees() {
    if (searchQuery.value.isEmpty) {
      filteredEmployees.value = employees;
    } else {
      filteredEmployees.value = employees.where((employee) {
        return employee.fullName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            employee.email.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    filterEmployees();
  }

  Future<void> goToNextPage() async {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      await loadEmployees();
    }
  }

  Future<void> goToPreviousPage() async {
    if (currentPage.value > 1) {
      currentPage.value--;
      await loadEmployees();
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
        : await _apiService.updateEmployee(selectedEmployee.value!.id, employeeData);

    isFormLoading.value = false;

    if (result['success']) {
      Get.back();
      loadEmployees();
      Get.snackbar(
        'Success',
        selectedEmployee.value == null
            ? 'Employee created successfully!'
            : 'Employee updated successfully!',
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