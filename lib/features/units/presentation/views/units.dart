import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/units/presentation/views/units_section.dart';
import 'package:mk_academy/features/units/presentation/views/widgets/custom_top_nav_bar.dart';

import '../../../courses/presentation/view_model/cubit/courses_cubit.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({super.key, required this.courseMode});
  static const String routeName = '/units';
  final String courseMode;
  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<CoursesCubit>().resetPagination();
    context.read<CoursesCubit>().getCourses(
          courseMode: widget.courseMode,
          subjectId: 1,
        );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: Column(
            children: [
              CustomTopNavBar(
                tabController: _tabController,
              ),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              customLevelBar(),
              SizedBox(
                height: kSizedBoxHeight,
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  UnitsSection(),
                  UnitsSection(),
                  UnitsSection(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
