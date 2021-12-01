import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/database.dart';
import 'package:form_field_validator/form_field_validator.dart';
import './login.dart';
import './mainpage.dart';
import './register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Bienvenu'),
    );
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

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                  child: Image.asset('../web/icons/transpagelogin.png'),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MainPageForm(title: 'Accueil',)),
        );
      }catch(err){
        print(err.toString());
      }
      setState(() {
        showLoading = false;
        showResponse = false;
      });
    }
  }

/*
  try{
                              submit();
                            }catch(err){
                              print(err.toString());
                            }



   */
}
