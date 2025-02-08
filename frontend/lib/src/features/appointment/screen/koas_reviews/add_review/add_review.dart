import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/rating_bar_shimmer.dart';
import 'package:denta_koas/src/features/appointment/controller/reviews_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/appointments_model.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class KoasAddReviewScreen extends StatelessWidget {
  const KoasAddReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewsController());
    AppointmentsModel appointment = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DAppBar(
        title: Text('Add Review'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Profile Image and Name
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage(TImages.userProfileImage3),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appointment.koas?.user?.fullName ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appointment.koas?.university ?? 'N/A',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.verified,
                                color: Colors.blue, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Experience Text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'How was your experience with Jonny?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const RatingBarShimmer();
                        }
                        // Key digunakan untuk memaksa rebuild widget
                        return RatingBar(
                          initialRating: controller.rating.value,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full:
                                const Icon(Icons.star, color: TColors.primary),
                            half: const Icon(Icons.star_half,
                                color: TColors.primary),
                            empty: const Icon(Icons.star_border,
                                color: TColors.primary),
                          ),
                          onRatingUpdate: (rating) {
                            Logger().i(rating);
                            controller.updateRating(rating);
                          },
                          ignoreGestures:
                              controller.userReview.isEmpty ? false : true,
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your overall rating',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Review Text Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add detailed review',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Form(
                          key: controller.reviewsFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${controller.commentLength.value}/500',
                                      style: TextStyle(
                                        color:
                                            controller.commentLength.value > 500
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() {
                                if (controller.isLoading.value) {
                                  return const CommentFieldShimmer();
                                }
                                return TextFormField(
                                  controller: controller.comment,
                                  validator: (value) =>
                                      TValidator.validateUserInput(
                                          "Comment", value, 500),
                                  maxLines: 5,
                                  enabled: controller.userReview.isEmpty
                                      ? true
                                      : false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter here',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Submit Button
          // Di KoasAddReviewScreen, modifikasi button Submit
          Obx(() {
            if (controller.isLoading.value) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      '',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.userReview.isEmpty
                      ? () {
                          controller.addReviewConfirmation(
                            appointment.schedule!.post.id,
                            appointment.koas!.user!.id!,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.userReview.isEmpty
                        ? Colors.blue
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: controller.userReview.isEmpty
                          ? const BorderSide(color: Colors.blue)
                          : const BorderSide(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            );
          } 
),
        ],
      ),
    );
  }
}
