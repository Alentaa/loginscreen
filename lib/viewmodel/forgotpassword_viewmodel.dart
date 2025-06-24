import 'package:flutter/material.dart';
import 'package:loginscreen/viewmodel/auth_service.dart';


class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;

  Future<bool> sendResetLink(String email) async {
    try {
      isLoading = true;
      notifyListeners();

      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      print('ForgotPassword Error: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
