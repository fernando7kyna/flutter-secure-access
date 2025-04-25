import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../models/visitor_model.dart';

class VisitorDialog extends StatefulWidget {
  final Visitor? visitor;
  final Function(Visitor) onSubmit;

  const VisitorDialog({super.key, this.visitor, required this.onSubmit});

  @override
  State<VisitorDialog> createState() => _VisitorDialogState();
}

class _VisitorDialogState extends State<VisitorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _documentoController = TextEditingController();
  final _apartamentoController = TextEditingController();

  final _cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    if (widget.visitor != null) {
      _nomeController.text = widget.visitor!.name;
      _documentoController.text = widget.visitor!.cpf;
      _apartamentoController.text = widget.visitor!.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.visitor == null ? 'Novo Visitante' : 'Editar Visitante',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _documentoController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  icon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [_cpfMask],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apartamentoController,
                decoration: const InputDecoration(
                  labelText: 'Apartamento',
                  icon: Icon(Icons.apartment),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o apartamento';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final visitor = Visitor(
                name: _nomeController.text,
                cpf: _documentoController.text,
                phone: _apartamentoController.text,
                email: '',
              );
              widget.onSubmit(visitor);
              Navigator.pop(context);
            }
          },
          child: const Text('Salvar'),
        ),
      ],
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
