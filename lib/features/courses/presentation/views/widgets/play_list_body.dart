import 'package:flutter/material.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/show_video/presentation/views/show_video.dart';

class PlayListBody extends StatelessWidget {
  const PlayListBody({super.key, required this.videos});
  final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primaryColors)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(goRoute(
                        x: WebViewScreen(
                      video: videos[index],
                    )));
                  },
                  icon: Icon(Icons.play_arrow)),
              Spacer(),
              Text(
                videos[index].name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
              SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(videos[index].thumbnail!),
                onBackgroundImageError: (exception, stackTrace) =>
                    AssetImage(AssetsData.logo),
              ),
            ],
          ),
        );
      },
    );
  }
}
