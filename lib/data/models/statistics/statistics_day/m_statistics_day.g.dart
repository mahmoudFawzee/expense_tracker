// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_statistics_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsDayModel _$StatisticsDayModelFromJson(Map<String, dynamic> json) =>
    StatisticsDayModel(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$StatisticsDayModelToJson(StatisticsDayModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
    };
