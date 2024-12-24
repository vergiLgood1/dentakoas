import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AllKoasScreen extends StatelessWidget {
  const AllKoasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text('All Koas'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: SortableField(
            itemCount: 10,
            crossAxisCount: 2,
            itemBuilder: (_, index) => Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
