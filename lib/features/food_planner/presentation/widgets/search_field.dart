import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 234, 234),
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14.0),
        decoration: const InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 5.0),
            child: Icon(
              Icons.search,
              size: 17,
              color: kBrownPrimary,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          border: InputBorder.none,
          hintText: 'Search Recipe',
        ),
      ),
    );
  }
}
