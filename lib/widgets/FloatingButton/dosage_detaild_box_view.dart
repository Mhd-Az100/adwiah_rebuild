import 'package:flutter/material.dart';

class DosageDetails extends StatelessWidget {
  final List<Widget> data;
  final controller = ScrollController();

  DosageDetails(this.data, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Scrollbar(
          isAlwaysShown: true,
          radius: const Radius.circular(10),
          controller: controller,
          child: ListView.builder(
            shrinkWrap: true,
            controller: controller,
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Padding(
                  padding: const EdgeInsets.all(8.0), child: data[i]);
            },
          ),
        ));
  }
}
