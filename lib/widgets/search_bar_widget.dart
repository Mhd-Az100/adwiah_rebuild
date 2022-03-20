import 'package:adwiah/View/IngredientsScreen/Components/ingredients_topbar_widget.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.searchController,
    // required this.widget,
  }) : super(key: key);

  final TextEditingController searchController;
  // final IngredientsTopBar widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        controller: searchController,
        // onChanged: (value) => this.widget.callback(value),
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
