import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/home/presentation/views/subjects/show_subject.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/category_item.dart';

class CustomCategoryList extends StatelessWidget {
  const CustomCategoryList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsCubit, SubjectsState>(
      builder: (context, state) {
        if (state is GetSubjectsError) {
          return CustomErrorWidget(
              errorMessage: state.erroMsg,
              onRetry: () => context.read<SubjectsCubit>().getSubjects());
        } else if (state is GetSubjectsSucess) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.subjectsData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, ShowSubSubjects.routeName,
                        arguments: {'subject': state.subjectsData[index]}),
                    child: CategoryItem(
                      subject: state.subjectsData[index],
                    ),
                  ),
                );
              });
        } else {
          return CustomCircualProgressIndicator();
        }
      },
    );
  }
}
