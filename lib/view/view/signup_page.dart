import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/viewmodel/signup_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupVM = Provider.of<SignupViewModel>(context);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 180,
                  height: 120,
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
                  height: 10.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                    ),
                    color: Color(0xFF43A047),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(4.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          'ZiyaAttend',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Create an account',
                        style: TextStyle(fontSize: 18.sp, color: Colors.green),
                      ),
                      SizedBox(height: 5.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _nameController,
                              label: 'Name',
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter your name'
                                          : null,
                            ),
                            SizedBox(height: 2.h),
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 2.h),
                            _buildTextField(
                              controller: _mobileController,
                              label: 'Mobile Number',
                              keyboardType: TextInputType.phone,
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter your mobile number'
                                          : null,
                            ),
                            SizedBox(height: 2.h),
                            _buildTextField(
                              controller: _passwordController,
                              label: 'Password',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 4.h),
                            signupVM.isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                  width: double.infinity,
                                  height: 6.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF2196F3),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final user = await signupVM.signUp(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                          _nameController.text.trim(),
                                        );
                                        if (user != null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Signup sucessful!',
                                              ),
                                              backgroundColor: AppColors.green,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                          await Future.delayed(
                                            const Duration(seconds: 1),
                                          );
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/login',
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Signup failed. Try again.',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                TextButton(
                                  onPressed:
                                      () => Navigator.pushReplacementNamed(
                                        context,
                                        '/login',
                                      ),
                                  child: Text(
                                    'Login',
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
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      ),
    );
  }
}
