import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/config/routing/argument/content/detail_args.dart';
import 'package:shimmer/shimmer.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({
    super.key,
    required this.content,
    this.width,
    this.height,
    this.isRedirect = true,
  });

  final Content content;
  final double? width;
  final double? height;
  final bool isRedirect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
              ? Ink(
                  decoration: boxDecoration,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        '/detail',
                        arguments: DetailArguments(content: content),
                      );
                    },
                    child: const SizedBox(
                      width: 120,
                    ),
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
