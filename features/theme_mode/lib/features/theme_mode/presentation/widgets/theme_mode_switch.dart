import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:theme_mode/theme_mode.dart';

final class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          title: Text('System'),
          value: ThemeMode.system,
          groupValue: context.watch<ThemeModeCubit>().state,
          onChanged: (ThemeMode? value) {
            context.read<ThemeModeCubit>().updateThemeMode(value!);
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text('Light'),
          value: ThemeMode.light,
          groupValue: context.watch<ThemeModeCubit>().state,
          onChanged: (ThemeMode? value) {
            context.read<ThemeModeCubit>().updateThemeMode(value!);
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text('Dark'),
          value: ThemeMode.dark,
          groupValue: context.watch<ThemeModeCubit>().state,
          onChanged: (ThemeMode? value) {
            context.read<ThemeModeCubit>().updateThemeMode(value!);
          },
        ),
      ],
    );
  }
}
