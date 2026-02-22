import 'package:flutter/material.dart';

import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';
import 'widget/theme_color_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeColorProvider,
      builder: (context, _) {
        final theme = themeColorProvider.current;

        return Container(
          color: theme.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                'Settings',
                style: AppTextStyles.heading.copyWith(color: theme.color),
              ),
              const SizedBox(height: 50),
              Text(
                'Theme',
                style: AppTextStyles.label.copyWith(color: AppColors.textLight),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ThemeColor.values
                    .map(
                      (t) => ThemeColorButton(
                        themeColor: t,
                        isSelected: t == theme,
                        onTap: (value) => themeColorProvider.setTheme(value),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
