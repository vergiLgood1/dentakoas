import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShowActionModal extends StatelessWidget {
  const ShowActionModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.open_in_new),
                  title: const Text('Publish'),
                  onTap: () {
                    // Handle open action
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.update),
                  title: const Text('Update'),
                  onTap: () {
                    // Handle update action
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Iconsax.trash, color: Colors.red),
                  title:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    // Handle delete action
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
