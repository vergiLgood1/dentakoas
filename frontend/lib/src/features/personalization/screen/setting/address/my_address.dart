import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/features/personalization/screen/setting/address/update_my_address.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const DAppBar(
        title: Text('My Address'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () {
            if (controller.user.value.address == null) {
              return const StateScreen(
                image: TImages.emptyAddress,
                title: 'No Address Found',
                subtitle:
                    'Please add your address by clicking the button below',
                isLottie: true,
              );
            }
            return DGridLayout(
              itemCount: 1,
              crossAxisCount: 1,
              mainAxisExtent: 130,
              itemBuilder: (_, index) {
                return AddressCard(
                  name: controller.user.value.name ?? 'N/A',
                  address: controller.user.value.address ?? 'N/A',
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Obx(
        () {
          if (controller.user.value.address == null) {
            return FloatingActionButton(
              backgroundColor: TColors.primary,
              onPressed: () => Get.to(() => const UpdateMyAddressScreen()),
              child: const Icon(
                color: TColors.textWhite,
                Iconsax.add,
                size: 32,
              ),
            );
          }
          return Container(); // Return an empty container if address is not null
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final String name, address;

  const AddressCard({
    super.key,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: TColors.grey, width: 2),
      ),
      elevation: 0, // Remove shadow by setting elevation to 0
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              address,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
