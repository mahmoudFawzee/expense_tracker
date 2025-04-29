// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_statistics_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsDayModel _$StatisticsDayModelFromJson(Map<String, dynamic> json) =>
    StatisticsDayModel(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      dayName: json['dayName'] as String,
    );

Map<String, dynamic> _$StatisticsDayModelToJson(StatisticsDayModel instance) =>
    <String, dynamic>{
      'dayName': instance.dayName,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
    };
