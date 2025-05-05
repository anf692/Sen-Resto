import 'package:flutter/material.dart';
import 'package:sen_restau/acceuil.dart';
import 'package:sen_restau/cart.dart';
import 'package:sen_restau/contact.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final pages = [
    Acceuil(),
    CartPage(cart: null,),
    ContactFormScreen(),
  ];

  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(                                                                       
      body: pages[pageindex],

      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        selectedIndex: pageindex,
        onDestinationSelected: (int index) {
          setState(() {
            pageindex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home,color: pageindex==0 ? Color.fromARGB(255, 49, 203, 54):Colors.black),
            label: "Acceuil"
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart,color: pageindex==1 ? Color.fromARGB(255, 49, 203, 54):Colors.black),
            label: "Panier",
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_emergency_outlined,color: pageindex==2 ? Color.fromARGB(255, 49, 203, 54):Colors.black),
            label: "Contact",
          ),
        ],
      ),
    );
  }
}
