import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/app/models/video.dart';
import 'package:shimmer/shimmer.dart';

class CardVideoWidget extends StatelessWidget {
  const CardVideoWidget({
    super.key,
    required this.video,
    this.padding = const EdgeInsets.all(8.0),
  });
  final Video video;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 65,
                width: 110,
                child: CachedNetworkImage(
                  imageUrl: video.thumbnailUrl!,
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

                    return Container(
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
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 100,
                    child: Text(
                      video.title ?? 'Title',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 33),
                  Text(
                    video.duration,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              // const SizedBox(width: 25),
              const Expanded(
                child: SizedBox(),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.download,
                  size: 25,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 20),
          // make view more text
          const Text(
            maxLines: 3,
            textWidthBasis: TextWidthBasis.longestLine,
            overflow: TextOverflow.ellipsis,
            'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Libero recusandae quis consequuntur perferendis. Blanditiis aliquid molestiae commodi dignissimos optio fugiat illo ut, provident inventore alias omnis excepturi cumque ducimus reprehenderit.',
          ),
        ],
      ),
    );
  }
}
