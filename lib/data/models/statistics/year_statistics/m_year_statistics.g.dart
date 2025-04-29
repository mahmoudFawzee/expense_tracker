// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_year_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearStatisticsModel _$YearStatisticsModelFromJson(Map<String, dynamic> json) =>
    YearStatisticsModel(
      (json['totalSpent'] as num).toDouble(),
      (json['months'] as List<dynamic>)
          .map((e) => StatisticsMonthModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YearStatisticsModelToJson(
        YearStatisticsModel instance) =>
    <String, dynamic>{
      'months': instance.months,
      'totalSpent': instance.totalSpent,
    };
