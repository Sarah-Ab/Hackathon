import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/database.dart';
import 'package:form_field_validator/form_field_validator.dart';
import './login.dart';
import './mainpage.dart';
import './register.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentification.dart';
import 'mainpage.dart';

String path_image_login= 'asset/transpagelogin.png';
String path_dataJson = 'asset/data-Lite.json';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: Auth().user,
        initialData: null,
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: const Wrapper(),
        ));
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      return MainPageForm(
        title: 'Accueil', user: user,
      );
    } else {
      return const MyHomePage(
        title: 'Login',
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database _db = Database.instance;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");

  String? email;
  String? password;
  String failResponse = "Connexion échouee. Reessayez!";
  bool showResponse = false;
  bool showLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FutureBuilder(
            //     future: _db.artist(2437),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text(snapshot.data!.toString());
            //       } else if (snapshot.hasError) {
            //         return Text(snapshot.error!.toString());
            //       } else {
            //         return const Text("waiting");
            //       }
            //     }),
            Expanded(
              child: FittedBox(
                child:

                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Bienvenu sur notre page de connexion',
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Container(
                          width: 350,
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Veuillez entrer un adresse mail"),
                              EmailValidator(
                                  errorText: "Veuillez entrer une adresse mail valide"),
                            ]),
                            controller: _emailController,
                            // validator: (val) => !EmailValidator.validate(val!, true)
                            //     ? 'Entrer votre adresse mail.'
                            //     : null,
                            // onSaved: (email) => this.email = email,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(), labelText: 'Email'),
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _passwordController,
                            validator: RequiredValidator(
                                errorText: "Veuillez entrer un mot de passe"),
                            onSaved: (password) => this.password = password,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Mot de passe',
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Visibility(visible: showResponse, child: Text(failResponse)),
                        Visibility(
                            visible: showLoading,
                            child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                            )),

                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () => submit(),
                          child: const Text('Se connecter'),
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Test()),
                            // onPressed: submit,
                          ),
                          child: const Text('Créer un compte'),
                        ),

                      ],
                    ),
                  ),),

                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: FittedBox(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 1, minHeight: 1), // here
                  child: Image.asset(path_image_login),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
          onPressed: () => Auth().register(
              "test2@gmail.com",
              "deddede",
              "PRENOM",
              "NOM")),*/
    );
  }

  Future submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        showLoading = true;
        showResponse = false;
      });
      try{
        final User newUser = await Auth().logIn(
            _emailController.text,
            _passwordController.text);
        if(newUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPageForm(title: 'Accueil', user: newUser,)),
          );
        }else{
          const Text("Adresse ou mot de passe incorrect",
              style: TextStyle(
                color: Colors.red,
              ));
        }
      }catch(err){
        print(err.toString());
      }
      setState(() {
        showLoading = false;
        showResponse = false;
      });
    }
  }
}
