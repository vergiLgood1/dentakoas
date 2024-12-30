import 'dart:convert';

import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen({super.key});

  @override
  CancelBookingScreenState createState() => CancelBookingScreenState();
}

class CancelBookingScreenState extends State<CancelBookingScreen> {
  List<String> reasons = [];
  String selectedReason = '';
  String otherReasonDetail = '';

  @override
  void initState() {
    super.initState();
    loadReasons();
  }

  void loadReasons() {
    const jsonData = '''
    {
      "reasons": [
        "Schedule Change",
        "Weather conditions",
        "Unexpected Work",
        "Childcare Issue",
        "Travel Delays",
        "Other"
      ]
    }
    ''';

    final data = json.decode(jsonData);
    setState(() {
      reasons = List<String>.from(data['reasons']);
      if (reasons.isNotEmpty) {
        selectedReason = reasons[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DAppBar(
        title: Text('Cancel Appointment'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: reasons.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Please select the reason for cancellations:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 20),
                    ...reasons.map((reason) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                            Text(reason, style: const TextStyle(fontSize: 16)),
                        leading: Radio<String>(
                          value: reason,
                          groupValue: selectedReason,
                          onChanged: (value) {
                            setState(() {
                              selectedReason = value!;
                              if (selectedReason != 'Other') {
                                otherReasonDetail = '';
                              }
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      );
                    }),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    if (selectedReason == 'Other') ...[
                      const Text(
                        'Other',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        maxLines: 3,
                        onChanged: (value) {
                          setState(() {
                            otherReasonDetail = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Reason',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (selectedReason == 'Other' && otherReasonDetail.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please provide details for "Other" reason.'),
                  ),
                );
              } else {
                if (selectedReason == 'Other') {
                  debugPrint(
                      'Selected Reason: $selectedReason, Detail: $otherReasonDetail');
                } else {
                  debugPrint('Selected Reason: $selectedReason');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              'Cancel Appointment',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
