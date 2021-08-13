import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_listview/infinite_listview.dart';

class CalendarScrollView extends StatelessWidget {
  CalendarScrollView({
    Key? key,
    required InfiniteScrollController controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) => _infiniteListViewBuilder();

  InfiniteListView _infiniteListViewBuilder() {
    return InfiniteListView.builder(
      controller: _controller,
      itemBuilder: _infiniteListItemBuilder,
    );
  }

  Widget _infiniteListItemBuilder(context, index) {
    final DateTime time = DateTime.now().add(Duration(days: index));
    double _height, _padding;

    if (index.abs() >= 3) {
      _height = 0.2 * MediaQuery.of(context).size.height;
      _padding = 12.0;
    } else {
      _height = pow(0.5, index.abs()) * MediaQuery.of(context).size.height;
      _padding = 32.0 - (index.abs() * 8.0);
    }

    return Container(
      padding: EdgeInsets.all(_padding),
      height: _height,
      width: double.infinity,
      color: [Color(0xFF002B3C), Color(0xFF022D3E)][index % 2],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(time: time),
          _footer(time),
        ],
      ),
    );
  }

  TextStyle _textStyle(double fontSize) {
    return GoogleFonts.gotu(
      textStyle: TextStyle(
        color: Color(0x99335E70),
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        letterSpacing: 3,
      ),
    );
  }

  Row _header({required DateTime time}) {
    final List months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            months[time.month - 1],
            textAlign: TextAlign.left,
            style: _textStyle(12),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            time.day.toString(),
            textAlign: TextAlign.center,
            style: _textStyle(16),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            time.year.toString(),
            textAlign: TextAlign.right,
            style: _textStyle(12),
          ),
        ),
      ],
    );
  }

  Text _footer(DateTime time) {
    final List weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return Text(weekdays[time.weekday - 1], style: _textStyle(18));
  }
}
