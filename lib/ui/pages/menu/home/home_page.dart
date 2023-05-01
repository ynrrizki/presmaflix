import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:presmaflix/app/models/content.dart';
import 'package:presmaflix/ui/widgets/banner_widget.dart';
import 'package:presmaflix/ui/widgets/poster_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Content> contents = Content.contents;
    return Scaffold(
      body: ListView(
        children: [
          BannerWidget(
            data: contents.map((e) => e.thumbnailUrl).toList(),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top New Movies In 2023',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24,
                      ),
                    )
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 200,
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
                  // child: ListView(
                  //   scrollDirection: Axis.horizontal,
                  //   shrinkWrap: true,
                  //   children: [

                  //   ],
                  // ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// EXAMPLE in HERE ⬇️⬇️⬇️

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final ScrollController scrollController = ScrollController();
//     // return Scaffold(
//     //   body: ListView(
//     //     children: const [
//     //       SizedBox(
//     //         height: 1000,
//     //       ),
//     //       SizedBox(
//     //         height: 1000,
//     //       ),
//     //     ],
//     //   ),
//     // body: NestedScrollView(
//     //   controller: scrollController,
//     //   headerSliverBuilder: (context, innerBoxIsScrolled) {
//     //     return [];
//     //   },
//     //   body: ListView(
//     //     children: [
//     //       Container(
//     //         color: Colors.red,
//     //         height: 500,
//     //       ),
//     //       Container(
//     //         color: Colors.blue,
//     //         height: 500,
//     //       ),
//     //     ],
//     //   ),
//     // ),
//     // );
//     return AutoRefresh(
//       duration: const Duration(milliseconds: 2000),
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(
//               parent: AlwaysScrollableScrollPhysics(),
//             ),
//             padding: const EdgeInsets.all(16.0),
//             child: AnimationLimiter(
//               child: Column(
//                 children: AnimationConfiguration.toStaggeredList(
//                   duration: const Duration(milliseconds: 375),
//                   childAnimationBuilder: (widget) => SlideAnimation(
//                     horizontalOffset: MediaQuery.of(context).size.width / 2,
//                     child: FadeInAnimation(child: widget),
//                   ),
//                   children: [
//                     EmptyCard(
//                       width: MediaQuery.of(context).size.width,
//                       height: 166.0,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: const [
//                           EmptyCard(height: 50.0, width: 50.0),
//                           EmptyCard(height: 50.0, width: 50.0),
//                           EmptyCard(height: 50.0, width: 50.0),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: const [
//                         Flexible(child: EmptyCard(height: 150.0)),
//                         Flexible(child: EmptyCard(height: 150.0)),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: const [
//                           Flexible(child: EmptyCard(height: 50.0)),
//                           Flexible(child: EmptyCard(height: 50.0)),
//                           Flexible(child: EmptyCard(height: 50.0)),
//                         ],
//                       ),
//                     ),
//                     EmptyCard(
//                       width: MediaQuery.of(context).size.width,
//                       height: 166.0,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
