import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:shimmer/shimmer.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 0, top: 20),
      child: SizedBox(
        width: 120,
        child: CachedNetworkImage(
          imageUrl: content.posterUrl,
          imageBuilder: (context, imageProvider) {
            return Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: imageProvider,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                ),
              ),
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  width: 120,
                ),
              ),
            );
          },
          placeholder: (context, url) => Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
