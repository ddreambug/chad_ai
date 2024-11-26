class LoginResponseModel {
  final int? statusCode;
  final dynamic data;

  LoginResponseModel({
    required this.statusCode,
    required this.data,
  });

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      statusCode: map['status_code'] as int?,
      data: map['data'],
    );
  }
}
