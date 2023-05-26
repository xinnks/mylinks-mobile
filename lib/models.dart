import 'dart:convert';
class TursoResponse {
  final dynamic response;

  TursoResponse({this.response});

  factory TursoResponse.fromJson(Map<String, dynamic> json) => TursoResponse(
        response: json["results"] != null
            ? SuccessData.fromJson(json["results"])
            : ErrorData.fromJson(json["error"]),
      );
}

class ErrorData {
  final String message;

  ErrorData({required this.message});

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      ErrorData(message: json["message"]!);

  @override
  String toString() {
    if (message.isNotEmpty) {
      return message;
    }
    return "An error Occured";
  }
}

SuccessData tursoResponseFromJson(String str) =>
    SuccessData.fromJson(json.decode(str));

class SuccessData {
  final List<dynamic> columns;
  final List<List<dynamic>> rows;

  SuccessData({required this.rows, required this.columns});

  factory SuccessData.fromJson(Map<String, dynamic> json) => SuccessData(
      rows: List<List<dynamic>>.from(json["rows"]),
      columns: List<dynamic>.from(json["columns"]));
}

class UserDetails {
  final int id;
  final String email;
  final String fullName;
  final String username;
  final int createdAt;

  UserDetails(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.username,
      required this.createdAt});
}

class SocialLinks {
  final String? facebook;
  final String? youtube;
  final String? linkedin;
  final String? twitter;
  final String? github;

  SocialLinks({
    required this.facebook,
    required this.youtube,
    required this.linkedin,
    required this.twitter,
    required this.github,
  });
}
