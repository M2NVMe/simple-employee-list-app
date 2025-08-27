import 'dart:convert';
import 'package:amazingpeoplegroup_test/Apis/Models/employeemodel.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  static const String baseUrl = 'https://reqres.in/api';
  static const String apiKey = 'reqres-free-v1';
  final storage = GetStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-Key': apiKey,
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        storage.write('token', data['token']);
        return {'success': true, 'token': data['token']};
      } else {
        final error = json.decode(response.body);
        return {'success': false, 'message': error['error'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  Future<Map<String, dynamic>> getEmployees(int page) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users?page=$page'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Employee> employees = (data['data'] as List)
            .map((item) => Employee.fromJson(item))
            .toList();

        return {
          'success': true,
          'employees': employees,
          'totalPages': data['total_pages'],
          'currentPage': data['page'],
        };
      } else {
        return {'success': false, 'message': 'Failed to fetch employees'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  Future<Map<String, dynamic>> getEmployee(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$id'),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        Employee employee = Employee.fromJson(data['data']);
        return {'success': true, 'employee': employee};
      } else {
        return {'success': false, 'message': 'Employee not found'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  Future<Map<String, dynamic>> createEmployee(Map<String, dynamic> employeeData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: _getHeaders(),
        body: json.encode(employeeData),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return {'success': true, 'employee': data};
      } else {
        return {'success': false, 'message': 'Failed to create employee'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  Future<Map<String, dynamic>> updateEmployee(int id, Map<String, dynamic> employeeData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: _getHeaders(),
        body: json.encode(employeeData),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {'success': true, 'employee': data};
      } else {
        return {'success': false, 'message': 'Failed to update employee'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  Map<String, String> _getHeaders() {
    String? token = storage.read('token');

    return {
      'Content-Type': 'application/json',
      'X-API-Key': apiKey,
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  void logout() {
    storage.remove('token');
  }
}