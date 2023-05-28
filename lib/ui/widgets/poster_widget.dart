import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/config/routing/argument/content/content_detail_args.dart';
import 'package:shimmer/shimmer.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({
    super.key,
    required this.content,
    this.width,
    this.height,
    this.isRedirect = true,
    this.margin,
  });

  final Content content;
  final double? width;
  final double? height;
  final bool isRedirect;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: content.posterUrl,
        imageBuilder: (context, imageProvider) {
          Decoration boxDecoration = BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: imageProvider,
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.cover,
            ),
          );

          return isRedirect
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      '/content-detail',
                      arguments: ContentDetailArguments(content: content),
                    );
                  },
                  child: Container(
                    decoration: boxDecoration,
                  ),
                )
              : Container(
                  decoration: boxDecoration,
                );
        },
        placeholder: (context, progress) {
          return Shimmer.fromColors(
            baseColor: const Color.fromARGB(123, 121, 121, 121),
            highlightColor: const Color.fromARGB(255, 128, 128, 128),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
