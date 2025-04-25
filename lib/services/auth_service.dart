import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import '../models/porteiro_model.dart';

class AuthService {
  final _logger = Logger();
  bool isAuthenticated = false;

  Future<Porteiro?> login(String usuario, String senha) async {
    try {
      // Simula um delay de rede
      await Future.delayed(const Duration(seconds: 1));

      // Primeiro verifica as credenciais padrão
      if (usuario == 'admin' && senha == '123456') {
        return Porteiro(usuario: usuario, senha: senha);
      }

      // Se não for as credenciais padrão, verifica os porteiros cadastrados
      final prefs = await SharedPreferences.getInstance();
      final porteirosJson = prefs.getStringList('porteiros') ?? [];

      if (porteirosJson.isEmpty) {
        return null;
      }

      final porteiros = porteirosJson
          .map((json) => Porteiro.fromMap(jsonDecode(json)))
          .toList();

      final porteiro = porteiros.firstWhere(
        (porteiro) => porteiro.usuario == usuario && porteiro.senha == senha,
        orElse: () => Porteiro(usuario: '', senha: ''),
      );

      return porteiro.usuario.isEmpty ? null : porteiro;
    } catch (e) {
      _logger.e('Erro no login', error: e);
      return null;
    }
  }

  void logout() {
    isAuthenticated = false;
  }
}
