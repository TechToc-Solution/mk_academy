import 'package:flutter/widgets.dart';

import '../../../../../core/utils/assets_data.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsData.wihteLogoNoBg),
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
