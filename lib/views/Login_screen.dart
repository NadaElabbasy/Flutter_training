import 'package:flutter/material.dart';
import 'package:flutter_navigation/views/Profile.dart';
import 'package:flutter_navigation/views/NextPage.dart';
import 'package:flutter_navigation/views/TodoList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage();
  static String id = ' home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/shoe.jpg"), fit: BoxFit.fill)),
              child: Column(
                children: [],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 14, 131, 209),
                      size: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value!.contains("@")) {
                            return null;
                          } else {
                            return "Invaild email";
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value!.length < 8) {
                            return "password should contain 8 characters or more";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30, // <-- SEE HERE
                    ),
                    InkWell(
                      onTap: () {},
                      child: FilledButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 33, 142, 243)),
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                            bool loginresult = await signinUsingFirebase(emailController.text, passwordController.text);
                            if(loginresult == true){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>TodoList( )),
                              );
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Invalid Login')));
                            }
                            }
                            else {
                    emailController.clear();
                  }
                          },
                          child: const Text('Log In',
                              style: TextStyle(fontSize: 20))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }
 Future<bool> signinUsingFirebase(String email, String password) async {
  bool result = false;
  try{
    UserCredential Credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    final user = Credential.user;
    if (user!= null){
    print(user?.uid);
    saveEmail(user!.email!);
    result = true;
    }
    return result;
  }
  catch(e){
    return result;
  }
}
}