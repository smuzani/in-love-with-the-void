import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Reusable widget for displaying a stat with a progress bar
class StatDisplay extends StatelessWidget {
  final String label;
  final double value; // 0.0 to 1.0
  final Color? color;

  const StatDisplay({
    super.key,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final displayColor = color ?? colorScheme.primary;
    final percentage = (value * 100).toStringAsFixed(0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.ash,
                ),
              ),
              Text(
                '$percentage%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: displayColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value.clamp(0.0, 1.0),
              backgroundColor: AppTheme.charcoal,
              valueColor: AlwaysStoppedAnimation<Color>(displayColor),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
