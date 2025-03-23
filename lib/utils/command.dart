import 'package:boh_hummm/utils/result.dart';
import 'package:flutter/foundation.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

abstract class Command<T> extends ChangeNotifier {
  // ignore: prefer_final_fields
  bool _running = false;

  Result<T>? _result;

  /// Verdadeiro quando a ação está em execução.
  bool get running => _running;

  /// Verdadeiro se a ação completar com erro.
  bool get error => _result is Error;

  /// Verdadeiro se a ação completar com sucesso.
  bool get completed => _result is Ok;

  /// Obtem o último resultado da ação.
  Result? get result => _result;

  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    /// Garante que a ação não seja iniciada várias vezes.
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command] sem argumento.
class Command0<T> extends Command<T> {
  final CommandAction0<T> _action;

  Command0(this._action);

  /// Executa a ação.
  Future<void> execute() async {
    await _execute(_action);
  }
}

/// [Command] com argumento.
class Command1<T, A> extends Command<T> {
  final CommandAction1<T, A> _action;

  Command1(this._action);

  /// Executa a ação com argumento.
  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
