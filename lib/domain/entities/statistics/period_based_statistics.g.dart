// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_based_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodBasedStatistics _$PeriodBasedStatisticsFromJson(
        Map<String, dynamic> json) =>
    PeriodBasedStatistics(
      totalSpent: (json['totalSpent'] as num).toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((e) => TimeBasedStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxValue: (json['maxValue'] as num).toDouble(),
    );
