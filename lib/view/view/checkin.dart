import 'package:flutter/material.dart';
import 'package:loginscreen/model/faceverification_model.dart';
import 'package:provider/provider.dart';
import 'package:loginscreen/viewmodel/checkinprovider.dart';
import 'package:loginscreen/view/view/centerfacepage.dart';
import 'package:loginscreen/view/view/facevarification.dart';
import 'package:loginscreen/view/view/punch_access.dart';
import 'package:loginscreen/view/view/qrverification.dart';

class Checkin extends StatelessWidget {
  const Checkin({super.key});

  void _startPunchInFlow(BuildContext context) async {
    final selectedMode = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Punch-In Type'),
            content: const Text('Are you working from home or on site today?'),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop('On Site'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 2,
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text('On Site'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop('Work From Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF008CFF),
                  foregroundColor: Colors.white,
                  elevation: 2,
                ),
                child: const Text('Work From Home'),
              ),
            ],
          ),
    );

    if (selectedMode == null) return;

    final provider = Provider.of<CheckinProvider>(context, listen: false);
    provider.setPunchInMode(selectedMode);

    if (selectedMode == 'On Site') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const QRVerificationPage(isPunchIn: true),
        ),
      );
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CenterYourFacePage(isPunchIn: true),
        ),
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (_) => FaceVerificationPage(
                model: FaceVerificationModel(isPunchIn: true),
                isPunchIn: true,
              ),
        ),
      );
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CenterYourFacePage(isPunchIn: true),
        ),
      );
    }

    provider.punchIn();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PunchSuccessPage(isPunchIn: true),
      ),
    );
  }

  void _startPunchOutFlow(BuildContext context) async {
    final shouldPunchOut = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirm Check Out'),
            content: const Text('Do you really want to check out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Update Task'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Check Out'),
              ),
            ],
          ),
    );

    if (shouldPunchOut != true) return;

    final provider = Provider.of<CheckinProvider>(context, listen: false);

    if (provider.punchInMode == 'On Site') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const QRVerificationPage(isPunchIn: false),
        ),
      );
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CenterYourFacePage(isPunchIn: false),
        ),
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (_) => FaceVerificationPage(
                model: FaceVerificationModel(isPunchIn: false),
                isPunchIn: false,
              ),
        ),
      );
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CenterYourFacePage(isPunchIn: false),
        ),
      );
    }

    provider.punchOut();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PunchSuccessPage(isPunchIn: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckinProvider>(
      builder: (context, checkinProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 240, 242),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE4EDED)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  checkinProvider.isPunchedIn
                      ? Text(
                        '“You are Punch‑In ${_formatTime(checkinProvider.punchInTime!)}”',
                        style: const TextStyle(
                          color: Color(0xFF0A9C44),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : const Text(
                        "You haven’t punched in yet",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  const SizedBox(height: 10),
                  if (checkinProvider.isPunchedIn) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 18,
                          color: Color(0xFFE67E00),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _formatDateTime(checkinProvider.punchInTime!),
                          style: const TextStyle(
                            color: Color(0xFFE67E00),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          checkinProvider.punchInLocation ?? 'Unknown Location',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              checkinProvider.isPunchedIn
                                  ? null
                                  : () => _startPunchInFlow(context),
                          icon: const Icon(Icons.login),
                          label: const Text('Punch In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                checkinProvider.isPunchedIn
                                    ? Colors.grey
                                    : const Color(0xFF008CFF),
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              checkinProvider.isPunchedIn
                                  ? () => _startPunchOutFlow(context)
                                  : null,
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Punch Out'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                checkinProvider.isPunchedIn
                                    ? const Color(0xFF008CFF)
                                    : Colors.grey,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  String _formatDateTime(DateTime time) {
    final day = time.day.toString().padLeft(2, '0');
    final month = time.month.toString().padLeft(2, '0');
    final year = time.year;
    return '${_formatTime(time)} - $day-$month-$year';
  }
}
