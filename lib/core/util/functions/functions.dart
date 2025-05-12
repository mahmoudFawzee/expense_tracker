import 'dart:developer';

import 'package:expense_tracker/core/util/maps/maps.dart';
import 'package:flutter/material.dart';

String handleCardDate(DateTime date) {
  return '${date.day}/${monthsName[date.month]}';
}

double handleDxOffset(BuildContext context, double dx) {
  final width = MediaQuery.of(context).size.width;
  //?why 70 we left 20 for global padding and 10 left margin
  //?and 10 container left padding and we add 10 because of
  //?the width of the bar ?we want the card exactly above
  //?the bar.
  //?but if we are in the first item then we don't need to
  //?make the card in the middle of the bar because its half
  //?won't be visible.
  log('dx is: $dx and with: $width');
  if (dx > width - 50) return dx - 90;
  if (dx > 50) {
    return dx - 70;
  }
  return dx - 50;
}


