import 'package:flutter/material.dart';

import '../../../../../../core/utils/colors.dart';

class CustomCircularIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool showProgress;

  const CustomCircularIcon({
    super.key,
    required this.icon,
    this.onTap,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColors,
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
          ),
          if (showProgress)
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
        ],
      ),
    );
  }
}
