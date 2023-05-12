import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/banner_widget.dart';
import 'package:presmaflix/ui/widgets/horizontal_grid_widget.dart';
import 'package:presmaflix/config/routing/argument/content/all_args.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Content> contents = Content.contents;
    return Scaffold(
      body: ListView(
        children: [
          BannerWidget(
            contents: contents.where((content) => content.isFeatured).toList(),
          ),
          const SizedBox(height: 15),
          AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width / 2,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  HorizontalGridWidget(
                    title: 'Movies',
                    contents: contents
                        .where((content) => content.type == 'movie')
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                  HorizontalGridWidget(
                    title: 'Animation',
                    contents: contents
                        .where((content) => content.type == 'animation')
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                  HorizontalGridWidget(
                    title: 'Tv Global',
                    contents: contents
                        .where((content) => content.type == 'tv-global')
                        .toList(),
                  ),
                  const SizedBox(height: 15),
                  HorizontalGridWidget(
                    title: 'Music Video',
                    contents: contents
                        .where((content) => content.type == 'music-video')
                        .toList(),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
