import 'package:flutter/material.dart';
import 'AddProductPage.dart';
import 'cart.dart';
import 'cart_manager.dart';
import 'details.dart';
import 'navbar.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key); // Correction de la clé

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  // Liste des produits avec un type explicite
  final List<Map<String, dynamic>> products = [
  {
    'image': 'images/burgger.PNG',
    'name': 'Burger',
    'price': 588.0,
    'description': 'Un délicieux burger fait avec un steak juteux, du fromage fondant, des légumes frais et une sauce spéciale maison.'
  },
  {
    'image': 'images/chawarma.PNG',
    'name': 'Chawarma',
    'price': 499.0,
    'description': 'Savourez notre chawarma garni de viande marinée, de crudités croquantes et nappé de sauce blanche onctueuse, enroulé dans un pain tendre.'
  },
  {
    'image': 'images/fataya.PNG',
    'name': 'Fataya',
    'price': 390.0,
    'description': 'Goûtez à notre fataya sénégalais, une pâte croustillante farcie au poisson épicé, accompagné de notre sauce tomate maison.'
  },
  {
    'image': 'images/logo.PNG',
    'name': 'Burger Mini',
    'price': 20.0,
    'description': 'Un mini burger parfait pour les petites faims, avec un petit steak, fromage et sauce, tout en restant gourmand.'
  },
  {
    'image': 'images/sandiwich.PNG',
    'name': 'Sandwich',
    'price': 384.0,
    'description': 'Un sandwich généreux, garni de poulet grillé, légumes croquants et une sauce crémeuse, le tout dans un pain moelleux.'
  },
  {
    'image': 'images/tacos.PNG',
    'name': 'Tacos',
    'price': 164.0,
    'description': 'Des tacos savoureux remplis de viande tendre, de frites croustillantes et de fromage fondant, roulés dans une galette chaude.'
  },
];

  void addProduct(Map<String, dynamic> product) {
  setState(() {
    products.add({
      'name': product['name'],
      'price': product['price'],
      'imageBytes': product['imageBytes'],
      'description': product['description'] ?? 'Pas de description',
      // Ajoutez d'autres champs si nécessaire
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      appBar: AppBar(
        actions: [Icon(Icons.more_vert)],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home, color: Color.fromARGB(255, 49, 203, 54)),
              title: Text("Acceuil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Navbar()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Color.fromARGB(255, 49, 203, 54)),
              title: Text("Panier"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(cart: CartManager().cart)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_emergency, color: Color.fromARGB(255, 49, 203, 54)),
              title: Text("Contact"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               ElevatedButton(
                  onPressed: () async {
                    final newProduct = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProductPage()),
                    );

                    if (newProduct != null) {
                      addProduct(newProduct);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Produit ajouté à la liste avec succès!")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 49, 203, 54),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Créer un produit"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                children: products.map((product) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    height: 70,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          // ✅ GESTION DYNAMIQUE IMAGE (asset ou memory)
                          if (product.containsKey('imageBytes'))
                            Image.memory(
                              product['imageBytes'],
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          else
                            Image.asset(
                              product['image'],
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          SizedBox(height: 3),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    image: product['image'] ?? '',
                                    name: product['name'],
                                    price: product['Price'] ?? product['price'],
                                    description: product['description'],
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(foregroundColor: Colors.black),
                            child: Text(
                              product['name'],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "${product['Price'] ?? product['price']} FCFA",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 3),
                         ElevatedButton(
                          onPressed: () {
                            CartManager().addItem({
                              'name': product['name'],
                              'image': product.containsKey('imageBytes') ? null : product['image'],
                              'imageBytes': product['imageBytes'],
                              'price': product['price'] ?? product['Price'],
                              'quantity': 1,
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product['name']} ajouté au panier !'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 49, 203, 54),
                              foregroundColor: Colors.white,
                              minimumSize: Size(100, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.shopping_cart, color: Colors.red),
                                Text("Ajouter au panier"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
