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
    size = _performLayout(constraints, false);
    var childOffset = const Offset(0, 0);
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      childParentData.offset = Offset(0, childOffset.dy);
      childOffset += Offset(0, child.size.height);

      child = childParentData.nextSibling;
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(constraints, true);
  }

  Size _performLayout(BoxConstraints constraints, bool dryLayoutPass) {
    double width = 0.0, height = 0.0;
    int totalFlex = 0;
    RenderBox? child = firstChild;
    final childConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      int flex = childParentData.flex ?? 0;
      if (flex > 0) {
        totalFlex += flex;
      } else {
        Size childSize;
        if (!dryLayoutPass) {
          child.layout(
            childConstraints,
            parentUsesSize: true,
          );
          childSize = child.size;
        } else {
          childSize = child.getDryLayout(childConstraints);
        }
        height += childSize.height;
        width = max(width, childSize.width);
      }
      child = childParentData.nextSibling;
    }

    var flexHeight = (constraints.maxHeight - height) / totalFlex;
    child = firstChild;
    final flexConstraints =
        BoxConstraints.tight(Size(constraints.maxWidth, flexHeight));
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      int flex = childParentData.flex ?? 0;
      if (flex > 0) {
        Size flexSize;
        if (!dryLayoutPass) {
          child.layout(
            flexConstraints,
            parentUsesSize: true,
          );
          flexSize = child.size;
        } else {
          flexSize = child.getDryLayout(flexConstraints);
        }
        height += flexSize.height;
        width = max(width, flexSize.width);
      }

      child = childParentData.nextSibling;
    }
    return Size(width, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

class CustomColumnParentData extends ContainerBoxParentData<RenderBox> {
  int? flex;
}
