import 'package:flutter/material.dart';
import 'adherent_detail_page.dart';

class AdherentPage extends StatefulWidget {
  const AdherentPage({Key? key}) : super(key: key);

  @override
  _AdherentPageState createState() => _AdherentPageState();
}

class _AdherentPageState extends State<AdherentPage> {
  final List<Map<String, dynamic>> adherents = [
    {
      'id': '1',
      'name': 'George Orwell',
      'rating': 4,
      'image': 'assets/George Orwell.jpg',
      'story': {
        'yearOfBirth': 1903,
        'placeOfResidence': 'London, England',
        'additionalInfo': 'Author of "1984" and "Animal Farm"',
      },
    },
    {
      'id': '2',
      'name': 'Harper Lee',
      'rating': 3,
      'image': 'assets/Harper Lee.jpg',
      'story': {
        'yearOfBirth': 1926,
        'placeOfResidence': 'Monroeville, Alabama, USA',
        'additionalInfo': 'Author of "To Kill a Mockingbird"',
      },
    },
    {
      'id': '3',
      'name': 'F. Scott Fitzgerald',
      'rating': 5,
      'image': 'assets/Scott Fitzgerald.jpg',
      'story': {
        'yearOfBirth': 1896,
        'placeOfResidence': 'St. Paul, Minnesota, USA',
        'additionalInfo': 'Author of "The Great Gatsby"',
      },
    },
  ];

  void _navigateToAdherentDetail(BuildContext context, Map<String, dynamic> adherent) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdherentDetailPage(adherent: adherent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adherents')),
      body: ListView.builder(
        itemCount: adherents.length,
        itemBuilder: (context, index) {
          final adherent = adherents[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(adherent['image']),
            ),
            title: Text(adherent['name']),
            subtitle: Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                Text('${adherent['rating']} out of 5'),
              ],
            ),
            onTap: () => _navigateToAdherentDetail(context, adherent),
          );
        },
      ),
    );
  }
}
