import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import '../models/visitante_model.dart';
import '../models/porteiro_model.dart';

class RelatorioService {
  Future<void> gerarRelatorioPDF(
      List<Visitante> visitantes, Porteiro porteiro) async {
    try {
      for (final v in visitantes) {
        if (v.nome.isEmpty || v.documento.isEmpty) {
          throw Exception('Visitante com dados incompletos');
        }
      }

      debugPrint('Iniciando geração do PDF para ${porteiro.usuario}');
      final pdf = pw.Document();
      final dateFormat = DateFormat('dd/MM/yyyy');
      final timeFormat = DateFormat('HH:mm');
      final now = DateTime.now();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            pw.Header(
              level: 0,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Relatório de Visitantes',
                      style: pw.TextStyle(
                          fontSize: 24, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 10),
                  pw.Text('Porteiro: ${porteiro.usuario}'),
                  pw.Text(
                      'Data do Relatório: ${dateFormat.format(now)} ${timeFormat.format(now)}'),
                  pw.Divider(),
                ],
              ),
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: const pw.FlexColumnWidth(3), // Nome
                1: const pw.FlexColumnWidth(2), // Documento
                2: const pw.FlexColumnWidth(1), // Apartamento
                3: const pw.FlexColumnWidth(2), // Data/Hora
              },
              children: [
                // Cabeçalho da tabela
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Nome',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Documento',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Apto',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text('Data/Hora',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                // Dados dos visitantes
                ...visitantes.map((visitante) => pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(visitante.nome),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(visitante.documento),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(visitante.apartamento),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            '${dateFormat.format(visitante.dataEntrada)}\n${timeFormat.format(visitante.dataEntrada)}',
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Total de visitantes: ${visitantes.length}',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Footer(
              trailing: pw.Text(
                'Página ${context.pageNumber} de ${context.pagesCount}',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      );

      // Salvar o arquivo
      final output = await getTemporaryDirectory();
      debugPrint('Diretório temporário: ${output.path}');

      final String fileName =
          'relatorio_${porteiro.usuario}_${DateFormat('ddMMyyyyHHmm').format(now)}.pdf';
      final file = File('${output.path}/$fileName');

      debugPrint('Salvando arquivo em: ${file.path}');
      await file.writeAsBytes(await pdf.save());

      debugPrint('Arquivo salvo, tentando abrir');
      final result = await OpenFile.open(file.path);
      debugPrint('Resultado da abertura do arquivo: ${result.message}');

      if (result.type != ResultType.done) {
        throw Exception('Não foi possível abrir o arquivo: ${result.message}');
      }
    } catch (e, stackTrace) {
      debugPrint('Erro ao gerar PDF: $e');
      debugPrint('Stack trace: $stackTrace');
      throw Exception('Erro ao gerar relatório: $e');
    }
  }
}
