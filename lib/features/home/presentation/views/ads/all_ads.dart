import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_app_bar.dart';
import 'package:mk_academy/core/widgets/custom_error_widget.dart';
import 'package:mk_academy/core/widgets/shimmer_container.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';
import 'package:mk_academy/features/home/presentation/views-model/ads/ads_cubit.dart';
import 'package:mk_academy/features/test_your_self/presentation/views/widgets/back_ground_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class AllAds extends StatefulWidget {
  static const String routeName = '/allAds';
  const AllAds({super.key});

  @override
  State<AllAds> createState() => _AllAdsState();
}

class _AllAdsState extends State<AllAds> {
  int currentTab = 0; // 0 = internal, 1 = external
  @override
  void initState() {
    super.initState();
    context.read<AdsCubit>().resetPagination();
    context.read<AdsCubit>().getAllAds();
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: kSizedBoxHeight / 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: currentTab == 0
                                ? AppColors.primaryColors
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: currentTab == 0
                                  ? AppColors.primaryColors
                                  : Colors.grey.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => setState(() => currentTab = 0),
                            child: Text(
                              "internal_ads".tr(context),
                              style: TextStyle(
                                color: currentTab == 0
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: currentTab == 1
                                ? AppColors.primaryColors
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: currentTab == 1
                                  ? AppColors.primaryColors
                                  : Colors.grey.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => setState(() => currentTab = 1),
                            child: Text(
                              "external_ads".tr(context),
                              style: TextStyle(
                                color: currentTab == 1
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AdsCubit, AdsState>(builder: (context, state) {
                  if (state.status == AdsStatus.failure) {
                    return CustomErrorWidget(
                        errorMessage: state.errorMessage!,
                        onRetry: () => context.read<AdsCubit>().getAllAds());
                  } else if (state.status == AdsStatus.success) {
                    final currentAds =
                        currentTab == 0 ? state.adsInt : state.adsExt;
                    return currentAds.isEmpty
                        ? Expanded(
                            child: Text("no_data".tr(context),
                                style: TextStyle(color: Colors.white)),
                          )
                        : Expanded(
                            child: AdsBtn(
                            ext: currentTab == 1 ? true : false,
                            ads: currentAds,
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

class AdsBtn extends StatefulWidget {
  const AdsBtn({super.key, required this.ads, required this.ext});
  final List<Ads> ads;
  final bool ext;

  @override
  State<AdsBtn> createState() => _AdsBtnState();
}

class _AdsBtnState extends State<AdsBtn> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: kSizedBoxHeight),
        child: GridView.builder(
            itemCount: widget.ads.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.ext ? 1 : 2,
                childAspectRatio: widget.ext ? 16 / 9 : 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.ads[index].image ?? '',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, error, stackTrace) => Image.asset(
                      AssetsData.defaultImage3,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            }));
  }
}
