import 'package:flutter/material.dart';

class AdherentDetailPage extends StatelessWidget {
  final Map<String, dynamic> adherent;

  const AdherentDetailPage({required this.adherent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adherent['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(adherent['image']),
                radius: 50,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Name: ${adherent['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                Text(
                  '${adherent['rating']} out of 5',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Year of Birth: ${adherent['story']['yearOfBirth']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Place of Residence: ${adherent['story']['placeOfResidence']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Additional Info: ${adherent['story']['additionalInfo']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
