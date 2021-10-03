import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:loggy/loggy.dart';

import '../../../core/authentication/PLoC/authentication_bloc/authentication_bloc.dart';
import '../../../core/authentication/PLoC/authentication_bloc/authentication_events.dart';
import '../../components/calendar_scroll_view.dart';

class HomePage extends StatelessWidget with UiLoggy {
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
              onPressed: () {
                loggy.info("This Button Pressed");
                loggy.info("");
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
          ),
        ],
      ),
    );
  }
}
