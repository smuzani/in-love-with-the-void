import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.purple.shade200,
        title: const Text(
          'PROFILE',
          style: TextStyle(letterSpacing: 2),
        ),
      ),
      body: Consumer<CharacterViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isBusy) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          }

          if (viewModel.queen == null) {
            return Center(
              child: Text(
                'Queen not found',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
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
                  Colors.black,
                  Colors.purple.shade900.withOpacity(0.2),
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
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade200,
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
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
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
                      style: TextStyle(
                        color: Colors.purple.shade300,
                        fontSize: 12,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.purple.shade400,
        letterSpacing: 2,
      ),
    );
  }

  Color _getMoodColor(double mood) {
    if (mood > 0.6) return Colors.green;
    if (mood > 0.4) return Colors.yellow;
    return Colors.orange;
  }
}
