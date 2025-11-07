import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/character_viewmodel.dart';
import '../../widgets/stat_display.dart';

/// Character profile screen showing detailed stats
class CharacterProfileView extends StatefulWidget {
  final String queenId;

  const CharacterProfileView({
    super.key,
    required this.queenId,
  });

  @override
  State<CharacterProfileView> createState() => _CharacterProfileViewState();
}

class _CharacterProfileViewState extends State<CharacterProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharacterViewModel>().loadQueen(widget.queenId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
      ),
      body: Consumer<CharacterViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.queen == null) {
            return Center(
              child: Text(
                'Queen not found',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.ash,
                ),
              ),
            );
          }

          final queen = viewModel.queen!;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.jetBlack,
                  AppTheme.driedCrimson.withValues(alpha: 0.15),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Center(
                    child: Text(
                      queen.name,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Traits
                  Center(
                    child: Text(
                      viewModel.traitsText,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.iron,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Appearance
                  _buildSection(
                    'Appearance',
                    queen.appearance,
                  ),
                  const SizedBox(height: 20),

                  // Description
                  _buildSection(
                    'About',
                    queen.description,
                  ),
                  const SizedBox(height: 24),

                  // Stats
                  _buildSectionTitle('Stats'),
                  const SizedBox(height: 12),
                  StatDisplay(
                    label: 'Mood',
                    value: queen.stats.mood,
                    color: _getMoodColor(queen.stats.mood),
                  ),
                  StatDisplay(
                    label: 'Sanity',
                    value: queen.stats.sanity,
                    color: queen.stats.isDangerouslyLowSanity
                        ? Colors.red
                        : Colors.blue,
                  ),
                  StatDisplay(
                    label: 'Friendship',
                    value: queen.stats.friendship,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 24),

                  // Skills
                  _buildSectionTitle('Skills'),
                  const SizedBox(height: 12),
                  StatDisplay(
                      label: 'Gravitas', value: queen.skills.gravitas),
                  StatDisplay(
                      label: 'Aestheticism', value: queen.skills.aestheticism),
                  StatDisplay(label: 'Alchemy', value: queen.skills.alchemy),
                  StatDisplay(label: 'Charisma', value: queen.skills.charisma),
                  StatDisplay(label: 'Occult', value: queen.skills.occult),
                  StatDisplay(label: 'Combat', value: queen.skills.combat),
                  StatDisplay(label: 'Tech', value: queen.skills.tech),
                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      'Dominant Skill: ${viewModel.dominantSkill}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Needs
                  _buildSectionTitle('Needs'),
                  const SizedBox(height: 12),
                  StatDisplay(label: 'Alignment', value: queen.needs.alignment),
                  StatDisplay(
                      label: 'Intellectual', value: queen.needs.intellectual),
                  StatDisplay(label: 'Solitude', value: queen.needs.solitude),
                  StatDisplay(label: 'Social', value: queen.needs.social),
                  StatDisplay(label: 'Aesthetic', value: queen.needs.aesthetic),
                  StatDisplay(
                      label: 'Validation', value: queen.needs.validation),
                  StatDisplay(label: 'Caffeine', value: queen.needs.caffeine),
                  StatDisplay(label: 'Alcohol', value: queen.needs.alcohol),
                  StatDisplay(label: 'Nicotine', value: queen.needs.nicotine),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 8),
        Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.boneWhite,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        color: colorScheme.primary,
      ),
    );
  }

  Color _getMoodColor(double mood) {
    if (mood > 0.6) return Colors.green;
    if (mood > 0.4) return Colors.yellow;
    return Colors.orange;
  }
}
