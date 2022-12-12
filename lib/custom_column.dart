import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomColumn extends MultiChildRenderObjectWidget {
  CustomColumn({super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomColumn();
  }
}

class RenderCustomColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomColumnParentData> {
  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = CustomColumnParentData();
    }
  }

  @override
  void performLayout() {
    double width = 0.0, height = 0.0;
    int totalFlex = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      int flex = childParentData.flex ?? 0;
      if (flex > 0) {
        totalFlex += flex;
      } else {
        child.layout(
          BoxConstraints(maxWidth: constraints.maxWidth),
          parentUsesSize: true,
        );
        height += child.size.height;
        width = max(width, child.size.width);
      }
      child = childParentData.nextSibling;
    }

    var flexHeight = (constraints.maxHeight - height) / totalFlex;
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      int flex = childParentData.flex ?? 0;
      if (flex > 0) {
        child.layout(
          BoxConstraints.tight(Size(constraints.maxWidth, flexHeight)),
          parentUsesSize: true,
        );
        height += child.size.height;
        width = max(width, child.size.width);
      }

      child = childParentData.nextSibling;
    }

    var childOffset = const Offset(0, 0);
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      childParentData.offset = Offset(0, childOffset.dy);
      childOffset += Offset(0, child.size.height);

      child = childParentData.nextSibling;
    }

    size = Size(width, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

class CustomColumnParentData extends ContainerBoxParentData<RenderBox> {
  int? flex;
}
