import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.0,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        style: const TextStyle(fontSize: 14.0),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            child: Icon(
              Icons.search,
              size: 20,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          hintText: 'Search Recipe',
        ),
      ),
    );
  }
}
