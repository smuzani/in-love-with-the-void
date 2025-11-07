import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Service for interacting with Claude API
class ClaudeService {
  static const String _baseUrl = 'https://api.anthropic.com/v1/messages';
  static const String _apiVersion = '2023-06-01';
  static const String _model = 'claude-haiku-4-5';

  final String _apiKey;

  ClaudeService() : _apiKey = dotenv.env['ANTHROPIC_API_KEY'] ?? '';

  /// Send a message to Claude and get a response
  ///
  /// [userMessage] - The user's input
  /// [systemPrompt] - Optional system prompt for context
  /// [conversationHistory] - Previous messages for context
  Future<String> sendMessage({
    required String userMessage,
    String? systemPrompt,
    List<Map<String, String>>? conversationHistory,
  }) async {
    if (_apiKey.isEmpty) {
      throw Exception('ANTHROPIC_API_KEY not found in environment');
    }

    // Build messages array
    final messages = <Map<String, String>>[];

    // Add conversation history if provided
    if (conversationHistory != null) {
      messages.addAll(conversationHistory);
    }

    // Add current user message
    messages.add({'role': 'user', 'content': userMessage});

    // Build request body
    final body = {'model': _model, 'max_tokens': 1024, 'messages': messages};

    // Add system prompt if provided
    if (systemPrompt != null && systemPrompt.isNotEmpty) {
      body['system'] = systemPrompt;
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'x-api-key': _apiKey,
          'anthropic-version': _apiVersion,
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract text from the response
        if (data['content'] != null && data['content'].isNotEmpty) {
          return data['content'][0]['text'] as String;
        }

        throw Exception('No content in response');
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          'Claude API error: ${response.statusCode} - ${error['error']?['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      throw Exception('Failed to communicate with Claude: $e');
    }
  }
}
