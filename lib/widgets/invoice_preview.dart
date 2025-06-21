import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:intl/intl.dart';

class InvoicePreview extends StatelessWidget {
  final String clientName;
  final String clientEmail;
  final DateTime? date;
  final List<Article> articles;
  final double totalHT;
  final double tva;
  final double totalTTC;

  const InvoicePreview({
    required this.clientName,
    required this.clientEmail,
    required this.date,
    required this.articles,
    required this.totalHT,
    required this.tva,
    required this.totalTTC,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Facture
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade900],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.receipt_long, color: Colors.white, size: 32),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INVOICE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'N° ${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Informations Client
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BILL TO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  clientName.isEmpty ? 'Client name not provided' : clientName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: clientName.isEmpty ? Colors.grey : Colors.blue.shade900,
                  ),
                ),
                if (clientEmail.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    clientEmail,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade400,
                    ),
                  ),
                ],
                SizedBox(height: 8),
                Text(
                  'Date: 	${date != null ? "${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}" : "Not selected"}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade400,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Tableau des articles
          Text(
            'DETAILS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue.shade700,
              letterSpacing: 1,
            ),
          ),
          
          SizedBox(height: 12),
          
          articles.isEmpty
              ? Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No articles',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                    },
                    border: TableBorder.symmetric(inside: BorderSide(color: Colors.grey, width: 0.2)),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.blue.shade50),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Unit price', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ...articles.map((a) => TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(a.description),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(a.quantity.toString()),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(a.unitPrice.toStringAsFixed(2)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text((a.quantity * a.unitPrice).toStringAsFixed(2)),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
          SizedBox(height: 24),
          // Totaux
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Total excl. tax: 	${totalHT.toStringAsFixed(2)} DH', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue.shade900)),
                  Text('VAT (20%): 	${tva.toStringAsFixed(2)} DH', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue.shade900)),
                  Text('Total incl. tax: 	${totalTTC.toStringAsFixed(2)} DH', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900, fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
