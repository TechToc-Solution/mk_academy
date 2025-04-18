import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/features/home/presentation/views/ads/all_ads.dart';

import '../../../data/model/ads_model.dart';

class OffersSection extends StatefulWidget {
  final List<Ads> ads;
  const OffersSection({
    super.key,
    required this.ads,
  });

  @override
  State<OffersSection> createState() => _OffersSectionState();
}

class _OffersSectionState extends State<OffersSection> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "offers".tr(context),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AllAds.routeName),
              child: Text(
                "more".tr(context),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColors,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        GridView.builder(
            itemCount: widget.ads.length,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage(
                    image: NetworkImage(widget.ads[index].image!),
                    placeholder: AssetImage(AssetsData.defaultImage3),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(AssetsData.defaultImage3,
                          fit: BoxFit.fill);
                    },
                    fit: BoxFit.fill,
                  ),
                ),
              );
            })
      ],
    );
  }
}
