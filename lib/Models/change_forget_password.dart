class ForgetPasswordResponseModel {
  late String status, message;
  late String otp, userId;

  ForgetPasswordResponseModel(
      {required this.status,
      required this.message,
      required this.otp,
      required this.userId});

  ForgetPasswordResponseModel.fromJson(Map<String, dynamic> jsonResponse) {
    status = jsonResponse['status'];
    message = jsonResponse['message'];
    if (jsonResponse['otp'] != null) {
      otp = jsonResponse['otp'] ?? "0";
      userId = jsonResponse['user_id'] ?? "0";
    }
  }
}

class ChangePasswordResponseModel {
  late String status, message;

  ChangePasswordResponseModel({
    required this.status,
    required this.message,
  });

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> jsonResponse) {
    status = jsonResponse['status'];
    message = jsonResponse['message'];
  }
}
