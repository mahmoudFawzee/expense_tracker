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

