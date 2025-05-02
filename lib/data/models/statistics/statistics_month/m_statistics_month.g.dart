// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_statistics_month.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsMonthModel _$StatisticsMonthModelFromJson(
        Map<String, dynamic> json) =>
    StatisticsMonthModel(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
    );
