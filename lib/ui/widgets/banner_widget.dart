import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/config/routing/argument/content/detail_content_args.dart';
import 'package:shimmer/shimmer.dart';

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
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CarouselSlider(
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
            autoPlayAnimationDuration: const Duration(milliseconds: 300),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _indexCarousel = index;
              });
            },
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
          '/detail-content',
          arguments: DetailContentArguments(content: content),
        );
      },
      child: CachedNetworkImage(
        imageUrl: content.thumbnailUrl,
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
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
