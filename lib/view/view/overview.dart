import 'package:flutter/material.dart';

class OverviewRow extends StatelessWidget {
  const OverviewRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _OverviewCard(
            label: 'Presence',
            value: '20',
            colour: Color(0xFF0A9C44),
          ),
          _OverviewCard(
            label: 'Absence',
            value: '03',
            colour: Color(0xFFCC2029),
          ),
          _OverviewCard(
            label: 'Leaves',
            value: '02',
            colour: Color(0xFFE67E00),
          ),
        ],
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String label;
  final String value;
  final Color colour;

  const _OverviewCard({
    super.key,
    required this.label,
    required this.value,
    required this.colour,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: colour,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
