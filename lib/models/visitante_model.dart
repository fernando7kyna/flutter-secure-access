class Visitante {
  final String nome;
  final String documento;
  final String apartamento;
  final DateTime dataEntrada;

  Visitante({
    required this.nome,
    required this.documento,
    required this.apartamento,
    required this.dataEntrada,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'documento': documento,
      'apartamento': apartamento,
      'dataEntrada': dataEntrada.toIso8601String(),
    };
  }

  factory Visitante.fromMap(Map<String, dynamic> map) {
    return Visitante(
      nome: map['nome'] ?? '',
      documento: map['documento'] ?? '',
      apartamento: map['apartamento'] ?? '',
      dataEntrada: DateTime.parse(map['dataEntrada']),
    );
  }
}
