import 'package:json_annotation/json_annotation.dart';
// 一次性生成: flutter packages pub run build_runner build
// 持续生成：flutter packages pub run build_runner watch
part 'system_model.g.dart';

@JsonSerializable()
class SystemModel {
  final List<SystemModel> children;
  final num courseId;
  final num id;
  final String name;
  final int order;
  final num parentChapterId;
  final bool userControlSetTop;
  final int visible;

  SystemModel(
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory SystemModel.fromJson(Map<String, dynamic> json) =>
      _$SystemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemModelToJson(this);

  /// json数组转model数组
  static List<SystemModel> objectArrayWithKeyValuesArray(
      List<dynamic> jsonList) {
    List<SystemModel> modelList = [];
    for (var i = 0; i < jsonList.length; i++) {
      SystemModel model = SystemModel.fromJson(jsonList[i]);
      modelList.add(model);
    }
    return modelList;
  }
}
