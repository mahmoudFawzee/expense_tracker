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
      monthName: json['monthName'] as String,
    );

Map<String, dynamic> _$StatisticsMonthModelToJson(
        StatisticsMonthModel instance) =>
    <String, dynamic>{
      'monthName': instance.monthName,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
    };
