import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/picker_card.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({
    Key? key,
    required this.list,
    required this.leadingIcon,
    required this.onSelectedDay,
    this.initialDay,
    this.customLeadingWidget,
  }) : super(key: key);

  final String? initialDay;

  final List<String> list;
  final IconData leadingIcon;
  final Function(String) onSelectedDay;
  final Widget? customLeadingWidget;

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  String? selectedDay;

  @override
  Widget build(BuildContext context) {
    final selectedDayOrInitialDay = selectedDay ?? widget.initialDay;

    return PickerCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              widget.leadingIcon,
              color: kDefaultGrey,
              size: 20.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: DropdownSearch<String>(
                items: widget.list,
                dropdownSearchDecoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                ),
                onChanged: (selected) {
                  if (selected != null) {
                    widget.onSelectedDay(selected);
                  }
                },
                selectedItem: selectedDayOrInitialDay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
