import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

void _generateAndDownloadPDF() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("ZiyaAcademy Payslip", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Text("Employee Name: Alenta"),
          pw.Text("Designation: Full-stack Developer"),
          pw.Text("Pay Period: June 2025"),
          pw.Text("Net Pay: ₹ 45,000"),
          pw.SizedBox(height: 16),
          pw.Text("Earnings & Deductions Summary:"),
          pw.Text(" - Basic: ₹ 25,000"),
          pw.Text(" - HRA: ₹ 10,000"),
          pw.Text(" - Travel Allowance: ₹ 3,000"),
          pw.Text(" - Meal / Other Allowance: ₹ 2,000"),
          pw.Text(" - PF Deduction: ₹ 2,500"),
          pw.Text(" - Tax Deduction: ₹ 7,500"),
          pw.SizedBox(height: 16),
          pw.Text("Gross Earnings: ₹ 55,000"),
          pw.Text("Total Deductions: ₹ 10,000"),
          pw.Text("Net Pay: ₹ 45,000"),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
