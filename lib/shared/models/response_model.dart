class ResponseModel {
  final int? statusCode;
  final dynamic data;

  ResponseModel({
    required this.statusCode,
    required this.data,
  });

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      statusCode: map['status_code'] as int?,
      data: map['data'],
    );
  }
}
