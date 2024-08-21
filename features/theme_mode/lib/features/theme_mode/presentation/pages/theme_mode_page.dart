import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:theme_mode/theme_mode.dart';

import '../widgets/theme_mode_switch.dart';

final class ThemeModePage extends StatelessWidget {
  const ThemeModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: Center(
        child: BlocBuilder<ThemeModeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Theme Mode: ${themeMode.toString().split('.').last}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ThemeSwitch(),
              ],
            );
          },
        ),
      ),
    );
  }
}
