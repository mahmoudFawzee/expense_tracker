// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_week_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekStatisticsModel _$WeekStatisticsModelFromJson(Map<String, dynamic> json) =>
    WeekStatisticsModel(
      totalSpent: (json['totalSpent'] as num).toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((e) => TimeBasedStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxValue: (json['maxValue'] as num).toDouble(),
    );

