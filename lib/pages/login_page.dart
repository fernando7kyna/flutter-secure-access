import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'cadastro_visitante_page.dart';
import 'cadastro_porteiro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  bool _obscureText = true;
  String? _errorMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              const Color(0xFF0A2E1A),
              Colors.green.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.withAlpha(30),
                                border: Border.all(
                                  color: Colors.green.withAlpha(100),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withAlpha(60),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.green.withAlpha(150),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.security,
                                    size: 80,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            const Text(
                              'Sistema de Segurança',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Acesso Restrito',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green.shade300,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(77),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.green.withAlpha(50),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withAlpha(15),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _usuarioController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Usuário',
                                labelStyle:
                                    TextStyle(color: Colors.green.shade300),
                                prefixIcon: Icon(Icons.person_outline,
                                    color: Colors.green.shade300),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.green.shade900),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.black.withAlpha(51),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu usuário';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _senhaController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle:
                                    TextStyle(color: Colors.green.shade300),
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.green.shade300),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.green.shade300,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.green.shade900),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.black.withAlpha(51),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                shadowColor: Colors.green.withAlpha(102),
                              ),
                              onPressed: _isLoading ? null : _handleLogin,
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'ACESSAR',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CadastroPorteiroPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Não tem uma conta? Cadastre-se',
                              style: TextStyle(
                                color: Colors.green.shade300,
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final porteiro = await _authService.login(
          _usuarioController.text,
          _senhaController.text,
        );

        if (porteiro != null && mounted) {
          debugPrint('Porteiro logado: ${porteiro.usuario}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroVisitantePage(porteiro: porteiro),
            ),
          );
        } else {
          if (mounted) {
            setState(() {
              _errorMessage = 'Usuário ou senha inválidos';
            });
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = 'Erro ao fazer login: ${e.toString()}';
          });
          debugPrint('Erro no login: $e');
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
}
