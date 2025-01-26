import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/colors.dart';

class CustomAdvertiseItem extends StatelessWidget {
  const CustomAdvertiseItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "عنوان تجريبي",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        " نص تجريبي نص تجريبي نص تجريبي نص تجريبي نص تجريبي نص تجريبي نص تجريبي",
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.backgroundColor),
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.backgroundColor,
                      ),
                    ),
                    title: Text("عنوان تجريبي"),
                    subtitle: Text(
                        overflow: TextOverflow.ellipsis,
                        " نص تجريبي نص تجريبي نص تجريبي نص تجريبي نص تجريبي نص تجريبي نص تجريبي"),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColors),
                    onPressed: () {},
                    child: Text(
                      "explore".tr(context),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
