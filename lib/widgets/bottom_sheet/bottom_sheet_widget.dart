import 'package:expenses/widgets/general_widgets/app_bar_base.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        centeredTitle: "",
      ),
    );
  }
}
