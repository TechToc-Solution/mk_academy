import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';


class OffersSection extends StatelessWidget {
  const OffersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "offers".tr(context),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
        ),
        SizedBox(
          height: 8,
        ),
        GridView.builder(
            itemCount: 5,
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
            })
      ],
    );
  }
}