/// ## Padrão Result
///
/// O padrão Result é usado para encapsular o resultado de uma operação que
/// pode:
///    * Ser bem-sucedida e conter um valor (ex.: um dado retornado de um
///     serviço).
///
///    * Falhar e conter um erro (ex.: uma exceção ou mensagem de erro).
///
/// Esse padrão é comumente usado para substituir exceções como forma de lidar
/// com falhas, tornando o fluxo do código mais explícito e fácil de testar.
///
/// ### Sealed
///
/// O modificador sealed em Dart é usado para criar uma classe selada, ou seja,
/// uma classe que não pode ser estendida fora do arquivo onde foi declarada.
sealed class Result<T> {
  /// ### Construtor constante
  ///
  /// Um construtor constante é um construtor que permite criar instâncias
  /// constantes de uma classe.
  ///
  /// Essas instâncias são criadas em tempo de
  /// compilação e armazenadas de forma que, se houver múltiplas referências
  /// ao mesmo objeto constante, apenas uma instância será usada
  /// (compartilhada).
  const Result();

  /// ### Redirecionamento e Expressão
  ///
  /// Redirecionamento com =:
  ///   * É usado em métodos de fábrica para redirecionar diretamente para o
  ///     construtor de outra classe. Não permite lógica adicional.
  ///
  /// Expressão com =>:
  ///   * É usada quando você precisa adicionar lógica extra antes de chamar o
  ///     construtor.
  const factory Result.ok(T value) = Ok._;

  const factory Result.error(Exception error, [StackTrace stackTrace]) =
      Error._;
}

final class Ok<T> extends Result<T> {
  final T value;

  /// ### Construtores nomeados privados
  ///
  /// Construtores nomeados em Dart são uma forma de criar múltiplos
  /// construtores em uma mesma classe, cada um com um propósito específico.
  const Ok._(this.value);

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Error<T> extends Result<T> {
  final Exception error;
  final StackTrace? stackTrace;

  const Error._(this.error, [this.stackTrace]);

  @override
  String toString() => 'Result<$T>.error($error, $stackTrace)';
}
