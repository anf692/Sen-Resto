import 'package:flutter/material.dart';
import 'package:sen_restau/inscrire.dart';
import 'package:sen_restau/navbar.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                'Connexion',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Color.fromARGB(255, 49, 203, 54)),
              ),
              SizedBox(height: 55),
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
              SizedBox(height: 30),
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
              SizedBox(height: 5),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Mot de passe oublie?",
                  style: TextStyle(),
                  textAlign: TextAlign.right,
                ),
              ),

              SizedBox(height: 33),

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
                            return Navbar();
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
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Vous n'avez pas de compte?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Inscrire();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "S'incrire",
                      style: TextStyle(color: Color.fromARGB(255, 49, 203, 54),),
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
