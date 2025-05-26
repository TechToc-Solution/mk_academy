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
import 'package:mk_academy/features/courses/presentation/view_model/courses%20cubit/courses_cubit.dart';
import 'widgets/courses_page_body.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key, required this.courseTypeId});
  static const String routeName = '/units';
  final int courseTypeId;
  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage>
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
          listener: (context, state) {
            if (state is SubjectsInitial) {
              context.read<SubjectsCubit>().getSubjects();
            }
          },
          builder: (context, state) {
            if (state is GetSubjectsError) {
              return CustomErrorWidget(
                  errorMessage: state.erroMsg,
                  onRetry: () => context.read<SubjectsCubit>().getSubjects());
            } else if (state is GetSubjectsSuccess) {
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
                    context.read<CoursesCubit>().resetPagination();

                    final newSubSubjects =
                        mainSubjects[selectedMainIndex].subjects ?? [];
                    _subTabController?.dispose();
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
                  if (!isGuest)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomLevelBar(
                        compact: true,
                        showProfile: false,
                      ),
                    ),
                  CustomTopNavBar(
                    isPrimary: true,
                    tabController: _mainTabController,
                    subjects: [
                      for (var subjectData in mainSubjects)
                        Subjects(id: subjectData.id, name: subjectData.name)
                    ],
                  ),
                  if (mainSubjects[selectedMainIndex].subjects!.isNotEmpty)
                    Flexible(
                      child: CoursesPageBody(
                        key: ValueKey(selectedMainIndex),
                        courseTypeId: widget.courseTypeId,
                        subjects: mainSubjects[selectedMainIndex].subjects!,
                        tabController: _subTabController!,
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
            return CustomCircualProgressIndicator();
          },
        ),
      ),
    );
  }
}
