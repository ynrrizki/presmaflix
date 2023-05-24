import 'package:equatable/equatable.dart';

class Content extends Equatable {
  final String id;
  final String title;
  final String type;
  final List<String> genre;
  final String description;
  final List<String> casts;
  final List<String> directors;
  final String thumbnailUrl;
  final String posterUrl;
  final bool isFeatured;
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
    this.isFeatured = false,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        genre,
        description,
        casts,
        directors,
        thumbnailUrl,
        posterUrl,
        isFeatured,
        createdAt,
      ];

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
      isFeatured: true,
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
      isFeatured: true,
      createdAt: '2018-03-07T00:00:00Z',
    ),
    Content(
      id: '3',
      title: 'Sultan Agung: Tahta, Perjuangan, Cinta',
      type: 'movie',
      genre: ["Drama", "History"],
      description:
          'Sultan Agung: Tahta, Perjuangan, Cinta is a 2018 Indonesian historical drama film directed by Hanung Bramantyo. The film tells the story of Sultan Agung of Mataram, a powerful and respected Javanese ruler who fought against the Dutch East India Company during the 17th century. It stars Ario Bayu as Sultan Agung and Adinia Wirasti as his wife, Queen Batang. ',
      casts: [
        "Ario Bayu",
        "Adinia Wirasti",
        "Ade Firman Hakim",
        "Prabu Revolusi",
      ],
      directors: ["Hanung Bramantyo"],
      thumbnailUrl: 'https://i.ytimg.com/vi/JGMYauvJr04/maxresdefault.jpg',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BMTU4NmQ5NjMtODY2NC00NTcyLTg5NWUtN2Y1YmY3MTNhYmIxXkEyXkFqcGdeQXVyODYwNTU1MzM@._V1_FMjpg_UY678_.jpg',
      createdAt: '2018-03-15T00:00:00Z',
    ),
    Content(
      id: '4',
      title: 'Gundala',
      type: 'movie',
      genre: ["Action", "Superhero"],
      description:
          'Gundala is a 2019 Indonesian superhero film directed by Joko Anwar. It is based on the popular Indonesian comic book character of the same name. The film follows Sancaka, a security guard who gains superhuman powers after being struck by lightning. He becomes the masked hero, Gundala, and fights against evil forces threatening his city. It stars Abimana Aryasatya as Sancaka/Gundala.',
      casts: [
        "Abimana Aryasatya",
        "Tara Basro",
        "Bront Palarae",
        "Rio Dewanto",
      ],
      directors: ["Joko Anwar"],
      thumbnailUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvhx.imgix.net%2Fhi-yahtv%2Fassets%2Fec2b996f-ad48-4f00-a4f1-190a75277cb7-0f7d510c.jpg%3Fauto%3Dformat%252Ccompress%26fit%3Dcrop%26h%3D720%26w%3D1280&f=1&nofb=1&ipt=5ca164c5f05ea4cd6653d57782daf728f2d0596c4bc65983f157c37c6b626ce4&ipo=images',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BYjk5MWVlMWUtZmJlYi00ZGQ0LWJkZDItOGViZjdhOTI4YWE5XkEyXkFqcGdeQXVyNDA1NDA2NTk@._V1_FMjpg_UY691_.jpg',
      isFeatured: true,
      createdAt: '2019-08-01T00:00:00Z',
    ),
    Content(
      id: '5',
      title: 'Marlina the Murderer in Four Acts',
      type: 'movie',
      genre: ["Drama", "Thriller"],
      description:
          'Marlina the Murderer in Four Acts is a 2017 Indonesian drama-thriller film directed by Mouly Surya. The film tells the story of Marlina, a young widow who seeks revenge against the men who have wronged her. Along the way, she meets other women who have suffered similar fates and together they embark on a journey of empowerment and justice. It stars Marsha Timothy as Marlina.',
      casts: [
        "Marsha Timothy",
        "Dea Panendra",
        "Yayu A.W. Unru",
        "Egi Fedly",
      ],
      directors: ["Mouly Surya"],
      thumbnailUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.ytimg.com%2Fvi%2FSlgOPppnrMg%2Fmaxresdefault.jpg&f=1&nofb=1&ipt=b1dcab2db914b66c2690381f0675f0b88e3a1f91e159ede7c2aa9ee1221ad04f&ipo=images',
      posterUrl:
          'https://m.media-amazon.com/images/M/MV5BZTgzNWUyMDUtOTlhZi00NzE5LWI5YTAtZjcxMDQ5YzE5N2ZmXkEyXkFqcGdeQXVyMzY3MDU4NDk@._V1_FMjpg_UX674_.jpg',
      createdAt: '2017-10-15T00:00:00Z',
    ),
    Content(
      id: '6',
      title: 'Game of Thrones',
      type: 'tv-global',
      genre: ["Fantasy", "Drama"],
      description:
          'Game of Thrones is an American fantasy drama television series created by David Benioff and D. B. Weiss. It is based on the A Song of Ice and Fire novels by George R. R. Martin. The series follows several noble houses in a civil war for the Iron Throne of the Seven Kingdoms of Westeros, and the stories of the various characters involved. It premiered on HBO in 2011 and ran for eight seasons. It stars an ensemble cast including Peter Dinklage, Lena Headey, Emilia Clarke, Kit Harington, Sophie Turner, and Maisie Williams.',
      casts: [
        "Peter Dinklage",
        "Lena Headey",
        "Emilia Clarke",
        "Kit Harington",
        "Sophie Turner",
        "Maisie Williams",
      ],
      directors: ["David Benioff", "D. B. Weiss"],
      thumbnailUrl:
          'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fabconventionagent.com%2Fwp-content%2Fuploads%2F2019%2F05%2Fthumbnail_game-of-thrones-background-1366x768-laptop-383313-1.jpg&f=1&nofb=1&ipt=98f2ce1733ef8e2ac99a02584d4447800f7e1159c2226aeda891bbd63e3f32ad&ipo=images',
      posterUrl:
          'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fi.redd.it%2Fh7uga1bv24fz.jpg&f=1&nofb=1&ipt=83525d5bc6b1eb6882dbb0b93231deabfad9f6adcdc005579a33200fbc76f0b1&ipo=images',
      createdAt: '2011-04-17T00:00:00Z',
    )
  ];
}
