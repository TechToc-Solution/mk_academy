import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';

class customLevelBar extends StatelessWidget {
  const customLevelBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccess)
          return Row(
            children: [
              Text(
                "current_level".tr(context) + ": ",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                "${state.userModel.level} ",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: LinearProgressIndicator(
                value: state.userModel.points! / state.userModel.maxPoints!,
                backgroundColor: AppColors.avatarColor,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColors),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
              )),
              Text(
                "level${int.parse(state.userModel.level![5]) + 1} ",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          );
        else if (state is ProfileError)
          return ErrorWidget(state.errorMsg);
        else
          return LinearProgressIndicator();
      },
    );
  }
}
