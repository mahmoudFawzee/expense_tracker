// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_based_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeBasedStatistics _$TimeBasedStatisticsFromJson(Map<String, dynamic> json) =>
    TimeBasedStatistics(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
    );

