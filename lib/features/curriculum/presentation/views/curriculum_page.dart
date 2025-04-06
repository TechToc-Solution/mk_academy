import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/custom_top_nav_bar.dart';

import 'widgets/curriculum_page_body.dart';

class CurriculumPage extends StatefulWidget {
  const CurriculumPage({super.key});
  static const String routeName = "curriculum";

  @override
  State<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  TabController? _subTabController;
  bool _isInitialized = false;
  int selectedMainIndex = 0;
  List<SubjectsData> mainSubjects = [];

  @override
  void dispose() {
    _mainTabController.dispose();
    _subTabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<SubjectsCubit, SubjectsState>(
        listener: (BuildContext context, SubjectsState state) {
          if (state is SubjectsInitial) {
            context.read<SubjectsCubit>().getSubjects();
          }
        },
        builder: (context, state) {
          if (state is GetSubjectsSucess) {
            mainSubjects = state.subjectsData;

            if (!_isInitialized) {
              final firstSubSubjects =
                  mainSubjects[selectedMainIndex].subjects ?? [];
              _mainTabController =
                  TabController(length: mainSubjects.length, vsync: this);
              _subTabController =
                  TabController(length: firstSubSubjects.length, vsync: this);

              _mainTabController.addListener(() {
                setState(() {
                  selectedMainIndex = _mainTabController.index;
                  _subTabController?.dispose();
                  final newSubSubjects =
                      mainSubjects[selectedMainIndex].subjects ?? [];
                  _subTabController =
                      TabController(length: newSubSubjects.length, vsync: this);
                });
              });

              _isInitialized = true;
            }

            return Column(
              children: [
                CustomTopNavBar(
                  tabController: _mainTabController,
                  subjects: [
                    for (var subjectData in mainSubjects)
                      Subjects(id: subjectData.id, name: subjectData.name)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CurriculumPageBody(
                        subjects: mainSubjects[selectedMainIndex].subjects!,
                        tabController: _subTabController!),
                  ),
                ),
              ],
            );
          }
          if (state is GetSubjectsError) {
            return CustomErrorWidget(
                errorMessage: state.erroMsg,
                onRetry: () {
                  context.read<SubjectsCubit>().getSubjects();
                });
          }
          return CustomCircualProgressIndicator();
        },
      ),
    ));
  }
}
