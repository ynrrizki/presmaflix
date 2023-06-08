import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        shadowColor: Colors.grey,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderOnForeground: false,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                onTap: () {},
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://ui-avatars.com/api/?name=Yanuar Rizki Sanjaya',
                  ),
                ),
                title: const Text('Yanuar Rizki Sanjaya'),
                subtitle: const Text('yanuarrizki165@gmail.com'),
              ),
            ),
          ),
          Card(
            color: Colors.black,
            shadowColor: Colors.grey,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(Icons.search_outlined),
              title: const Text('Search'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed('/search'),
            ),
          ),
          Card(
            color: Colors.black,
            shadowColor: Colors.grey,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Notifications'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          Card(
            color: Colors.black,
            shadowColor: Colors.grey,
            elevation: 0.5,
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
