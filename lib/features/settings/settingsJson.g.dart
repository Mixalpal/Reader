// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingsJson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsJson _$SettingsJsonFromJson(Map<String, dynamic> json) => SettingsJson(
      json['font'] as String,
      json['fontSize'] as int,
      json['sortingPrinciple'] as String,
      json['isChecked'] as bool,
    );

Map<String, dynamic> _$SettingsJsonToJson(SettingsJson instance) =>
    <String, dynamic>{
      'font': instance.font,
      'fontSize': instance.fontSize,
      'sortingPrinciple': instance.sortingPrinciple,
      'isChecked': instance.isChecked,
    };
