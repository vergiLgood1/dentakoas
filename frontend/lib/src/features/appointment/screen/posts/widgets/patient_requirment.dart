import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PatientRequirments extends StatelessWidget {
  final List<String> patientRequirements;

  const PatientRequirments({super.key, required this.patientRequirements});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Requirements',
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: TColors.textPrimary,
                ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: List.generate(patientRequirements.length, (index) {
              return Chip(
                label: Text(patientRequirements[index]),
                backgroundColor: TColors.white,
                labelStyle: const TextStyle(color: TColors.textSecondary),
              );
            }),
          ),
        ],
      ),
    );
  }
}
