import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;
  // TODO
  /// Icon that show current status
  Widget _statusIcon(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.notDownloaded:
        return const Icon(Icons.download, size: 32);
      case DownloadStatus.downloading:
        return const Icon(Icons.downloading, size: 32);
      case DownloadStatus.downloaded:
        return const Icon(Icons.folder, size: 32);
    }
  }

  /// Subtitle in the tile
  String? _subtitle(DownloadStatus status, double progress, int sizeMB) {
    if (status == DownloadStatus.notDownloaded) return null;
    final pct = (progress * 100).toStringAsFixed(1);
    final done = (progress * sizeMB).toStringAsFixed(1);
    return '$pct % complete - $done of $sizeMB MB';
  }

  @override
  Widget build(BuildContext context) {
    // Q1: ListenableBuilder – only this tile rebuilds when its controller fires
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final status = controller.status;
        final progress = controller.progress;
        final subtitle = _subtitle(status, progress, controller.ressource.size);

        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            // Resource name
            title: Text(
              controller.ressource.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            // Progress subtitle (hidden when notDownloaded)
            subtitle: subtitle != null
                ? Text(subtitle, style: const TextStyle(fontSize: 13))
                : null,
            // Status icon / action button
            trailing: GestureDetector(
              // ACTION: tap starts the download (guarded inside controller)
              onTap: () => controller.startDownload(),
              child: _statusIcon(status),
            ),
          ),
        );
      },
    );
  }
}
