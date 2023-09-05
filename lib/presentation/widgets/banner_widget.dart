import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/presentation/routes/argument/content/content_detail_args.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key, required this.contents}) : super(key: key);
  final List<dynamic> contents;
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _indexCarousel = 0;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _web();
    }
    return _mobile();
  }

  Widget _web() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1110,
          maxHeight: 1110,
          // maxHeight: 416,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            widget.contents.isNotEmpty
                ? CarouselSlider(
                    items: widget.contents
                        .map(
                          (content) => HeroCarouselCard(
                            content: content,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      viewportFraction: 1,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 300),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _indexCarousel = index;
                        });
                      },
                    ),
                  )
                : CarouselSlider(
                    items: [
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(123, 121, 121, 121),
                        highlightColor:
                            const Color.fromARGB(255, 128, 128, 128),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 1,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(150, 158, 158, 158),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_indexCarousel + 1}',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                  Text(
                    ' / ',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color.fromARGB(157, 255, 255, 255),
                    ),
                  ),
                  Text(
                    '${widget.contents.length}',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color.fromARGB(157, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobile() {
    return SizedBox(
      // color: Colors.red,
      width: double.infinity,
      height: 350,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          if (widget.contents.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: widget.contents
                        .map(
                          (content) => HeroCarouselCard(
                            content: content,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      initialPage: 0,
                      viewportFraction: 1,
                      aspectRatio: 1,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 300),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _indexCarousel = index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CarouselSlider(
                    items: [
                      Shimmer.fromColors(
                        baseColor: const Color.fromARGB(123, 121, 121, 121),
                        highlightColor:
                            const Color.fromARGB(255, 128, 128, 128),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      viewportFraction: 1,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(150, 158, 158, 158),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${_indexCarousel + 1}',
                  style: GoogleFonts.plusJakartaSans(),
                ),
                Text(
                  ' / ',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color.fromARGB(157, 255, 255, 255),
                  ),
                ),
                Text(
                  '${widget.contents.length}',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color.fromARGB(157, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroCarouselCard extends StatelessWidget {
  const HeroCarouselCard({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          '/content-detail',
          arguments: ContentDetailArguments(content: content),
        );
      },
      child: CachedNetworkImage(
        imageUrl: content.thumbnailUrl,
        fit: BoxFit.contain,
        width: double.infinity,
        alignment: Alignment.center,
        progressIndicatorBuilder: (context, url, progress) =>
            Shimmer.fromColors(
          baseColor: const Color.fromARGB(123, 121, 121, 121),
          highlightColor: const Color.fromARGB(255, 128, 128, 128),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/no_image.png',
          alignment: Alignment.center,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
