import 'package:flutter/material.dart';
import 'package:mk_academy/features/work%20papers/presentation/views/widgets/work_paper_item.dart';

class WorkPapersSection extends StatelessWidget {
  const WorkPapersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return WorkPaperItem();
      },
    );
  }
}
