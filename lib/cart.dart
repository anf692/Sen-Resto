import 'package:flutter/material.dart';
import 'package:sen_restau/cart_manager.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = CartManager().cart;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      appBar: AppBar(
        title: Text(
          "Panier",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [Icon(Icons.more_vert)],
        backgroundColor: Colors.white,
      ),
      body: cart.isEmpty
          ? Center(child: Text("Votre panier est vide 😢"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return Container(
                        margin: EdgeInsets.all(8),
                        height: 100,
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: item['imageBytes'] != null
                                ? Image.memory(item['imageBytes'], width: 50, height: 50, fit: BoxFit.cover)
                                : Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
                            title: Text(
                              item['name'],
                              style: TextStyle(
                                color: Color.fromARGB(255, 49, 203, 54),
                              ),
                            ),
                            subtitle: Text('${item['price']} FCFA'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      CartManager().decreaseQuantity(index);
                                    });
                                  },
                                ),
                                Text('${item['quantity']}'),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      CartManager().increaseQuantity(index);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      CartManager().removeItem(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "${CartManager().total.toStringAsFixed(0)} FCFA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 49, 203, 54),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 49, 203, 54),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Commande validée"),
                            content: Text("Merci pour votre commande !"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("OK"),
                              )
                            ],
                          ),
                        );
                      },
                      child: Text(
                        "Valider la commande",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16), 
              ],
            ),
    );
  }
}
