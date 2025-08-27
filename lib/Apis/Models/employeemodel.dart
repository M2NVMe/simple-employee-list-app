class Employee {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  String? position;
  double? salary;

  Employee({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.position,
    this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      position: json['position'],
      salary: json['salary']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'position': position,
      'salary': salary,
    };
  }

  String get fullName => '$firstName $lastName';
}
