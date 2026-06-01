import 'package:flutter/services.dart';
import 'package:hedma/app/utils/egyptian_phone_util.dart';

abstract final class AppInputFormatters {
  static final List<TextInputFormatter> decimal = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
  ];

  static final List<TextInputFormatter> phone = EgyptianPhoneUtil.inputFormatters;
}
