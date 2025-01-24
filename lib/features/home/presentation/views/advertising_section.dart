import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mk_academy/features/home/presentation/views/widgets/custom_advertising_item.dart';

class CustomAdvertiseList extends StatelessWidget {
  const CustomAdvertiseList({
    super.key,
    required this.advertises,
  });

  final List<CustomAdvertiseItem> advertises;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: advertises,
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
