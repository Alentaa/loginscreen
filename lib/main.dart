import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginscreen/view/view/forgotpassword_page.dart';
import 'package:loginscreen/view/view/holidayScreen.dart';
import 'package:loginscreen/view/view/login_page.dart';
import 'package:loginscreen/view/view/payslipscreen.dart';
import 'package:loginscreen/view/view/signup_page.dart';
import 'package:loginscreen/view/view/homescreen.dart';
import 'package:loginscreen/viewmodel/auth_service.dart';
import 'package:loginscreen/viewmodel/login_viewmodel.dart';
import 'package:loginscreen/viewmodel/signup_viewmodel.dart';
import 'package:loginscreen/viewmodel/checkinprovider.dart';
import 'package:loginscreen/viewmodel/attendance_viewmodel.dart'; // ✅ Add this import
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            Provider<AuthService>(create: (_) => AuthService()),

            ChangeNotifierProvider<LoginViewModel>(
              create: (context) => LoginViewModel(),
            ),

            ChangeNotifierProvider<SignupViewModel>(
              create: (context) => SignupViewModel(context.read<AuthService>()),
            ),

            ChangeNotifierProvider<CheckinProvider>(
              create: (_) => CheckinProvider(),
            ),

            ChangeNotifierProvider<AttendanceViewModel>(
              // ✅ Add this line
              create: (_) => AttendanceViewModel(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ZiyaAttend',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/login',
            routes: {
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignupPage(),
              '/forgot-password': (context) => ForgotPasswordPage(),
              '/home': (context) => HomeScreen(),
              '/holidayscreen':(context) => HolidayScreen(),
              '/payslip':(context) => PayslipScreen(),
            },
          ),
        );
      },
    );
  }
}
