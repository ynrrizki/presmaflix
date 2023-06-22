import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/app/bloc/content/content_bloc.dart';
import 'package:presmaflix/app/models/content/content.dart';
import 'package:presmaflix/config/themes.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ContentBloc, ContentState>(
        buildWhen: (previous, current) => current is ContentLoaded,
        builder: (context, state) {
          List<Content> contents = [];
          if (state is ContentLoaded) {
            contents = state.contents;
          }
          if (contents.isNotEmpty) {
            return ListView(
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
                          backgroundColor:
                              const Color.fromARGB(125, 124, 124, 124),
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
                        _contentSection(
                          title: 'Movie',
                          type: 'movie',
                        ),
                        const SizedBox(height: 15),
                        _contentSection(
                          title: 'Animation',
                          type: 'animation',
                        ),
                        const SizedBox(height: 15),
                        _contentSection(
                          title: 'Tv Global',
                          type: 'tv-global',
                        ),
                        const SizedBox(height: 15),
                        _contentSection(
                          title: 'Music Video',
                          type: 'music-video',
                        ),
                        // AspectRatio(
                        //   aspectRatio: 16 / 9,
                        //   child: Image.asset(
                        //       'assets/illustration/Popcorns-pana.png'),
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ContentLoading) {
            return Container();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inbox,
                    size: 50,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Sorry, the home page content is currently unavailable',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "We apologize for the inconvenience. Please try again later.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 180, 180, 180),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _banner() {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoaded) {
          return BannerWidget(
            contents:
                state.contents.where((content) => content.isFeatured).toList(),
          );
        } else if (state is ContentLoading) {
          return CircularProgressIndicator(
            color: kPrimaryColor,
          );
        } else {
          return const BannerWidget(contents: []);
        }
      },
    );
  }

  Widget _contentSection({
    required String title,
    required String type,
  }) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoaded) {
          return HorizontalGridWidget(
            title: title,
            contents: state.contents
                .where((content) => content.type == type)
                .toList(),
          );
        } else if (state is ContentLoading) {
          return const SkletonHorizontalGridWidget();
        } else {
          return const SkletonHorizontalGridWidget();
        }
      },
    );
  }
}
