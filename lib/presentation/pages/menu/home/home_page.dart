import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/presentation/bloc/content/content_bloc.dart';
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';
import 'package:presmaflix/presentation/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1110,
          ),
          child: BlocBuilder<ContentBloc, ContentState>(
            buildWhen: (previous, current) => current is ContentLoaded,
            builder: (context, state) {
              List<Content> contents = [];
              if (state is ContentLoaded) {
                contents = state.contents;
              }
              if (contents.isNotEmpty) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
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
                    const SizedBox(height: 30),
                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset:
                                MediaQuery.of(context).size.width / 2,
                            child: FadeInAnimation(child: widget),
                          ),
                          children: [
                            _contentSection(
                              title: 'Movie',
                              type: 'movie',
                            ),
                            // const SizedBox(height: 15),
                            // _socialSection(
                            //   title: 'Instagram',
                            // ),
                            _contentSection(
                              title: 'Animation',
                              type: 'animation',
                            ),
                            _contentSection(
                              title: 'Tv Global',
                              type: 'tv-global',
                            ),
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
                        Icons.data_array_rounded,
                        size: 50,
                      ),
                      const SizedBox(height: 15),
                      // Ya ampun! Data tidak ditemukan
                      // Apa yang kamu cari sehingga data tidak ditemukan? Tapi, sepertinya ini salah kami memiliki konten yang terlalu sedikit 😿.
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Ya ampun! Data tidak ditemukan',
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
                          "Apa yang kamu cari sehingga data tidak ditemukan? Tapi, sepertinya ini salah kami memiliki konten yang terlalu sedikit 😿.",
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
        ),
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
          return Column(
            children: [
              HorizontalGridWidget(
                title: title,
                contents: state.contents
                    .where((content) => content.type == type)
                    .toList(),
              ),
              const SizedBox(height: 15),
            ],
          );
        } else if (state is ContentLoading) {
          return const Column(
            children: [
              SkletonHorizontalGridWidget(),
              SizedBox(height: 15),
            ],
          );
        } else {
          return const Column(
            children: [
              SkletonHorizontalGridWidget(),
              SizedBox(height: 15),
            ],
          );
        }
      },
    );
  }

  Widget _socialSection({
    required String title,
  }) {
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
            ],
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 150,
          ),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.6,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 10,
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              double left = 0, right = 0;
              if (index == 0) {
                left = 16;
              } else if (index == 5 - 1) {
                right = 16;
              }
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                margin: EdgeInsets.only(left: left, right: right),
              );
            },
          ),
        ),
      ],
    );
  }
}
