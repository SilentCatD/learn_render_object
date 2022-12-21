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
}

class RenderCustomBox extends RenderBox {
  RenderCustomBox({required Color color, required int flex})
      : _color = color,
        _flex = flex;

  Color _color;
  int _flex;

  Color get color => _color;

  int get flex => _flex;

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
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    parentData!.flex = _flex;
  }
}
