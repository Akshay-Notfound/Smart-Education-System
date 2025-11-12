class Student {
  final String id;
  final String name;
  final String email;
  final String rollNumber;
  final String department;
  final int year;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.rollNumber,
    required this.department,
    required this.year,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      rollNumber: json['rollNumber'],
      department: json['department'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'rollNumber': rollNumber,
      'department': department,
      'year': year,
    };
  }
}