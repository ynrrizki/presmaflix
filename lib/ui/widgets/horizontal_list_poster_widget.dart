import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/models/content.dart';

class HorizontalListPosterWidget extends StatelessWidget {
  const HorizontalListPosterWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.contents,
    this.maxHeight = 170,
  });

  final String title;
  final GestureTapCallback? onTap;
  final List<Content> contents;
  final double maxHeight;

  Future<List<Content>> loadContent() async {
    return contents;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 2),
        () => loadContent(),
      ),
      builder: (context, snapshot) {
        // log('${snapshot}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return skleton();
        } else if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: onTap,
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
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxHeight,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: contents.length,
                    itemBuilder: (context, index) => PosterWidget(
                      content: contents[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
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
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  width: double.infinity,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Shimmer skleton() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
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
