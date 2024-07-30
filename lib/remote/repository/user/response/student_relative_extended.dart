import 'package:base_flutter_bloc/remote/repository/user/response/student_educational_program_response.dart';
import 'package:base_flutter_bloc/remote/repository/user/response/student_of_relative_response.dart';

class StudentForRelativeExtended {
  final StudentOfRelativeResponse student;
  List<StudentEducationalProgramResponse> educationalPrograms;

  int? get id => student.id;
  String? get givenName => student.givenName;
  String? get surname => student.surname;
  String? get image => student.image;
  String? get fullName => "${student.givenName} ${student.surname}";

  StudentForRelativeExtended(this.student,
      {this.educationalPrograms = const []});

  factory StudentForRelativeExtended.fromJson(Map<dynamic, dynamic> json) {
    return StudentForRelativeExtended(
      StudentOfRelativeResponse.fromJson(json['student']),
      educationalPrograms: (json['educationalPrograms'] as List<dynamic>)
          .map((e) => StudentEducationalProgramResponse.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student': student.toJson(),
      'educationalPrograms':
          educationalPrograms.map((e) => e.toJson()).toList(),
    };
  }
}
