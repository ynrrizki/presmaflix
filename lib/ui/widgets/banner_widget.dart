import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:prima_studio/app/blocs/film/film_bloc.dart';
// import 'package:prima_studio/app/models/film.dart';
// import 'package:prima_studio/config/routing/arguments/arguments.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key, required this.data}) : super(key: key);
  final List<String> data;
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _indexCarousel = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.data
              .map(
                (data) => HeroCarouselCard(
                  data: data,
                  indexCarousel: _indexCarousel,
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
        const SizedBox(height: 15),
      ],
    );
  }
}

class HeroCarouselCard extends StatelessWidget {
  const HeroCarouselCard({
    super.key,
    required this.data,
    required this.indexCarousel,
  });

  final String data;
  final int indexCarousel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: data,
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
