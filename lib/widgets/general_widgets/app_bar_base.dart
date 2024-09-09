import 'package:flutter/material.dart';

class AppBarBase extends AppBar {
  final String centeredTitle;

  AppBarBase({
    required this.centeredTitle,
    super.actions,
    super.leading,
    super.key,
  });

  @override
  State<AppBarBase> createState() => _MedicalAppBarState();
}

class _MedicalAppBarState extends State<AppBarBase> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.centeredTitle,
      ),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      actions: widget.actions,
      leading: widget.leading,
    );
  }
}
