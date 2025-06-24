class FaceVerificationModel {
  final bool isPunchIn;
  String? capturedImagePath;
  bool isVerified;

  FaceVerificationModel({
    required this.isPunchIn,
    this.capturedImagePath,
    this.isVerified = false,
  });
}
