import 'package:flutter/material.dart';
import 'package:loginscreen/constants/app_colors.dart';
import 'package:loginscreen/model/worksummarymodel.dart';
import 'package:loginscreen/viewmodel/worksummaryvm.dart';
import 'package:provider/provider.dart';

class WorkSummaryTab extends StatelessWidget {
  const WorkSummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkSummaryViewModel(),
      child: Consumer<WorkSummaryViewModel>(
        builder: (context, viewModel, _) {
          final items = viewModel.summaryItems;
          return SingleChildScrollView(
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 600;
                    return GridView.count(
                      crossAxisCount: isWide ? 3 : 2,
                      childAspectRatio: 1.3, // ✅ Controls width/height
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 7,
                      children: items
                          .map((item) => SummaryCard(item: item))
                          .toList(),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final WorkSummaryModel item;

  const SummaryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Takes full available width
      height: 150, // ✅ Custom height (adjust as needed)
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 247, 246, 246)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, size: 24, color: AppColors.blue),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
