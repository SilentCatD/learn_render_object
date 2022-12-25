import 'package:flutter/material.dart';
import 'package:learn_render_object/custom_column.dart';

class CustomExpanded extends ParentDataWidget<CustomColumnParentData> {
  const CustomExpanded(
      {super.key, this.flex = 1, super.child = const SizedBox.shrink()})
      : assert(flex > 0);

  final int flex;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as CustomColumnParentData;
    if (parentData.flex != flex) {
      parentData.flex = flex;
      final targetObject = renderObject.parent;
      if (targetObject is RenderObject) {
        targetObject.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => CustomColumn;
}
