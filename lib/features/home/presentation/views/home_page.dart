import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_level_bar.dart';
import 'package:mk_academy/features/home/presentation/views/advertising_section.dart';
import 'package:mk_academy/features/home/presentation/views/category_section.dart';
import 'package:mk_academy/features/home/presentation/views/drawer.dart';
import 'package:mk_academy/features/home/presentation/views/offers_section.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_advertising_item.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_top_3.dart';
import 'package:mk_academy/features/leaderboard/presentation/views-model/leaderboard_cubit.dart';

import '../../../../core/widgets/custom_error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: kVerticalPadding),
          child: SliderDrawer(
            isDraggable: false,
            slideDirection: SlideDirection.rightToLeft,
            key: _sliderDrawerKey,
            backgroundColor: AppColors.backgroundColor,
            slider: CustomDrawer(),
            appBar: SizedBox(),
            child: Column(
              children: [
                CustomSearchBar(drawerKey: _sliderDrawerKey),
                SizedBox(
                  height: 8,
                ),
                CustomLevelBar(),
                Expanded(
                    child: ListView(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    CustomAdvertiseList(advertises: [
                      BlocBuilder<LeaderboardCubit, LeaderboardState>(
                        builder: (context, state) {
                          if (state is LeaderboardSuccess) {
                            return CustomTopThreeItem(students: state.students);
                          } else if (state is LeaderboardError) {
                            return CustomErrorWidget(
                              errorMessage: state.errorMsg,
                              onRetry: () {
                                context
                                    .read<LeaderboardCubit>()
                                    .getLeaderbord();
                              },
                            );
                          }
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.backgroundColor,
                                    Colors.white
                                  ],
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        },
                      ),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                      CustomAdvertiseItem(),
                    ]),
                    SizedBox(
                      height: 8,
                    ),
                    CategorySection(),
                    OffersSection(),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
