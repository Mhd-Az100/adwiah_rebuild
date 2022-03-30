import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
    this.brand,
    this.disease,
    required this.searchController,
    // required this.widget,
  }) : super(key: key);
  bool? brand = false;
  bool? disease = false;
  final TextEditingController searchController;
  InitialAppController ctrl = Get.find<InitialAppController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        controller: searchController,
        onChanged: (value) => ctrl.search(
            val: value, brand: brand ?? false, disease: disease ?? false),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Color(0xff1c2340), width: 2.0),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 0.0)),
            hintText: 'Search...'),
      ),
    );
  }
}
