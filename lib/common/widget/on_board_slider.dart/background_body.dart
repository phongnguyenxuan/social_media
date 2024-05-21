import 'package:flutter/material.dart';

class BackgroundBody extends StatelessWidget {
  final PageController controller;
  final Function function;
  final int totalPage;
  final List<Widget> bodies;

  const BackgroundBody({
    required this.controller,
    required this.function,
    required this.totalPage,
    required this.bodies,
  });

  @override
  Widget build(BuildContext context) {
    assert(bodies.length == totalPage);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      onPageChanged: (value) {
        function(value);
      },
      children: bodies,
    );
  }
}
