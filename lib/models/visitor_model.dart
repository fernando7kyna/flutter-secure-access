class Visitor {
  final String name;
  final String cpf;
  final String phone;
  final String email;

  Visitor({
    required this.name,
    required this.cpf,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'phone': phone,
      'email': email,
    };
  }

  factory Visitor.fromMap(Map<String, dynamic> map) {
    return Visitor(
      name: map['name'] ?? '',
      cpf: map['cpf'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
