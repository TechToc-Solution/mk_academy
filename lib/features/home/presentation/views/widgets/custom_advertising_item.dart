import 'package:flutter/material.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dumy Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              "Dumy description Dumy description Dumy description Dumy description Dumy description Dumy description",
              style: TextStyle(),
            ),
            SizedBox(
              height: 32,
            ),
            ListTile(
              leading: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.backgroundColor,
                ),
              ),
              title: Text("Dumy Title"),
              subtitle: Text("Dump Suptitle Dump Suptitle Dump Suptitle"),
            ),
          ],
        ),
      ),
    );
  }
}
