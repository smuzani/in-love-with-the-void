import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../game/game_view.dart';

/// Home screen - Entry point to the game
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isBusy) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.jetBlack,
                  AppTheme.driedCrimson.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Title
                  Text(
                    'IN LOVE WITH\nTHE VOID',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A Goth Dating Simulator',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.ash,
                    ),
                  ),
                  const SizedBox(height: 80),
                  // Start button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 20,
                        ),
                        minimumSize: const Size(double.infinity, 0),
                      ),
                      child: const Text(
                        'ENTER THE VOID',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Locations preview
                  if (viewModel.locations.isNotEmpty) ...[
                    const SizedBox(height: 40),
                    Text(
                      'NOCTURNE SQUARE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.iron,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: viewModel.locations.length,
                        itemBuilder: (context, index) {
                          final location = viewModel.locations[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.coalBlack,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppTheme.graphite,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.name,
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    location.description,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: AppTheme.ash,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
