import 'package:flutter/material.dart';

import '../../../../../core/utils/colors.dart';

class CustomCircularIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool showProgress;
  final bool downloaded;
  final double progress;

  const CustomCircularIcon({
    super.key,
    required this.icon,
    this.onTap,
    this.showProgress = false,
    this.downloaded = false,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showProgress)
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Text(
                '${(progress * 100).toInt()}%',
                key: ValueKey(progress),
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          SizedBox(
            width: 8,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: downloaded ? Colors.green : AppColors.primaryColors),
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              if (showProgress)
                TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: progress,
                    ),
                    duration: Duration(milliseconds: 300),
                    builder: (context, value, _) {
                      return SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: value,
                          strokeWidth: 3,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.secColors),
                        ),
                      );
                    }),
            ],
          ),
        ],
      ),
    );
  }
}
