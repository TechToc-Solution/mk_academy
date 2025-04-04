import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/features/work_papers/presentation/views/work_papers_section.dart';

class WorkPapersPage extends StatefulWidget {
  const WorkPapersPage({super.key});
  static const String routeName = '/workPapers';

  @override
  State<WorkPapersPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WorkPapersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "work_papers".tr(context),
              backBtn: true,
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: ListView(
                children: [
                  WorkPapersSection(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
