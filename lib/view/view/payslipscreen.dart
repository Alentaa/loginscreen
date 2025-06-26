import 'package:flutter/material.dart';
import 'package:loginscreen/viewmodel/payslipvm.dart';
import 'package:loginscreen/widgets/payslipwidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/app_colors.dart';

class PayslipScreen extends StatelessWidget {
  const PayslipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PayslipViewModel(),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) => Scaffold(
          backgroundColor: AppColors.white,
          body: Consumer<PayslipViewModel>(
            builder: (context, model, _) => Column(
              children: [
                buildHeader(context),
                buildSubHeaderWithLogo(model.month),
                Divider(height: 1.h, thickness: 1, color: Colors.grey.shade300),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(4.w),
                    children: [
                      employeeSummary(model),
                      SizedBox(height: 2.h),
                      Divider(thickness: 1, color: Colors.grey.shade300),
                      SizedBox(height: 1.h),
                      buildPFandUANRow(model),
                      SizedBox(height: 2.h),
                      earningsAndDeductionsTable(model),
                      SizedBox(height: 2.h),
                      netPaySummary(model),
                      SizedBox(height: 2.h),
                      downloadButton(model),
                      SizedBox(height: 3.h),
                      monthlyPayslipHistory(model),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: AppColors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.time_to_leave), label: 'Leave'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}