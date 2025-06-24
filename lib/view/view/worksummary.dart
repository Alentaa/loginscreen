import 'package:flutter/material.dart';
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
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 12,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 241, 248, 249),
              borderRadius: BorderRadius.circular(1),
            ),
            child: Icon(item.icon, size: 29, color: const Color(0xFF00BFA5)),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black87)),
                const SizedBox(height: 3),
                Text(
                  item.value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
