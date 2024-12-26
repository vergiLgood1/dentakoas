import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/commons/widgets/text/title_with_verified.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class KoasDetailScreen extends StatelessWidget {
  const KoasDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      const DoctorProfileSection(
        imageUrl: TImages.userProfileImage3,
        name: 'Dr. Bellamy Nicholas',
        university: 'London Bridge Hospital',
      ),
      const DoctorStatsSection(),
      const DoctorDescriptionSection(
        bio:
            'Dr. Bellamy Nicholas is a highly experienced doctor with over 10 years of experience in the field. He has treated over 1000 patients and has a rating of 4.5. He is available for consultation from Monday to Saturday between 8:30 AM and 9:00 PM.',
      ),
      const WorkingTimeSection(),
      const CommunicationSection(),
      const BookAppointmentButton(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) => sections[index],
      ),
    );
  }
}

class DoctorProfileSection extends StatelessWidget {
  const DoctorProfileSection({
    super.key,
    this.isNetworkImage = false,
    required this.imageUrl,
    required this.name,
    required this.university,
  });

  final bool isNetworkImage;
  final String imageUrl, name, university;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: isNetworkImage
              ? NetworkImage(imageUrl)
              : AssetImage(imageUrl), // Replace with real image URL
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: TColors.textPrimary,
              ),
        ),
        TitleWithVerified(
          title: university,
          textSizes: TextSizes.base,
          textColor: TColors.textSecondary,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}

class DoctorStatsSection extends StatelessWidget {
  const DoctorStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'label': 'Patients',
        'value': '1000+',
        'icon': Icons.groups,
        'color': Colors.blue
      },
      {
        'label': 'Experience',
        'value': '10 Yrs',
        'icon': Icons.workspace_premium,
        'color': Colors.pink
      },
      {
        'label': 'Ratings',
        'value': '4.5',
        'icon': Icons.star_rate,
        'color': Colors.amber
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stats.map((stat) {
          return Expanded(
            child: Card(
              color: TColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          (stat['color'] as Color).withOpacity(0.2),
                      child: Icon(
                        stat['icon'] as IconData,
                        color: stat['color'] as Color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      stat['value'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      stat['label'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DoctorDescriptionSection extends StatelessWidget {
  const DoctorDescriptionSection({super.key, required this.bio});

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'About Doctor',
            showActionButton: false,
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          ReadMoreText(
            bio,
            style: const TextStyle(
              fontSize: 14,
              color: TColors.textSecondary,
            ),
            textAlign: TextAlign.justify,
            trimLines: 5,
            trimMode: TrimMode.Line,
            trimExpandedText: ' Show less ',
            trimCollapsedText: ' Show more ',
            moreStyle: const TextStyle(
              fontSize: TSizes.fontSizeSm,
              color: TColors.primary,
              fontWeight: FontWeight.bold,
            ),
            lessStyle: const TextStyle(
              fontSize: TSizes.fontSizeSm,
              color: TColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkingTimeSection extends StatelessWidget {
  const WorkingTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Mon - Sat (08:30 AM - 09:00 PM)',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class CommunicationSection extends StatelessWidget {
  const CommunicationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final communicationOptions = [
      {
        'label': 'Messaging',
        'description': 'Chat me up, share photos.',
        'icon': Icons.message
      },
      {
        'label': 'Audio Call',
        'description': 'Call your doctor directly.',
        'icon': Icons.phone
      },
      {
        'label': 'Video Call',
        'description': 'See your doctor live.',
        'icon': Icons.videocam
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Communication',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...communicationOptions.map(
            (option) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(option['icon'] as IconData, color: Colors.blue),
              ),
              title: Text(option['label'] as String),
              subtitle: Text(option['description'] as String),
            ),
          ),
        ],
      ),
    );
  }
}

class BookAppointmentButton extends StatelessWidget {
  const BookAppointmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Action to book an appointment
          },
          child: const Text(
            'Book Appointment',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
