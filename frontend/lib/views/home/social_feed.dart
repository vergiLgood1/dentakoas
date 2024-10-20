import 'package:flutter/material.dart';

class SocialFeedPage extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'name': 'Koas A',
      'content': 'Hari ini melakukan perawatan gigi pada 5 pasien.',
      'timestamp': '2 hours ago'
    },
    {
      'name': 'Koas B',
      'content': 'Belajar tentang teknik pencabutan gigi di klinik.',
      'timestamp': '5 hours ago'
    },
    {
      'name': 'Koas C',
      'content': 'Melakukan pemeriksaan gigi secara gratis di Jember.',
      'timestamp': '1 day ago'
    },
  ];

  SocialFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Feed'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(posts[index]['name']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(posts[index]['content']!),
                  const SizedBox(height: 10),
                  Text(posts[index]['timestamp']!,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
