import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/game_viewmodel.dart';
import '../character/character_profile_view.dart';

/// Main game screen with VN-style interface
class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameViewModel>().initialize();
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<GameViewModel>(
          builder: (context, viewModel, child) {
            return Text(
              viewModel.currentLocation?.name ?? 'Unknown Location',
            );
          },
        ),
        actions: [
          Consumer<GameViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.currentQueen != null) {
                return IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterProfileView(
                          queenId: viewModel.currentQueen!.id,
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<GameViewModel>(
        builder: (context, viewModel, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

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
            child: Column(
              children: [
                // Story text area (VN style)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.jetBlack.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.graphite,
                      ),
                    ),
                    child: viewModel.storyText.isEmpty
                        ? Center(
                            child: viewModel.isBusy
                                ? const CircularProgressIndicator()
                                : Text(
                                    'The void awaits...',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.iron,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: viewModel.storyText.length,
                            itemBuilder: (context, index) {
                              final text = viewModel.storyText[index];
                              final isPlayerInput = text.startsWith('>');

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  text,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: isPlayerInput
                                        ? colorScheme.primary
                                        : AppTheme.boneWhite,
                                    height: 1.6,
                                    fontWeight: isPlayerInput
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),

                // Input area
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.charcoal,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.jetBlack.withValues(alpha: 0.5),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _inputController,
                            style: theme.textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'What do you do?',
                              hintStyle: TextStyle(
                                color: AppTheme.iron,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            onSubmitted: (_) => _submitInput(viewModel),
                            enabled: !viewModel.isBusy,
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: viewModel.isBusy
                              ? null
                              : () => _submitInput(viewModel),
                          icon: Icon(
                            Icons.send,
                            color: viewModel.isBusy
                                ? AppTheme.iron
                                : colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitInput(GameViewModel viewModel) {
    if (_inputController.text.trim().isEmpty) return;

    viewModel.updatePlayerInput(_inputController.text);
    _inputController.clear();
    viewModel.processPlayerInput();
  }
}
