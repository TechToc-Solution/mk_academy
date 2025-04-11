import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
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
    if (!mounted) {
      _mainTabController.dispose();
      _subTabController?.dispose();
    }

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
          if (state is GetSubjectsSuccess) {
            mainSubjects = state.subjectsData;

            if (!_isInitialized) {
              final firstSubSubjects =
                  mainSubjects[selectedMainIndex].subjects ?? [];
              _mainTabController =
                  TabController(length: mainSubjects.length, vsync: this);
              _subTabController =
                  TabController(length: firstSubSubjects.length, vsync: this);

              _mainTabController.addListener(() {
                if (_mainTabController.indexIsChanging) return;

                setState(() {
                  selectedMainIndex = _mainTabController.index;

                  final newSubSubjects =
                      mainSubjects[selectedMainIndex].subjects ?? [];
                  if (!mounted) _subTabController?.dispose();
                  _subTabController = TabController(
                    length: newSubSubjects.length,
                    vsync: this,
                  );
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
                if (!isGuest)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomLevelBar(
                      compact: true,
                      showProfile: false,
                    ),
                  ),
                if (mainSubjects[selectedMainIndex].subjects!.isNotEmpty)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CurriculumPageBody(
                          key: ValueKey(selectedMainIndex),
                          subjects: mainSubjects[selectedMainIndex].subjects!,
                          tabController: _subTabController!),
                    ),
                  ),
                if (mainSubjects[selectedMainIndex].subjects!.isEmpty)
                  Expanded(
                    child: Center(
                        child: Text(
                      "no_data".tr(context),
                      style: TextStyle(color: Colors.white),
                    )),
                  )
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
