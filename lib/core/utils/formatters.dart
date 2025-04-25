import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Classe de formatadores para campos de texto
class Formatters {
  /// Formatador para CPF
  static final cpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  /// Formatador para telefone
  static final telefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
