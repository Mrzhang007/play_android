// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemModel _$SystemModelFromJson(Map<String, dynamic> json) {
  return SystemModel(
    (json['children'] as List<dynamic>)
        .map((e) => SystemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['courseId'] as num,
    json['id'] as num,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as num,
    json['userControlSetTop'] as bool,
    json['visible'] as int,
  );
}

Map<String, dynamic> _$SystemModelToJson(SystemModel instance) =>
    <String, dynamic>{
      'children': instance.children,
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
    };
