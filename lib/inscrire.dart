import 'package:flutter/material.dart';
import 'package:sen_restau/connexion.dart';

class Inscrire extends StatefulWidget {
  const Inscrire({super.key});

  @override
  State<Inscrire> createState() => _InscrireState();
}

class _InscrireState extends State<Inscrire> {
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  bool estvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      body: Padding(
        padding: const EdgeInsets.all(63),

        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "S'inscrire",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Color.fromARGB(255, 49, 203, 54)),
              ),
              SizedBox(height:20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _nom,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Donner votre nom complet",
                  hintText: "Veuillez saisir votre complet",
                ),
              ),
              SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Adresse email",
                  hintText: "Veuillez saisir votre email",
                ),
              ),
              SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _password,
                obscureText: estvisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Mot de passe",
                  hintText: "Votre mot de passe",
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        estvisible = !estvisible;
                      });
                    },
                    icon: Icon(
                      estvisible
                          ? Icons.remove_red_eye_sharp
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 9),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _confirmpassword,
                obscureText: estvisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Confirmer le mot de passe",
                  hintText: "Confirmer le mot de passe",
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        estvisible = !estvisible;
                      });
                    },
                    icon: Icon(
                      estvisible
                          ? Icons.remove_red_eye_sharp
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 36,
                child: ElevatedButton(
                  onPressed: () {
                    Map<String, String> loginData = {
                      'email': _email.text,
                      'password': _password.text,
                    };

                    if (loginData['email']!.isEmpty &&
                        loginData['password']!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Formulaire invalide"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Connexion();
                          },
                        ),
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
                  child: Text("Se connecter"),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text("J'ai deja un compte?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Connexion();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Se connecter",
                      style: TextStyle(color: Color.fromARGB(255, 49, 203, 54)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
