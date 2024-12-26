import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/screen/explore/widget/tab_parnert.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllKoasScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hospitals = [
    {
      'name': 'Serenity Wellness Clinic',
      'major': 'Dental, Skin care',
      'address': '8502 Preston Rd. Inglewood, Maine 98380',
      'distance': '1.5km',
      'time': '15 min',
      'koasCount': 100,
      'imageUrl': 'https://via.placeholder.com/300x200', // Placeholder image
    },
    {
      'name': 'Radiant Health Family Clinic',
      'major': 'Dental, Skin care',
      'address': '8502 Preston Rd. Inglewood, Maine 98380',
      'distance': '1.5km',
      'time': '15 min',
      'koasCount': 100,
      'imageUrl': 'https://via.placeholder.com/300x200', // Placeholder image
    },
  ];

  AllKoasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text('University'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Categories
              DGridLayout(
                itemCount: hospitals.length,
                crossAxisCount: 1,
                mainAxisExtent: 330,
                itemBuilder: (_, index) {
                  final hospital = hospitals[index];
                  return UniversityCard(
                    image: hospital['imageUrl'],
                    title: hospital['name'],
                    subtitle: hospital['major'],
                    address: hospital['address'],
                    distance: hospital['distance'],
                    koasCount: hospital['koasCount'],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
