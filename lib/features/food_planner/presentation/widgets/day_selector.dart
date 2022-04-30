import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:kubo/core/constants/colors_constants.dart';
import 'package:kubo/features/food_planner/presentation/widgets/picker_card.dart';

class DaySelector extends StatefulWidget {
  const DaySelector({
    Key? key,
    required this.list,
    required this.leadingIcon,
    required this.onSelectedDay,
    this.customLeadingWidget,
  }) : super(key: key);

  final List<String> list;
  final IconData leadingIcon;
  final Function(int?) onSelectedDay;
  final Widget? customLeadingWidget;

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  int initialIndex = 0;

  DirectSelectItem<String> _getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
      itemHeight: 56,
      value: value,
      itemBuilder: (context, value) {
        return Text(value);
      },
    );
  }

  _getDslDecoration() {
    return const BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.onSelectedDay(initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PickerCard(
      child: Row(
        mainAxisSize: MainAxisSize.max,
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
              padding: const EdgeInsets.only(left: 10),
              child: DirectSelectList<String>(
                values: widget.list,
                defaultItemIndex: initialIndex,
                itemBuilder: (String value) => _getDropDownMenuItem(value),
                focusedItemDecoration: _getDslDecoration(),
                onItemSelectedListener: (item, index, context) {
                  widget.onSelectedDay(index);

                  setState(() {
                    initialIndex = index;
                  });
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.unfold_more,
              color: kBlackPrimary,
            ),
          )
        ],
      ),
    );
  }
}
