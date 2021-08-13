import '../../components/calendar_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

class HomePage extends StatelessWidget {
  final ScrollController healthTipScrollController = ScrollController();

  final InfiniteScrollController calendarScrollController =
      InfiniteScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CalendarScrollView(
            controller: calendarScrollController,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              iconSize: 32,
              color: Colors.white.withOpacity(0.3),
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
