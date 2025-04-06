import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';

import 'package:mk_academy/features/courses/presentation/view_model/videos_cubit/videos_cubit.dart';
import 'package:mk_academy/features/courses/presentation/views/widgets/play_list_body.dart';

class ShowPlayList extends StatelessWidget {
  const ShowPlayList({super.key, required this.courseId});
  final int courseId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "play_list".tr(context),
              backBtn: true,
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: BlocBuilder<VideosCubit, VideosState>(
                builder: (context, state) {
                  if (state.status == VideoStatus.success) {
                    return PlayListBody(
                      videos: state.videos!,
                    );
                  } else if (state.status == VideoStatus.failure) {
                    return CustomErrorWidget(
                        errorMessage: state.errorMessage!,
                        onRetry: () => context
                            .read<VideosCubit>()
                            .getVideos(courseId: courseId));
                  } else {
                    return CustomCircualProgressIndicator();
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
