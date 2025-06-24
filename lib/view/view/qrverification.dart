import 'package:flutter/material.dart';
import 'package:loginscreen/viewmodel/checkinprovider.dart';
import 'package:loginscreen/view/view/centerfacepage.dart';
import 'package:provider/provider.dart';

class QRVerificationPage extends StatefulWidget {
  final bool isPunchIn;
  const QRVerificationPage({super.key, required this.isPunchIn});

  @override
  State<QRVerificationPage> createState() => _QRVerificationPageState();
}

class _QRVerificationPageState extends State<QRVerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onQRScanSuccess(BuildContext context) {
    if (widget.isPunchIn) {
      Provider.of<CheckinProvider>(context, listen: false).punchIn();
    } else {
      Provider.of<CheckinProvider>(context, listen: false).punchOut();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => CenterYourFacePage(isPunchIn: widget.isPunchIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'QR Verification',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please capture your QR Code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code_scanner,
                      size: 60, color: Color(0xFF008CFF)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: () => _onQRScanSuccess(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF008CFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Take Photo",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
