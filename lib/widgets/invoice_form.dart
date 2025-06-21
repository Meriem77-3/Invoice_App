import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_form.dart';
import 'invoice_preview.dart';

class InvoiceForm extends StatefulWidget {
  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> with SingleTickerProviderStateMixin {
  final clientNameController = TextEditingController();
  final clientEmailController = TextEditingController();
  DateTime? selectedDate;
  List<Article> articles = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    clientNameController.dispose();
    clientEmailController.dispose();
    super.dispose();
  }

  void _addArticle() {
    setState(() {
      articles.add(Article());
    });
  }

  void _removeArticle(int index) {
    setState(() {
      articles.removeAt(index);
    });
  }

  double get totalHT => articles.fold(0, (sum, a) => sum + a.totalHT);
  double get tva => totalHT * 0.20;
  double get totalTTC => totalHT + tva;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade600,
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          /Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  icon: Icon(Icons.edit_document),
                  text: 'Saisie',
                ),
                Tab(
                  icon: Icon(Icons.preview),
                  text: 'Aperçu',
                ),
              ],
              indicatorColor: Colors.blue.shade600,
              labelColor: Colors.blue.shade600,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorWeight: 3,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFormTab(),
                _buildPreviewTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSection(
            'Client Information',
            Icons.person,
            Colors.blue,
            [
              _buildTextField(
                controller: clientNameController,
                label: 'Client name',
                icon: Icons.person_outline,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: clientEmailController,
                label: 'Client email',
                icon: Icons.email_outlined,
                color: Colors.blue,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              _buildDateField(),
            ],
          ),
          
          SizedBox(height: 24),
          
          _buildSection(
            'Articles',
            Icons.inventory_2,
            Colors.blue,
            [
              if (articles.isEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 48,
                        color: Colors.blue.shade300,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No articles added',
                        style: TextStyle(
                          color: Colors.blue.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Start by adding your first article',
                        style: TextStyle(
                          color: Colors.blue.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              
              ...articles.asMap().entries.map((entry) {
                int index = entry.key;
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ArticleForm(
                    key: ValueKey(index),
                    article: entry.value,
                    index: index + 1,
                    onRemove: () => _removeArticle(index),
                    onChanged: () => setState(() {}),
                  ),
                );
              }),
              
              SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _addArticle,
                  icon: Icon(Icons.add_circle_outline),
                  label: Text('Add article'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          _buildTotalsSection(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, Color color, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDateField() {
    return TextField(
      readOnly: true,
      controller: TextEditingController(
        text: selectedDate == null 
          ? '' 
          : '${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}',
      ),
      decoration: InputDecoration(
        labelText: 'Invoice date',
        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
        suffixIcon: IconButton(
          icon: Icon(Icons.edit_calendar, color: Colors.blue),
          onPressed: _pickDate,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: _pickDate,
    );
  }

  Widget _buildTotalsSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.calculate, color: Colors.blue.shade600, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                'Totals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildTotalRow('Total excl. tax', totalHT, Colors.blue.shade700),
          _buildTotalRow('VAT (20%)', tva, Colors.blue.shade700),
          Divider(thickness: 2, color: Colors.blue.shade200),
          _buildTotalRow('Total incl. tax', totalTTC, Colors.blue.shade900, isMain: true),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, Color color, {bool isMain = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isMain ? 18 : 16,
              fontWeight: isMain ? FontWeight.bold : FontWeight.w500,
              color: color,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(2)} DH',
            style: TextStyle(
              fontSize: isMain ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: InvoicePreview(
        clientName: clientNameController.text,
        clientEmail: clientEmailController.text,
        date: selectedDate,
        articles: articles,
        totalHT: totalHT,
        tva: tva,
        totalTTC: totalTTC,
      ),
    );
  }
}