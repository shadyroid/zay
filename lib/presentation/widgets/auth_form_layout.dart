import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.child,
    this.horizontalPadding = 24,
    this.bottomPadding = 24,
  });

  final Widget child;
  final double horizontalPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 0.0;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            0,
            horizontalPadding,
            bottomPadding + keyboardInset,
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Align(
              alignment: Alignment.center,
              widthFactor: 1,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
