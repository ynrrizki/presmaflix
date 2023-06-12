import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/config/routing/argument/content/content_all_args.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/models/content/content.dart';

class HorizontalGridWidget extends StatelessWidget {
  const HorizontalGridWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.contents,
    this.maxHeight = 200,
    this.crossAxisCount = 1,
    this.childAspectRatio = 1.4,
    this.crossAxisSpacing = 0.0,
    this.mainAxisExtent,
    this.mainAxisSpacing = 10,
  });

  final String title;
  final GestureTapCallback? onTap;
  final List<Content> contents;
  final double maxHeight;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double? mainAxisExtent;
  final double mainAxisSpacing;

  Future<List<Content>> loadContent() async {
    return contents;
  }

  @override
  Widget build(BuildContext context) {
    if (contents.isEmpty) {
      return const SizedBox();
    } else {
      // change to future builder with delayed
      return FutureBuilder<List<Content>>(
        future: Future.delayed(
          const Duration(milliseconds: 650),
          () => loadContent(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            return _buildContent(context, snapshot.data!);
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const SizedBox();
          } else {
            return _buildShimmer();
          }
        },
      );
    }
  }

  Column _buildContent(BuildContext context, contents) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onTap ??
                    () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        '/content-all',
                        arguments: ContentAllArguments(
                          title: title,
                          contents: contents,
                        ),
                      );
                    },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisExtent: mainAxisExtent,
              mainAxisSpacing: mainAxisSpacing,
            ),
            itemCount: contents.length,
            itemBuilder: (context, index) {
              double left = 0, right = 0;
              if (index == 0) {
                left = 16;
              } else if (index == contents.length - 1) {
                right = 16;
              }
              log('${contents.length}');
              return PosterWidget(
                content: contents[index],
                margin: EdgeInsets.only(left: left, right: right),
              );
            },
          ),
        ),
      ],
    );
  }

  Shimmer _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(123, 121, 121, 121),
      highlightColor: const Color.fromARGB(255, 128, 128, 128),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(
              maxHeight: 100,
            ),
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Container viewAll() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      width: 120,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
