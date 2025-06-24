import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../viewmodel/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Stack(
            children: [
            
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 45.w,
                  height: 15.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(120),
                    ),
                    color: Color(0xFF2196F3),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 45.w,
                  height: 13.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                    ),
                    color: Color(0xFF43A047),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'ZiyaAttend',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Smart Attendance Maintainer',
                        style: TextStyle(fontSize: 17.sp, color: Colors.green),
                      ),
                      SizedBox(height: 6.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email or Mobile Number',
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter your email'
                                          : null,
                            ),
                            SizedBox(height: 2.5.h),
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password / OTP',
                              obscureText: true,
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter your password'
                                          : null,
                            ),
                            SizedBox(height: 4.h),
                            loginVM.isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                  width: 100.w,
                                  height: 6.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2196F3),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final user = await loginVM.login(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        );
                                        if (user != null) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder:
                                                (context) => AlertDialog(
                                                  title: Text(
                                                    'Login Successful',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color:
                                                          const Color.fromARGB(255, 9, 9, 9),
                                                    ),
                                                  ),
                                                  content: Text(
                                                    'Welcome!',
                                                    style: TextStyle(
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                        Navigator.pushReplacementNamed(
                                                          context,
                                                          '/home',
                                                        );
                                                      },
                                                      child: Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('Login failed'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pushNamed(
                                        context,
                                        '/forgot-password',
                                      ),
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed:
                                      () => Navigator.pushNamed(
                                        context,
                                        '/signup',
                                      ),
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      ),
    );
  }
}
