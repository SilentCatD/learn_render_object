import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum CustomColumnAlignment {
  start,
  center,
}

class CustomColumn extends MultiChildRenderObjectWidget {
  CustomColumn(
      {super.key,
      super.children,
      this.alignment = CustomColumnAlignment.center});

  final CustomColumnAlignment alignment;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomColumn(alignment: alignment);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomColumn renderObject) {
    renderObject.alignment = alignment;
  }
}

class RenderCustomColumn extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomColumnParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomColumnParentData> {
  RenderCustomColumn({required CustomColumnAlignment alignment})
      : _alignment = alignment;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = CustomColumnParentData();
    }
  }

  CustomColumnAlignment _alignment;

  CustomColumnAlignment get alignment => _alignment;

  set alignment(CustomColumnAlignment value) {
    if (_alignment == value) return;
    _alignment = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = _performLayout(constraints, false);
    var childOffset = const Offset(0, 0);
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as CustomColumnParentData;
      childParentData.offset = Offset(
          alignment == CustomColumnAlignment.center
              ? (size.width - child.size.width) / 2
              : 0,
          childOffset.dy);
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
        // print("h: $height | $flex| ${child.debugCreator}");
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
