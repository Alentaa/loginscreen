import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PayslipViewModel extends ChangeNotifier {
  final String name = "Alenta";
  final String designation = "Full-stack Developer";
  final String employeeId = "EMP123";
  final String joiningDate = "30/05/2025";
  final String payPeriod = "June 2025";
  final String payDate = "15/07/2025";
  final String netPay = "₹ 45,000";
  final String pfAccountNumber = "AA/AAA/999999/99G/9899";
  final String uanNumber = "111111111111";

  String get month => "June 2025";

  void generateAndDownloadPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "ZiyaAcademy",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue,
                ),
              ),
              pw.Text(
                "KEY-TO SUCCESS",
                style: pw.TextStyle(fontSize: 12, color: PdfColors.green),
              ),
              pw.SizedBox(height: 16),
              pw.Text("Payslip for the Month", style: pw.TextStyle(fontSize: 12)),
              pw.Text(
                payPeriod,
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),

              // EMPLOYEE SUMMARY
              pw.Text("EMPLOYEE SUMMARY", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text("Employee Name: $name"),
              pw.Text("Designation: $designation"),
              pw.Text("Employee ID: $employeeId"),
              pw.Text("Date of Joining: $joiningDate"),
              pw.Text("Pay Period: $payPeriod"),
              pw.Text("Pay Date: $payDate"),
              pw.SizedBox(height: 8),
              pw.Text("PF A/C Number: $pfAccountNumber"),
              pw.Text("UAN: $uanNumber"),

              pw.SizedBox(height: 20),

              // Earnings & Deductions Table
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey),
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text("EARNINGS", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("AMOUNT")),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("YTD")),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text("DEDUCTIONS", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("AMOUNT")),
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("YTD")),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("Basic")),
                      pw.Text("₹ 25,000"),
                      pw.Text("₹ 3,00,000"),
                      pw.Text("PF Deduction"),
                      pw.Text("₹ 2,500"),
                      pw.Text("₹ 30,000"),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("HRA")),
                      pw.Text("₹ 10,000"),
                      pw.Text("₹ 1,20,000"),
                      pw.Text("Tax Deduction"),
                      pw.Text("₹ 7,500"),
                      pw.Text("₹ 90,000"),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("Travel Allowance")),
                      pw.Text("₹ 3,000"),
                      pw.Text("₹ 36,000"),
                      pw.Text(""),
                      pw.Text(""),
                      pw.Text(""),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(4), child: pw.Text("Meal / Other Allowance")),
                      pw.Text("₹ 2,000"),
                      pw.Text("₹ 24,000"),
                      pw.Text(""),
                      pw.Text(""),
                      pw.Text(""),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 12),

              // Summary
              pw.Container(
                color: PdfColors.blue50,
                padding: pw.EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Gross Earnings: ₹ 55,000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Total Deductions: ₹ 10,000", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),

              pw.Spacer(),

              pw.Center(
                child: pw.Text(
                  "- This document has been automatically generated by ZiyaAcademy -",
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
