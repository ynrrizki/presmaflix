class Content {
  final String id;
  final String title;
  final String type;
  final List<String> genre;
  final String description;
  final List<String> casts;
  final List<String> directors;
  final String thumbnailUrl;
  final String posterUrl;
  // final DateTime createdAt;
  final String createdAt;

  const Content({
    required this.id,
    required this.title,
    required this.type,
    required this.genre,
    required this.description,
    required this.casts,
    required this.directors,
    required this.thumbnailUrl,
    required this.posterUrl,
    required this.createdAt,
  });

  static List<Content> contents = const [
    Content(
      id: '1',
      title: 'Spider-Man: No Way Home',
      type: 'movie',
      genre: [
        "Action",
        "Adventure",
        "Sci-Fi",
      ],
      description:
          'Following the events of Spider-Man: Far From Home (2019), Peter Parker teams up with several alternate versions of himself to stop a threat to all reality.',
      casts: [
        "Tom Holland",
        "Zendaya",
        "Benedict Cumberbatch",
      ],
      directors: ["Jon Watts"],
      thumbnailUrl:
          'https://www.ruparupa.com/blog/wp-content/uploads/2021/12/SPIDER-MAN-_-3-NO-WAY-HOME-2021OFFICIAL-Teaser-Trailer-Tom-Holland-Jamie-Foxx-%C2%A6-Marvel-Studios.jpg',
      posterUrl:
          'https://assets-prd.ignimgs.com/2021/11/15/spiderman-nowayhome-button-1637000869202.jpg',
      createdAt: '2021-12-17T00:00:00Z',
    ),
    Content(
      id: '2',
      title: 'Buya Hamka',
      type: 'movie',
      genre: ["Drama", "Biography"],
      description:
          'Buya Hamka is a 2018 Indonesian biographical drama film directed by Ifa Isfansyah. The film depicts the life of Hamka, a prominent Indonesian Islamic scholar and writer, from his childhood in Minangkabau to his education in Mecca and his literary career in Indonesia. It stars Ario Bayu as Hamka and Christine Hakim as his mother.',
      casts: [
        "Ario Bayu",
        "Christine Hakim",
        "Maudy Koesnaedi",
      ],
      directors: ["Ifa Isfansyah"],
      thumbnailUrl: 'https://i.ytimg.com/vi/fAQnkdaGisM/maxresdefault.jpg',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BMjhkZjQyOGYtM2Y3OS00ZDFjLWFiMTEtMzJmNjBjNmM0MTFiXkEyXkFqcGdeQXVyMTEzMTI1Mjk3._V1_FMjpg_UX1000_.jpg',
      createdAt: '2018-03-07T00:00:00Z',
    ),
  ];
}
