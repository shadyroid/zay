import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  const HorizontalListView._({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.physics,
    this.controller,
    this.reverse = false,
  });

  /// Creates a horizontal list from an explicit list of children.
  factory HorizontalListView({
    Key? key,
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    ScrollController? controller,
    bool reverse = false,
  }) {
    return HorizontalListView._(
      key: key,
      itemCount: children.length,
      itemBuilder: (_, index) => children[index],
      padding: padding,
      physics: physics,
      controller: controller,
      reverse: reverse,
    );
  }

  /// Creates a horizontal list lazily.
  const HorizontalListView.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.physics,
    this.controller,
    this.reverse = false,
  }) : separatorBuilder = null;

  /// Creates a horizontal list with separators.
  const HorizontalListView.separated({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.padding,
    this.physics,
    this.controller,
    this.reverse = false,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int i = 0; i < itemCount; i++) {
      children.add(itemBuilder(context, i));

      if (separatorBuilder != null && i < itemCount - 1) {
        children.add(separatorBuilder!(context, i));
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          reverse: reverse,
          physics: physics,
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      },
    );
  }
}