import 'package:flutter/material.dart';
import '../models/visitante_model.dart';
import '../models/porteiro_model.dart';
import '../services/relatorio_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'login_page.dart';

class CadastroVisitantePage extends StatefulWidget {
  final Porteiro porteiro;

  const CadastroVisitantePage({
    super.key,
    required this.porteiro,
  });

  @override
  State<CadastroVisitantePage> createState() => _CadastroVisitantePageState();
}

class _CadastroVisitantePageState extends State<CadastroVisitantePage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _apartamentoController = TextEditingController();
  final _relatorioService = RelatorioService();
  List<Visitante> _visitantes = [];
  bool _isLoading = false;
  bool _isGeneratingPdf = false;

  @override
  void initState() {
    super.initState();
    _carregarVisitantes();
    debugPrint(
        'Porteiro na página de cadastro: ${widget.porteiro.usuario}'); // Debug log
  }

  Future<void> _carregarVisitantes() async {
    final prefs = await SharedPreferences.getInstance();
    final visitantesJson = prefs.getStringList('visitantes') ?? [];
    setState(() {
      _visitantes = visitantesJson
          .map((json) => Visitante.fromMap(jsonDecode(json)))
          .toList();
    });
  }

  Future<void> _salvarVisitante() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final visitante = Visitante(
          nome: _nomeController.text,
          documento: _documentoController.text,
          apartamento: _apartamentoController.text,
          dataEntrada: DateTime.now(),
        );

        _visitantes.add(visitante);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(
          'visitantes',
          _visitantes.map((v) => jsonEncode(v.toMap())).toList(),
        );

        _nomeController.clear();
        _documentoController.clear();
        _apartamentoController.clear();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Visitante cadastrado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
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

  Future<void> _gerarRelatorio() async {
    if (_visitantes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não há visitantes para gerar relatório'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      debugPrint(
          'Gerando relatório para porteiro: ${widget.porteiro.usuario}'); // Debug log
      await _relatorioService.gerarRelatorioPDF(
        _visitantes,
        widget.porteiro,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Relatório gerado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao gerar relatório: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint('Erro ao gerar relatório: $e'); // Debug log
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Visitante'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: _isGeneratingPdf
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.picture_as_pdf),
            onPressed: _isGeneratingPdf ? null : _gerarRelatorio,
            tooltip: 'Gerar Relatório',
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xE61B5E20),
            ],
            stops: [0.2, 0.9],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nomeController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Nome do Visitante',
                            labelStyle: const TextStyle(color: Colors.green),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2),
                            ),
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o nome do visitante';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _documentoController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Documento (RG/CPF)',
                            labelStyle: const TextStyle(color: Colors.green),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2),
                            ),
                            prefixIcon:
                                const Icon(Icons.badge, color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o documento';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _apartamentoController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Apartamento',
                            labelStyle: const TextStyle(color: Colors.green),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2),
                            ),
                            prefixIcon: const Icon(Icons.apartment,
                                color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o apartamento';
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                            ),
                            onPressed: _isLoading ? null : _salvarVisitante,
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Cadastrar Visitante',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Card(
                    elevation: 8,
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _visitantes.length,
                      itemBuilder: (context, index) {
                        final visitante = _visitantes[index];
                        return Card(
                          color: Colors.green.withAlpha(50),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              visitante.nome,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Apartamento: ${visitante.apartamento} - Doc: ${visitante.documento}',
                              style: TextStyle(
                                color: Colors.green.shade300,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Data: ${visitante.dataEntrada.day}/${visitante.dataEntrada.month}/${visitante.dataEntrada.year}',
                                  style: TextStyle(
                                    color: Colors.green.shade300,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Hora: ${visitante.dataEntrada.hour.toString().padLeft(2, '0')}:${visitante.dataEntrada.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: Colors.green.shade300,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
    _nomeController.dispose();
    _documentoController.dispose();
    _apartamentoController.dispose();
    super.dispose();
  }
}
