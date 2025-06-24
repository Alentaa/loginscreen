import 'package:flutter/material.dart';

class PunchSuccessPage extends StatelessWidget {
  final bool isPunchIn;

  const PunchSuccessPage({super.key, required this.isPunchIn});

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
                isPunchIn
                    ? [Colors.white, const Color(0xFFD7F9E6)] 
                    : [
                      Colors.white,
                      const Color(0xFFFFE5B4),
                    ], 
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: isPunchIn ? Colors.green : Colors.orange,
              ),
              const SizedBox(height: 24),
              Text(
                isPunchIn
                    ? "Punched In Successfully"
                    : "Punched Out Successfully",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Time: ${now.format(context)}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text("Location/IP: for remote attendance"),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPunchIn ? Colors.green : Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                child: const Text("Go to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
