import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presmaflix/config/themes.dart';
import 'package:presmaflix/ui/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearchEmpty = true; // Tambahkan variabel ini

  @override
  void initState() {
    super.initState();
    searchController.addListener(_updateSearchState);
  }

  @override
  void dispose() {
    searchController.removeListener(_updateSearchState);
    searchController.dispose();
    super.dispose();
  }

  void _updateSearchState() {
    setState(() {
      isSearchEmpty = searchController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: SearchFieldWidget(
          hintText: 'Judul',
          searchController: searchController,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Batalkan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: isSearchEmpty ? const IdleSearch() : const LoadSearch(),
    );
  }
}

class LoadSearch extends StatelessWidget {
  const LoadSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String imageURL =
        'https://th.bing.com/th/id/OIP.1Lu2dyIYNRTo9_ahY91GlwAAAA?pid=ImgDet&rs=1';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: ListView(
        children: [
          Card(
            child: ListTile(
              onTap: () {},
              leading: Container(
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: CachedNetworkImageProvider(imageURL),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              title: Text(
                'Lookism',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rating 0.0',
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.star,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IdleSearch extends StatelessWidget {
  const IdleSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Pencarian Terakhir
          // List<Chip>

          // Judul Trending
          // Slider

          // Genre Favorit
          // GridBuilder

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: Text(
                    'Genre Favorite',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                    ),
                  ),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: [
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.track_changes_outlined),
                        title: const Text('Action'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.house_outlined),
                        title: const Text('Drama'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.emoji_emotions_outlined),
                        title: const Text('Commedy'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.wifi),
                        title: const Text('Horror'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.usb_rounded),
                        title: const Text('Drama'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.usb_rounded),
                        title: const Text('Thriller'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
