import 'package:flutter/material.dart';

class HealthTipOverlayScrollView extends StatelessWidget {
  const HealthTipOverlayScrollView({
    Key? key,
    required ScrollController controller,
  })  : _controller = controller,
        super(key: key);

  final _controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                transform: Matrix4.translationValues(
                  [
                    MediaQuery.of(context).size.width * (3 / 5),
                    MediaQuery.of(context).size.width * (-3 / 5),
                  ][index % 2],
                  0,
                  0,
                ),
                margin: const EdgeInsets.symmetric(vertical: 180),
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xFF335E6F),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
