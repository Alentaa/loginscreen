import 'package:flutter/material.dart';

class SortFilterBar extends StatelessWidget {
  final int selectedSortIndex;
  final Function(int) onSortSelected;

  const SortFilterBar({
    super.key,
    required this.selectedSortIndex,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      child: Row(
        children: [
          const Text(
            "Sort by:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 12),
          _buildRadioOption("Deadline", 0),
          const SizedBox(width: 12),
          _buildRadioOption("Project", 1),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tune, color: Colors.black87, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, int index) {
    return GestureDetector(
      onTap: () => onSortSelected(index),
      child: Row(
        children: [
          Radio<int>(
            value: index,
            groupValue: selectedSortIndex,
            onChanged: (val) => onSortSelected(index),
            activeColor: Colors.blue,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
