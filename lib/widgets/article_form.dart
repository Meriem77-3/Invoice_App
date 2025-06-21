import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleForm extends StatefulWidget {
  final Article article;
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  const ArticleForm({
    Key? key,
    required this.article,
    required this.index,
    required this.onRemove,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ArticleFormState createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  late TextEditingController _descController;
  late TextEditingController _qtyController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(text: widget.article.description);
    _qtyController = TextEditingController(text: widget.article.quantity.toString());
    _priceController = TextEditingController(text: widget.article.unitPrice.toStringAsFixed(2));
  }

  @override
  void dispose() {
    _descController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _updateQuantity(int change) {
    int newQuantity = widget.article.quantity + change;
    if (newQuantity >= 1) {
      setState(() {
        widget.article.quantity = newQuantity;
        _qtyController.text = newQuantity.toString();
        widget.onChanged();
      });
    }
  }

  void _updatePrice(double change) {
    double newPrice = widget.article.unitPrice + change;
    if (newPrice >= 0) {
      setState(() {
        widget.article.unitPrice = newPrice;
        _priceController.text = newPrice.toStringAsFixed(2);
        widget.onChanged();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with article number
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Article ${widget.index}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.onRemove,
                icon: Icon(Icons.delete_outline),
                color: Colors.blue.shade400,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue.shade50,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Description
          TextField(
            controller: _descController,
            decoration: InputDecoration(
              labelText: 'Description',
              prefixIcon: Icon(Icons.description_outlined, color: Colors.blue.shade600),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              widget.article.description = value;
              widget.onChanged();
            },
          ),
          
          SizedBox(height: 16),
          
          // Quantity and Price
          Row(
            children: [
              // Quantity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantité',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _updateQuantity(-1),
                            icon: Icon(Icons.remove_circle_outline),
                            color: Colors.blue.shade400,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _qtyController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                              ),
                              onChanged: (value) {
                                int? newQuantity = int.tryParse(value);
                                if (newQuantity != null && newQuantity > 0) {
                                  widget.article.quantity = newQuantity;
                                  widget.onChanged();
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () => _updateQuantity(1),
                            icon: Icon(Icons.add_circle_outline),
                            color: Colors.blue.shade400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 16),
              
              // Price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prix unitaire (DH)',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _updatePrice(-0.5),
                            icon: Icon(Icons.remove_circle_outline),
                            color: Colors.blue.shade400,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _priceController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                              ),
                              onChanged: (value) {
                                double? newPrice = double.tryParse(value);
                                if (newPrice != null && newPrice >= 0) {
                                  widget.article.unitPrice = newPrice;
                                  widget.onChanged();
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () => _updatePrice(0.5),
                            icon: Icon(Icons.add_circle_outline),
                            color: Colors.blue.shade400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Total
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.blue.shade100],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total excl. tax',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                Text(
                  '${widget.article.totalHT.toStringAsFixed(2)} DH',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
