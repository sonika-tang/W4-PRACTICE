import 'package:flutter/material.dart';
import 'package:w4_practice/2_download_app/main.dart';
import 'package:w4_practice/2_download_app/ui/screens/downloads/widgets/download_tile.dart';
import '../../providers/theme_color_provider.dart';
import '../../theme/theme.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

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
                'Downloads',
                style: AppTextStyles.heading.copyWith(color: theme.color),
              ),
              const SizedBox(height: 30),

              // TODO - Add the Download tiles
              ...downloadControllers.map(
                (controller) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: DownloadTile(controller: controller),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
