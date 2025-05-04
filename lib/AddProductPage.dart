import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sen_restau/cart_manager.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _image = '';
  double _price = 0.0;

  Uint8List? _pickedImageBytes;

  // Fonction pour choisir une image (compatible web)
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _pickedImageBytes = bytes;
        _image = pickedFile.path;
      });
    }
  }

  void _submitForm() {
  if (_pickedImageBytes == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Veuillez sélectionner une image')),
    );
    return;
  }

  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    final newProduct = {
      'name': _name,
      'price': _price,
      'imageBytes': _pickedImageBytes,
      'description': 'Description à compléter', // Ajoutez une description
    };

    // Retourne le produit au lieu de l'ajouter au panier
    Navigator.pop(context, newProduct);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un produit'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Nom
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nom du produit'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                SizedBox(height: 16),

                // Sélection d'image
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: _pickedImageBytes != null
                        ? Image.memory(_pickedImageBytes!, fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 50, color: Colors.grey[700]),
                              SizedBox(height: 8),
                              Text('Choisir une image', style: TextStyle(color: Colors.grey[700])),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 16),

                // Prix
                TextFormField(
                  decoration: InputDecoration(labelText: 'Prix (FCFA)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un prix';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Veuillez entrer un nombre valide';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
                SizedBox(height: 32),

                // Bouton Ajouter
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Ajouter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
