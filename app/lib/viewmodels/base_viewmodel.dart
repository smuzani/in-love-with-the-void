import 'package:flutter/foundation.dart';

/// Base ViewModel class for MVVM pattern
///
/// Extends ChangeNotifier to work with Provider for state management.
/// All ViewModels should extend this class.
abstract class BaseViewModel extends ChangeNotifier {
  bool _disposed = false;
  bool _busy = false;
  String? _errorMessage;

  /// Indicates if the ViewModel is currently performing an operation
  bool get isBusy => _busy;

  /// Error message from the last failed operation
  String? get errorMessage => _errorMessage;

  /// Check if there's an error
  bool get hasError => _errorMessage != null;

  /// Set busy state and notify listeners
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  /// Set error message and notify listeners
  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Execute an async operation with busy state management
  Future<T?> runBusyFuture<T>(Future<T> Function() operation) async {
    try {
      setBusy(true);
      clearError();
      final result = await operation();
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
