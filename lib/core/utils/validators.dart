/// Classe de validadores para formulários
class Validators {
  /// Valida se um campo está vazio
  static String? campoObrigatorio(String? value, String campo) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira $campo';
    }
    return null;
  }

  /// Valida se um CPF é válido
  static String? cpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o CPF';
    }
    if (value.length != 14) {
      return 'CPF inválido';
    }
    return null;
  }

  /// Valida se um telefone é válido
  static String? telefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o telefone';
    }
    if (value.length != 15) {
      return 'Telefone inválido';
    }
    return null;
  }

  /// Valida se uma senha tem o tamanho mínimo
  static String? senha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  /// Valida se as senhas são iguais
  static String? confirmarSenha(String? value, String senha) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme a senha';
    }
    if (value != senha) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
