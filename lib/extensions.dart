import 'package:flutter/widgets.dart';

extension TextValidation on TextEditingController {
  bool isWhitespace(){
    return text.isEmpty || text.trim().isEmpty;
  }
}
