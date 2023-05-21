import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presmaflix/app/bloc/content/content_bloc.dart';
import 'package:presmaflix/ui/widgets/banner_widget.dart';
import 'package:presmaflix/ui/widgets/horizontal_grid_widget.dart';
import 'package:presmaflix/ui/widgets/skleton_horizontal_grid_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              _banner(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton.small(
                    onPressed: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed('/search');
                    },
                    backgroundColor: const Color.fromARGB(125, 124, 124, 124),
                    child: const Icon(
                      CupertinoIcons.search,
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
                  _contentSection(title: 'Animation', type: 'animation'),
                  const SizedBox(height: 15),
                  _contentSection(title: 'Tv Global', type: 'tv-global'),
                  const SizedBox(height: 15),
                  _contentSection(title: 'Music Video', type: 'music-video'),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) => state is ContentLoaded
          ? BannerWidget(
              contents: state.contents
                  .where((content) => content.isFeatured)
                  .toList(),
            )
          : const BannerWidget(contents: []),
    );
  }

  Widget _contentSection({
    required String title,
    required String type,
  }) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) => state is ContentLoaded
          ? HorizontalGridWidget(
              title: title,
              contents: state.contents
                  .where((content) => content.type == type)
                  .toList(),
            )
          : const SkletonHorizontalGridWidget(),
    );
  }
}
