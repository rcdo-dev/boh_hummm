import 'package:boh_hummm/utils/result.dart';

/// ### Extensions
///
/// As extensões em Dart permitem adicionar métodos ou getters a uma classe já
/// existente sem precisar modificá-la diretamente. Isso é útil para melhorar a
/// usabilidade de uma classe.
///
extension ResultCast<T> on Result<T> {
  /// ### Explicando o Casting
  ///
  /// A classe Result<T> é a superclasse abstrata (ou selada), enquanto Ok<T>
  /// e Error<T> são subclasses específicas. Quando fazemos o casting, estamos
  /// dizendo: "Eu sei que essa instância de Result<T> é na verdade um Ok<T>
  /// (ou Error<T>), então me deixe acessá-la como tal."
  ///
  /// #### Detalhando
  /// * A palavra this representa a instância atual de Result<T>.
  ///
  /// * O operador as está "informando" ao Dart para tratar a instância como
  /// do tipo Ok<T>. Isso não altera a instância, apenas permite que o
  /// compilador saiba que você deseja acessá-la como sendo do tipo Ok<T>.
  Ok<T> get asOk => this as Ok<T>;

  Error<T> get asError => this as Error<T>;
}
