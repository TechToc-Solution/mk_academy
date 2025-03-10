import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final Color? backgroundColor;
  final Color? textColor;
  final String? retryButtonText;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.backgroundColor,
    this.textColor,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 50,
              color: textColor ?? colorScheme.onErrorContainer,
            ),
            const SizedBox(height: kSizedBoxHeight),
            Text(
              errorMessage,
              style: Styles.textStyle18
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kSizedBoxHeight),
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onErrorContainer,
                foregroundColor: colorScheme.errorContainer,
                padding: const EdgeInsets.symmetric(
                    horizontal: KHorizontalPadding, vertical: KVerticalPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(retryButtonText ?? 'try_agen'.tr(context),
                  style: Styles.textStyle16.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
