import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.purple.shade200,
        title: Consumer<GameViewModel>(
          builder: (context, viewModel, child) {
            return Text(
              viewModel.currentLocation?.name ?? 'Unknown Location',
              style: const TextStyle(letterSpacing: 2),
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
                  Colors.black,
                  Colors.purple.shade900.withOpacity(0.2),
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
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.purple.shade900.withOpacity(0.5),
                      ),
                    ),
                    child: viewModel.storyText.isEmpty
                        ? Center(
                            child: viewModel.isBusy
                                ? const CircularProgressIndicator(
                                    color: Colors.purple,
                                  )
                                : Text(
                                    'The void awaits...',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
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
                                  style: TextStyle(
                                    color: isPlayerInput
                                        ? Colors.purple.shade300
                                        : Colors.grey.shade300,
                                    fontSize: 15,
                                    height: 1.6,
                                    fontWeight: isPlayerInput
                                        ? FontWeight.bold
                                        : FontWeight.normal,
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
                    color: Colors.grey.shade900,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.shade900.withOpacity(0.3),
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
                            style: TextStyle(color: Colors.grey.shade200),
                            decoration: InputDecoration(
                              hintText: 'What do you do?',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                              ),
                              filled: true,
                              fillColor: Colors.black,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.purple.shade900,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.purple.shade900,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.purple.shade400,
                                  width: 2,
                                ),
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
                                ? Colors.grey.shade700
                                : Colors.purple.shade300,
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
