import 'package:flutter/material.dart';
import 'package:sen_restau/cart.dart';
import 'package:sen_restau/cart_manager.dart';
import 'package:sen_restau/details.dart';
import 'package:sen_restau/navbar.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> products = [
      {'image': 'images/burgger.PNG', 'name': 'Burgger', 'Price': 588, 'description':'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'},
      {'image': 'images/chawarma.PNG', 'name': 'Chawarma', 'Price': 499,'description':'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'},
      {'image': 'images/fataya.PNG', 'name': 'Fataya', 'Price': 390,'description':'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'},
      {'image': 'images/logo.PNG', 'name': 'Burgger', 'Price': 20,'description':'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'},
      {'image': 'images/sandiwich.PNG', 'name': 'Sandiwich', 'Price': 384,'description':'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'},
      {'image': 'images/tacos.PNG', 'name': 'Tacos', 'Price': 164,'description':'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'},
    ];

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
              leading: Icon(
                Icons.home,
                color: Color.fromARGB(255, 49, 203, 54),
              ),
              title: Text("Acceuil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Navbar();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 49, 203, 54),
              ),
              title: Text("Panier"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cart: CartManager().cart),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contact_emergency,
                color: Color.fromARGB(255, 49, 203, 54),
              ),
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
                  onPressed: () {},
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
                      Icon(Icons.add, color: Colors.red),
                      Text("Creer un produits"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                children:
                    products.map((product) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        height: 70,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
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
                                          image: product['image'],
                                          name: product['name'],
                                          price: product['Price'],
                                          description: product['description']
                                        ),
                                      ),
                                    );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                ),
                                child: Text(
                                  product['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${product['Price']} FCFA",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 3),
                              ElevatedButton(
                                onPressed: () {
                                  // Ajoute le produit au CartManager
                                  CartManager().addItem({
                                    'name': product['name'],
                                    'image': product['image'],
                                    'price': product['Price'],
                                  });

                                  // Affiche une alerte
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product['name']} ajouté au panier !',
                                      ),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255,49,203, 54,),
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
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                    ),
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
