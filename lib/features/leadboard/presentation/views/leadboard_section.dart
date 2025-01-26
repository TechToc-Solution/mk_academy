import 'package:flutter/material.dart';
import 'package:mk_academy/features/leadboard/presentation/views/widgets/custom_leadboard_show.dart';

class LeadboardSection extends StatelessWidget {
  const LeadboardSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List tempData = [
      {"name": "اسم تجريبي", "level": "30", "image": ""},
      {"name": "اسم تجريبي", "level": "28", "image": ""},
      {"name": "اسم تجريبي", "level": "27", "image": ""},
      {"name": "اسم تجريبي", "level": "27", "image": ""},
      {"name": "اسم تجريبي", "level": "25", "image": ""},
      {"name": "اسم تجريبي", "level": "23", "image": ""},
      {"name": "اسم تجريبي", "level": "22", "image": ""},
      {"name": "اسم تجريبي", "level": "22", "image": ""},
      {"name": "اسم تجريبي", "level": "21", "image": ""},
      {"name": "اسم تجريبي", "level": "19", "image": ""},
      {"name": "اسم تجريبي", "level": "17", "image": ""},
      {"name": "اسم تجريبي", "level": "5", "image": ""},
      {"name": "اسم تجريبي", "level": "3", "image": ""},
    ];
    return ListView.builder(
        itemCount: tempData.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CustomLeadboardShow(
              index: index,
              data: tempData[index],
              is_you: index == 5 ? true : false);
        });
  }
}
