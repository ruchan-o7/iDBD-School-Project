import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

extension PaddingValuesExtension on PaddingValues {
  EdgeInsets rawVerticalValues(context) {
    switch (this) {
      case PaddingValues.min:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.05);
      case PaddingValues.medium:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.1);
      case PaddingValues.max:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.15);
      case PaddingValues.ultra:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.2);
      case PaddingValues.ultra_pro_max:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.3);
    }
  }

  EdgeInsets rawHorizontalValues(context) {
    switch (this) {
      case PaddingValues.min:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.05);
      case PaddingValues.medium:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.1);
      case PaddingValues.max:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.15);
      case PaddingValues.ultra:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.2);
      case PaddingValues.ultra_pro_max:
        return EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.3);
    }
  }

  EdgeInsets rawValues(context) {
    switch (this) {
      case PaddingValues.min:
        return EdgeInsets.all(MediaQuery.of(context).size.width * 0.05);
      case PaddingValues.medium:
        return EdgeInsets.all(MediaQuery.of(context).size.width * 0.1);
      case PaddingValues.max:
        return EdgeInsets.all(MediaQuery.of(context).size.width * 0.15);
      case PaddingValues.ultra:
        return EdgeInsets.all(MediaQuery.of(context).size.width * 0.2);
      case PaddingValues.ultra_pro_max:
        return EdgeInsets.all(MediaQuery.of(context).size.width * 0.3);
    }
  }
}
