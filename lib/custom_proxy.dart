import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomProxy extends SingleChildRenderObjectWidget {
  const CustomProxy({super.key, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomProxy();
  }
}

class RenderCustomProxy extends RenderProxyBox {
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.saveLayer(offset & size, Paint()..blendMode = BlendMode.difference);
    context.paintChild(child!, offset);
    canvas.restore();
  }
}
