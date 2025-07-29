import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/view/view/notification.dart';
import 'package:loginscreen/view/view/payslipscreen.dart';
import 'package:loginscreen/view/view/profilescreen.dart';
import 'package:loginscreen/viewmodel/payslipvm.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Header Widget
Widget buildHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    color: Colors.white,
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/home'),
          child: CircleAvatar(
            radius: 3.h,
            backgroundImage: AssetImage('asset/ziya academy logo.jpg'),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationScreen(),
              ),
            );
          },
          child: const Icon(Icons.notifications_none, color: Colors.blue),
        ),

        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
          child: const CircleAvatar(
            radius: 21,
            backgroundImage: AssetImage('asset/profile.jpeg'),
          ),
        ),
      ],
    ),
  );
}

// Sub Header with Logo and Month
Widget buildSubHeaderWithLogo(String month) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
    child: Row(
      children: [
        Image.asset(
          'asset/logo_withoutbackground-removebg-preview.png',
          width: 12.w,
          height: 12.w,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ZiyaAcademy',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Text(
                'KEY-TO SUCCESS',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Payslip for the Month',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
            ),
            Text(
              month,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget employeeSummary(PayslipViewModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "EMPLOYEE SUMMARY",
        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 2.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow("Employee Name", "Alenta"),
                _detailRow("Designation", model.designation),
                _detailRow("Employee ID", "Employee ID"),
                _detailRow("Date of Joining", model.joiningDate),
                _detailRow("Pay Period", model.payPeriod),
                _detailRow("Pay Date", model.payDate),
              ],
            ),
          ),
          SizedBox(width: 0.w),

          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFD3F3D0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFD3F3D0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.netPay,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "Employee Net Pay",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    height: 2.h,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _payDetailRow("Paid Days", "31"),
                        _payDetailRow("LOP Days", "0"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildPFandUANRow(PayslipViewModel model) {
  return Padding(
    padding: EdgeInsets.symmetric(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // PF Section (Left aligned)
        Row(
          children: [
            Text(
              'PF A/C Number: ',
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
            ),
            Text(
              'AA/AAA/999999/99G/9899',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        // UAN Section (Right aligned)
        Row(
          children: [
            Text(
              'UAN: ',
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
            ),
            Text(
              '111111111111',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _detailRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 0.5.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 35.w,
          child: Text(
            "$title :",
            style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          ),
        ),
      ],
    ),
  );
}

Widget _payDetailRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 0.5.h),
    child: Row(
      children: [
        Text(
          "$title : ",
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ],
    ),
  );
}

// Earnings & Deductions Table
Widget earningsAndDeductionsTable(PayslipViewModel model) {
  return Table(
    border: TableBorder.all(color: Colors.grey.shade400),
    columnWidths: const {
      0: FlexColumnWidth(2), // Earnings
      1: FlexColumnWidth(2), // Amount
      2: FlexColumnWidth(2), // YTD
      3: FlexColumnWidth(3), // Deductions
      4: FlexColumnWidth(2), // Amount
      5: FlexColumnWidth(2), // YTD
    },
    children: [
      // Header row
      TableRow(
        decoration: BoxDecoration(color: AppColors.grey),
        children: [
          tableHeader('EARNINGS'),
          tableHeader('AMOUNT'),
          tableHeader('YTD'),
          tableHeader('DEDUCTIONS'),
          tableHeader('AMOUNT'),
          tableHeader('YTD'),
        ],
      ),

      // Data rows
      tableRow(
        'Basic',
        '₹ 25,000',
        '₹ 3,00,000',
        'PF Deduction',
        '₹ 2,500',
        '₹ 30,000',
      ),
      tableRow(
        'HRA',
        '₹ 10,000',
        '₹ 1,20,000',
        'Tax Deduction',
        '₹ 7,500',
        '₹ 90,000',
      ),
      tableRow('Travel Allowance', '₹ 3,000', '₹ 36,000', '', '', ''),
      tableRow('Meal / Other Allowance', '₹ 2,000', '₹ 24,000', '', '', ''),

      // Footer row
      TableRow(
        decoration: BoxDecoration(color: AppColors.lightblue),
        children: [
          tableFooter('Gross Earnings'),
          tableFooter('₹ 55,000'),
          tableFooter(''),
          tableFooter('Total Deductions'),
          tableFooter('₹ 10,000'),
          tableFooter(''),
        ],
      ),
    ],
  );
}

// Helper for table header cell
Widget tableHeader(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
    ),
  );
}

// Helper for table body row
TableRow tableRow(
  String e1,
  String e2,
  String e3,
  String d1,
  String d2,
  String d3,
) {
  return TableRow(
    children: [
      tableCell(e1),
      tableCell(e2),
      tableCell(e3),
      tableCell(d1),
      tableCell(d2),
      tableCell(d3),
    ],
  );
}

// Helper for regular cell
Widget tableCell(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
    child: Text(
      text,
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
    ),
  );
}

// Helper for footer cell
Widget tableFooter(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
    child: Text(
      text,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
    ),
  );
}

// Net Pay Summary
Widget netPaySummary(PayslipViewModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Net Payable',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                model.netPay,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 0.5.h),
        child: const Text(
          'Amount in Words:    Indian Rupee Forty-Five Thousand Only',
          style: TextStyle(fontSize: 13),
        ),
      ),
    ],
  );
}

// Download PDF Button
Widget downloadButton(PayslipViewModel model) {
  return Center(
    child: InkWell(
      onTap: model.generateAndDownloadPDF,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          'Download the sample salary slip format for PDF',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget monthlyPayslipHistory(PayslipViewModel model, BuildContext context) {
  final headerStyle = TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold);
  final style = TextStyle(fontSize: 15.sp);

  final data = [
    ['May 2025', '₹45,000', 'Generated', 'Download'],
    ['April 2025', '₹43,500', 'Generated', 'Download'],
    ['March 2025', '₹41,000', 'Generated', 'Download'],
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Monthly Payslip History',
        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 1.h),
      Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
          3: FlexColumnWidth(3),
        },
        children: [
          TableRow(
            children:
                ['Month', 'Net Pay', 'Status', 'Action']
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Text(e, style: headerStyle),
                      ),
                    )
                    .toList(),
          ),
          ...data.map(
            (row) => TableRow(
              children: [
                // Month (clickable)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PayslipScreen(month: row[0]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(1.h),
                    child: Text(
                      row[0],
                      style: style.copyWith(color: Colors.blue),
                    ),
                  ),
                ),
                // Other cells
                ...row
                    .sublist(1)
                    .map(
                      (cell) => Padding(
                        padding: EdgeInsets.all(1.h),
                        child: Text(cell, style: style),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
