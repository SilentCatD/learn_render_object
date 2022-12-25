import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:learn_render_object/custom_column.dart';


class CustomBox extends LeafRenderObjectWidget {
  final Color color;
  final int flex;

  const CustomBox({super.key, required this.color, this.flex = 1});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomBox(color: color, flex: flex);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomBox renderObject) {
    renderObject
      ..flex = flex
      ..color = color;
  }
}

class RenderCustomBox extends RenderBox {
  RenderCustomBox({required Color color, required int flex})
      : _color = color,
        _flex = flex;

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
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }
}
