import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presmaflix/app/bloc/content/content_bloc.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/banner_widget.dart';
import 'package:presmaflix/ui/widgets/horizontal_grid_widget.dart';
import 'package:presmaflix/ui/widgets/skleton_horizontal_grid_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Content> contents = Content.contents;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              BannerWidget(
                contents:
                    contents.where((content) => content.isFeatured).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.small(
                    onPressed: () {},
                    backgroundColor: Colors.transparent,
                    child: const Icon(
                      CupertinoIcons.search,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
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
                  _contentSection(title: 'Movie', type: 'movie'),
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

  Widget _contentSection({
    required String title,
    required String type,
  }) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoading) {
          return const SkletonHorizontalGridWidget();
        }
        if (state is ContentLoaded) {
          return HorizontalGridWidget(
            title: title,
            contents: state.contents
                .where((content) => content.type == type)
                .toList(),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Text('Something went wrong')],
          );
        }
      },
    );
  }
}
