import 'package:flutter/material.dart';
import '../models/porteiro_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CadastroPorteiroPage extends StatefulWidget {
  const CadastroPorteiroPage({super.key});

  @override
  State<CadastroPorteiroPage> createState() => _CadastroPorteiroPageState();
}

class _CadastroPorteiroPageState extends State<CadastroPorteiroPage> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  Future<void> _cadastrarPorteiro() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final porteiro = Porteiro(
          usuario: _usuarioController.text,
          senha: _senhaController.text,
        );

        final prefs = await SharedPreferences.getInstance();
        final porteiros = prefs.getStringList('porteiros') ?? [];
        porteiros.add(jsonEncode(porteiro.toMap()));
        await prefs.setStringList('porteiros', porteiros);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Porteiro cadastrado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Porteiro'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF1B5E20)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usuarioController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Usuário',
                    labelStyle: TextStyle(color: Colors.green),
                    prefixIcon: Icon(Icons.person, color: Colors.green),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o usuário';
                    }
                    if (value.length < 4) {
                      return 'O usuário deve ter pelo menos 4 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  obscureText: _obscureText,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Colors.green),
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmarSenhaController,
                  obscureText: _obscureConfirmText,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    labelStyle: const TextStyle(color: Colors.green),
                    prefixIcon: const Icon(Icons.lock, color: Colors.green),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmText = !_obscureConfirmText;
                        });
                      },
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme a senha';
                    }
                    if (value != _senhaController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: _isLoading ? null : _cadastrarPorteiro,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Cadastrar',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }
}
