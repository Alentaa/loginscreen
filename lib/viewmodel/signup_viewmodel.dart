import 'package:flutter/material.dart';
import 'package:loginscreen/viewmodel/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService;

  SignupViewModel(this._authService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<User?> signUp(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    User? user = await _authService.registerWithEmailAndPassword(email, password, name);

    _isLoading = false;
    notifyListeners();

    return user;
  }
}
