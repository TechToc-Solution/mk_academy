import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';
import 'package:mk_academy/features/home/presentation/views-model/ads/ads_cubit.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';

class AllAds extends StatefulWidget {
  static const String routeName = '/allAds';
  const AllAds({super.key});

  @override
  State<AllAds> createState() => _AllAdsState();
}

class _AllAdsState extends State<AllAds> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AdsCubit>().getAds(adsType: 0); // 0 = internal ads
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
                  title: "all_ads".tr(context),
                  backBtn: true,
                ),
                SizedBox(
                  height: kSizedBoxHeight,
                ),
                BlocBuilder<AdsCubit, AdsState>(builder: (context, state) {
                  if (state.status == AdsStatus.failure) {
                    return CustomErrorWidget(
                        errorMessage: state.errorMessage!,
                        onRetry: () =>
                            context.read<AdsCubit>().getAds(adsType: 0));
                  } else if (state.status == AdsStatus.success) {
                    return state.ads.isEmpty
                        ? Expanded(
                            child: Text("no_data".tr(context),
                                style: TextStyle(color: Colors.white)),
                          )
                        : Expanded(
                            child: AdsBtn(
                            ads: state.ads,
                          ));
                  } else {
                    return CustomCircualProgressIndicator();
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

class AdsBtn extends StatelessWidget {
  const AdsBtn({super.key, required this.ads});
  final List<Ads> ads;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
        child: GridView.builder(
            itemCount: ads.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              );
            }));
  }
}
