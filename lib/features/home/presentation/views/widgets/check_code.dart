import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mk_academy/core/shared/cubits/pay/pay_cubit.dart';
import 'package:mk_academy/core/shared/cubits/pay/pay_state.dart';
import 'package:mk_academy/core/shared/repos/pay/pay_repo.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';

class CheckCodePage extends StatelessWidget {
  static const String routeName = "/checkCode";
  const CheckCodePage({super.key, required this.code});
  final String code;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayCubit(getit.get<PayRepo>())..checkCode(code),
      child: Scaffold(
        floatingActionButton: BlocConsumer<PayCubit, PayState>(
          listener: (context, state) {
            if (state is PaySuccess) {
              Navigator.pop(context);
              Navigator.pop(context);
              messages(context, 'payment_success'.tr(context), Colors.green);
            }
            if (state is PayError) {
              Navigator.pop(context);
              Navigator.pop(context);
              messages(context, state.message, Colors.red);
            }
          },
          builder: (context, state) {
            return FloatingActionButton(
                child: state is PayLoading
                    ? CustomCircualProgressIndicator()
                    : Text("confirm".tr(context)),
                onPressed: () {
                  context.read<PayCubit>().payCourse(
                        code,
                      );
                });
          },
        ),
        appBar: PreferredSize(
            preferredSize: MediaQuery.sizeOf(context),
            child: SafeArea(
              child:
                  CustomAppBar(title: "code_check".tr(context), backBtn: true),
            )),
        body: BlocBuilder<PayCubit, PayState>(builder: (context, state) {
          if (state is CheckSuccess) {
            return ListView.builder(
              itemCount: state.courses.length,
              itemBuilder: (BuildContext context, int index) {
                return CourseCardDetails(
                  course: state.courses[index],
                );
              },
            );
          } else if (state is CheckError) {
            return CustomErrorWidget(
                errorMessage: state.message,
                onRetry: () => context.read<PayCubit>().checkCode(code));
          } else {
            return CustomCircualProgressIndicator();
          }
        }),
      ),
    );
  }
}

class CourseCardDetails extends StatelessWidget {
  const CourseCardDetails({
    super.key,
    required this.course,
  });
  final Courses course;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (course.image != null)
              Image.network(
                course.image!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Html(
                    data: course.description ?? "",
                    style: {
                      "body": Style(
                          textOverflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          fontSize: FontSize(16.0),
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero),
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${course.price ?? 0} ${"sp".tr(context)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      Chip(
                        label: Text(
                          course.courseMode?.toUpperCase() ?? '',
                          style: const TextStyle(
                              color: AppColors.textButtonColors),
                        ),
                        backgroundColor: AppColors.primaryColors,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
