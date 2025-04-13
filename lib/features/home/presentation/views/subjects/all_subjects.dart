import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/show_subject.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';

class AllSubjects extends StatefulWidget {
  static const String routeName = '/allSubjects';
  const AllSubjects({super.key});

  @override
  State<AllSubjects> createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectsCubit>().getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundImage(),
            Column(
              children: [
                CustomAppBar(
                  title: "all_subjects".tr(context),
                  backBtn: true,
                ),
                SizedBox(
                  height: kSizedBoxHeight,
                ),
                BlocBuilder<SubjectsCubit, SubjectsState>(
                    builder: (context, state) {
                  if (state is GetSubjectsError) {
                    return CustomErrorWidget(
                        errorMessage: state.erroMsg,
                        onRetry: () =>
                            context.read<SubjectsCubit>().getSubjects());
                  } else if (state is GetSubjectsSuccess) {
                    return state.subjectsData.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Text("no_data".tr(context),
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )
                        : Expanded(
                            child: SubjectBtn(
                            subjects: state.subjectsData,
                          ));
                  } else {
                    return Expanded(
                        child: Center(
                            child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ShimmerContainer(
                        circularRadius: 8,
                      ),
                    )));
                  }
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectBtn extends StatelessWidget {
  const SubjectBtn({super.key, required this.subjects});
  final List<SubjectsData> subjects;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
        child: GridView.builder(
            itemCount: subjects.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemBuilder: (BuildContext context, int index) {
              final subject = subjects[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  ShowSubSubjects.routeName,
                  arguments: {'subject': subject},
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // خلفية الصورة
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          subject.image ??
                              '', // تأكد أن `subject.image` هي الرابط الصحيح
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      // تغطية خفيفة على الصورة لتحسين وضوح النص
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      // النص
                      Center(
                        child: Text(
                          subject.name ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.textStyle25.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: const [
                              Shadow(color: Colors.black, blurRadius: 20),
                              Shadow(
                                  color: AppColors.primaryColors, blurRadius: 5)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
