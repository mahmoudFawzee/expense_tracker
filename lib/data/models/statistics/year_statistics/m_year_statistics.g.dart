// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_year_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearStatisticsModel _$YearStatisticsModelFromJson(Map<String, dynamic> json) =>
    YearStatisticsModel(
      totalSpent: (json['totalSpent'] as num).toDouble(),
      items: (json['items'] as List<dynamic>)
          .map((e) => TimeBasedStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
      maxValue: (json['maxValue'] as num).toDouble(),
    );
