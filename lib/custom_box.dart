import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:learn_render_object/custom_column.dart';

class CustomBox extends LeafRenderObjectWidget {
  final Color color;
  final int flex;
  final double rotation;
  final VoidCallback? onTap;

  const CustomBox({
    super.key,
    this.rotation = 0,
    required this.color,
    this.flex = 1,
    this.onTap,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomBox(
      color: color,
      flex: flex,
      rotation: rotation,
      onTap: onTap,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomBox renderObject) {
    renderObject
      ..flex = flex
      ..color = color
      ..rotation = rotation
      ..onTap = onTap;
  }
}

class RenderCustomBox extends RenderBox {
  RenderCustomBox(
      {required VoidCallback? onTap,
      required Color color,
      required double rotation,
      required int flex})
      : _color = color,
        _flex = flex,
        _rotation = rotation,
        _onTap = onTap;

  int _flex;

  int get flex => _flex;

  set flex(int value) {
    assert(value >= 0);
    if (flex == value) return;
    _flex = value;
    parentData?.flex = _flex;
    markParentNeedsLayout();
  }

  Color _color;

  Color get color => _color;

  set color(Color value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  double _rotation;

  double get rotation => _rotation;

  set rotation(double value) {
    if (_rotation == value) return;
    _rotation = value;
    markNeedsPaint();
  }

  VoidCallback? _onTap;

  VoidCallback? get onTap => _onTap;

  set onTap(VoidCallback? value) {
    if (value == _onTap) return;
    _onTap = value;
    _tapGestureRecognizer.onTap = _onTap;
  }

  late final TapGestureRecognizer _tapGestureRecognizer;

  @override
  bool get sizedByParent => true;

  @override
  CustomColumnParentData? get parentData {
    if (super.parentData == null) return null;
    assert(super.parentData is CustomColumnParentData,
        "$CustomBox can only be the direct child of a $CustomColumn");
    return super.parentData as CustomColumnParentData;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    parentData?.flex = flex;
    _tapGestureRecognizer = TapGestureRecognizer(debugOwner: this)
      ..onTap = onTap;
  }

  @override
  void detach() {
    _tapGestureRecognizer.dispose();
    super.detach();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final smallRectSizeWith = size.shortestSide / 3;

    canvas.save();
    canvas.drawRect(offset & size, Paint()..color = color);
    canvas.translate(offset.dx + size.width / 2, offset.dy + size.height / 2);
    canvas.rotate(rotation);
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset.zero,
          width: smallRectSizeWith,
          height: smallRectSizeWith),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );
    canvas.restore();
  }
}
