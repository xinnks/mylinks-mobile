import 'dart:convert';

/// success
///[{
//     results: {
//         columns: [id, email, full_name, username, created_at],
//         rows: [
//             [1, xinnks @gmail.com, James Sinkala, xinnks, 1678713960],
//             [2, foody @jamesinkala.com, Foody, foody, 1678714871],
//             [3, onetwo @domain.com, One Two, onetwo, 1678716889],
//             [4, 23 @somewhere.com, Two Three, 23, 1678717139],
//             [5, js @dog.com, Johnn Silas, jsdog, 1678718620],
//             [6, mlorndenzer @gmail.com, Mitch Lornden, mitlor, 1678980229],
//             [7, swastikayadav5358 @gmail.com, Swastika, swastika0015, 1678980238],
//             [8, someone @somemail.com, someone, someone, 1679143592]
//         ]
//     }
// }]
//
// error
/// [{error: {message: no such table: sometone}}]

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

// List<UserDetails> getUsersList(List<dynamic> columns, List<List<dynamic>> rows) {
//   final List<UserDetails> userList = <UserDetails>[];
//   for(const row in rows){
//     for(const col in columns){
//       final UserDetails user = UserDetails(id: row["$col"], email: email, fullName: fullName, username: username, createdAt: createdAt)
//     }
//   }
// }