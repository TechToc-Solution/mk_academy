import 'package:flutter/material.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/category_item.dart';

class CustomCategoryList extends StatelessWidget {
  const CustomCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CategoryItem(),
          );
        });
  }
}
