import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
<<<<<<< HEAD
=======
import 'package:sen_restau/cart_manager.dart';
>>>>>>> 5365e0cbe36d375c9865f731d5485432851a9325

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => _imageBytes = bytes);
    }
  }

  void _submit() {
    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une image')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'description': _descController.text,
        'imageBytes': _imageBytes,
=======
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
>>>>>>> 5365e0cbe36d375c9865f731d5485432851a9325
      });
    }
  }

<<<<<<< HEAD
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

=======
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
>>>>>>> 5365e0cbe36d375c9865f731d5485432851a9325
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text('Nouveau Produit'),
        backgroundColor: Color.fromARGB(255, 49, 203, 54),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      _imageBytes != null
                          ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 50),
                              Text('Ajouter une image'),
                            ],
                          ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom du produit'),
                validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Prix (FCFA)'),
                validator: (v) => v!.isEmpty ? 'Champ obligatoire' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 49, 203, 54),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text('Enregistrer', style: TextStyle(fontSize: 18)),
              ),
            ],
=======
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
>>>>>>> 5365e0cbe36d375c9865f731d5485432851a9325
          ),
        ),
      ),
    );
  }
}
