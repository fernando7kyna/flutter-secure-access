class Porteiro {
  final String usuario;
  final String senha;

  Porteiro({
    required this.usuario,
    required this.senha,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'senha': senha,
    };
  }

  factory Porteiro.fromMap(Map<String, dynamic> map) {
    return Porteiro(
      usuario: map['usuario'] ?? '',
      senha: map['senha'] ?? '',
    );
  }
}
