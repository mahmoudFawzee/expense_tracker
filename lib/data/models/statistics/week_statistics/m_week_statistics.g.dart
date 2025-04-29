// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_week_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekStatisticsModel _$WeekStatisticsModelFromJson(Map<String, dynamic> json) =>
    WeekStatisticsModel(
      (json['totalSpent'] as num).toDouble(),
      (json['days'] as List<dynamic>)
          .map((e) => StatisticsDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeekStatisticsModelToJson(
        WeekStatisticsModel instance) =>
    <String, dynamic>{
      'days': instance.days,
      'totalSpent': instance.totalSpent,
    };
