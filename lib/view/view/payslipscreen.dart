import 'package:flutter/material.dart';
import 'package:loginscreen/viewmodel/payslipvm.dart';
import 'package:loginscreen/widgets/payslipwidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/app_colors.dart';

class PayslipScreen extends StatelessWidget {
  final String month;
  const PayslipScreen({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PayslipViewModel(
        name: "Alenta",
        designation: "Full-stack Developer",
        employeeId: "EMP123",
        joiningDate: "30/05/2025",
        payPeriod: month, //  dynamic month used here
        payDate: "15/07/2025",
        netPay: "₹ 45,000",
        pfAccountNumber: "AA/AAA/999999/99G/9899",
        uanNumber: "111111111111",
        earnings: [
          {"title": "Basic", "amount": "₹ 25,000", "ytd": "₹ 3,00,000"},
          {"title": "HRA", "amount": "₹ 10,000", "ytd": "₹ 1,20,000"},
          {"title": "Travel Allowance", "amount": "₹ 3,000", "ytd": "₹ 36,000"},
          {"title": "Meal / Other Allowance", "amount": "₹ 2,000", "ytd": "₹ 24,000"},
        ],
        deductions: [
          {"title": "PF Deduction", "amount": "₹ 2,500", "ytd": "₹ 30,000"},
          {"title": "Tax Deduction", "amount": "₹ 7,500", "ytd": "₹ 90,000"},
        ],
      ),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) => Scaffold(
          backgroundColor: AppColors.white,
          body: Consumer<PayslipViewModel>(
            builder: (context, model, _) => Column(
              children: [
                buildHeader(context),
                buildSubHeaderWithLogo(model.payPeriod), //  Reflects the month dynamically
                Divider(height: 1.h, thickness: 1, color: AppColors.grey),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(4.w),
                    children: [
                      employeeSummary(model),
                      SizedBox(height: 2.h),
                      Divider(thickness: 1, color: AppColors.grey),
                      SizedBox(height: 1.h),
                      buildPFandUANRow(model),
                      SizedBox(height: 2.h),
                      earningsAndDeductionsTable(model),
                      SizedBox(height: 2.h),
                      netPaySummary(model),
                      SizedBox(height: 2.h),
                      downloadButton(model),
                      SizedBox(height: 3.h),
                      monthlyPayslipHistory(model, context),
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
