import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WidgetImage extends StatelessWidget {
  final String imgurl;
  final double height;
  final double width;

  const WidgetImage(
      {super.key,
      required this.imgurl,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      placeholder: (context, url) => LoadingAnimationWidget.hexagonDots(color: Colors.grey, size: 20),
      errorWidget: (context, url, error) => Icon(Icons.error), imageUrl:imgurl ??"",
    );
  }
}
