import 'package:expenses/main.dart';
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
  State<AppBarBase> createState() => _AppBarBaseState();
}

class _AppBarBaseState extends State<AppBarBase> {
  @override
  Widget build(BuildContext context) {
    var actions = <Widget>[];
    actions.addAll(widget.actions ?? []);
    actions.add(
      IconButton(
        onPressed: () {
          setState(
            () => MainWidget.themeNotifier.value =
                MainWidget.themeNotifier.value == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
          );
        },
        icon: Icon(
          MainWidget.themeNotifier.value == ThemeMode.dark
              ? Icons.light_mode
              : Icons.dark_mode,
        ),
      ),
    );
    return AppBar(
      title: Text(
        widget.centeredTitle,
      ),
      centerTitle: true,
      actions: actions,
      leading: widget.leading,
    );
  }
}
