import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hackathon/ColorCustom.dart';
import './main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './authentification.dart';
import 'mainpage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Test());
}
// Map<int, Color> color = {
//   50:  Color.fromRGBO(0, 128, 128, 0.10196078431372549),
//   100: Color.fromRGBO(0, 128, 128, .2),
//   200: Color.fromRGBO(0, 128, 128, .3),
//   300: Color.fromRGBO(0, 128, 128, .4),
//   400: Color.fromRGBO(0, 128, 128, .5),
//   500: Color.fromRGBO(0, 128, 128, .6),
//   600: Color.fromRGBO(0, 128, 128, .7),
//   700: Color.fromRGBO(0, 128, 128, 0.8),
//   800: Color.fromRGBO(0, 128, 128, .9),
//   900: Color.fromRGBO(0, 128, 128, 1),
// };

//MaterialColor colorCustom = MaterialColor(0xFF009688, color);

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: Auth().user,
        initialData: null,
        child: const MaterialApp(
          home: Wrapper(),
        ));
  }
}


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      return const Test2();
    } else {
      return const Test2();
    }
  }
}

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inscription'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SizedBox(height:100),
                    SignUpForm(),
                  ],
                ),
              ),
              Expanded(
                child: FittedBox(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 1, minHeight: 1),
                    // here
                    child: Image.asset(path_image_login),
                  ),
                  fit: BoxFit.fill,
                ),
              ),

              ],
          ),
        ),
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
  TextEditingController(text: "");
  final TextEditingController passwordController =
  TextEditingController(text: "");
  final TextEditingController prenomController =
  TextEditingController(text: "");
  final TextEditingController nomController =
  TextEditingController(text: "");
  final TextEditingController roleController =
  TextEditingController(text: "");

  String? email;
  String? lastname;
  String? firstname;
  String? pw;
  TextEditingController? testPw = TextEditingController();
  String? pwConf;
  String failResponse = "La connexion a échoué. Veuillez reéssayer";
  bool showResponse = false;
  bool showLoading = false;
  String? role;


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: nomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }
                  return null;
                },
                onSaved: (lastname) => this.lastname = lastname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez entrer votre nom',
                ),
              ),
              TextFormField(
                controller: prenomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prenom';
                  }
                  return null;
                },
                onSaved: (firstname) => this.firstname = firstname,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez entrer votre prénom',
                ),
              ),
              TextFormField(
                controller: emailController,
                validator: MultiValidator([
                  RequiredValidator(
                      errorText: "Veuillez entrer votre adresse mail"),
                  EmailValidator(
                      errorText: "Veuillez choisir une adresse mail valide"),
                ]),
                onSaved: (email) => this.email = email,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), labelText: 'Email'),
              ),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                //controller: testPw,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  testPw!.text = value;
                  return null;
                },
                onSaved: (pw) => this.pw = pw,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez à nouveau entrer votre mot de passe',
                ),
              ),
              TextFormField(
                // pwconf
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (value == null || testPw!.text.toString() != value) {
                    return 'Les mots de passes ne correspondent pas';
                  }
                  return null;
                },
                onSaved: (pw) => pwConf = pw,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Veuillez confirmer votre mot de passe',
                ),
              ),
              Align(
                  child:Column (
                    children: [
                      DropdownButtonFormField<String>(

                        value: role,
                        hint: Text(
                          'Entrer votre role',
                        ),
                        onChanged: (value) =>
                            setState(() => role = value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez selectionner votre role';
                          }
                          roleController.text = value;
                          return null;
                        },
                        items:
                        ['Programmateur.', 'Exploitant'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                    ],

              )
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
                onPressed: submit,
                child: const Text('S\'inscrire'),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'Bienvenu',)),
                  // onPressed: submit,
                ),
                child: Text('J\'ai déja un compte'),
              ),
            ],
          ),

        ));

  }

  /*Future submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        showLoading = true;
        showResponse = false;
      });
    }
  }*/
  Future submit() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() async {

        showResponse = false;
        try {
          User newUser = await Auth().register(
              emailController.text,
              passwordController.text,
              prenomController.text,
              nomController.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPageForm(title: 'Accueil', user: newUser,)));
          setState(() {
            showLoading = false;
          });
        } on Exception catch (e) {
          setState(() {
            print(e.toString());
            showLoading = false;
          });
        }});
    }
  }
}
