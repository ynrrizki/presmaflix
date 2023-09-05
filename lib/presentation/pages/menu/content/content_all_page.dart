import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/data/models/content/content.dart';
import 'package:presmaflix/presentation/widgets/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ContentAllPage extends StatelessWidget {
  const ContentAllPage(
      {super.key, required this.title, required this.contents});
  final String title;
  final List<Content> contents;

  // Apa yang kamu cari sehingga data tidak ditemukan? Tapi, sepertinya ini salah kami memiliki konten yang terlalu sedikit 😿.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),        
      ),
      body: contents.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 7,
                ),
                itemCount: contents.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: contents.length,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: PosterWidget(
                        content: contents[index],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(
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
            ),
    );
  }
}
