import 'package:flutter/material.dart';
import 'package:registrationpage/screens/home_screen.dart';
import 'package:registrationpage/services/authenticationService.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return value.contains("@")
                          ? null
                          : "Enter valid Email";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return value.length > 6
                          ? null
                          : "Password must be 6 characters";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.orangeAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => HomeScreen()));
                      },
                      child: Text(
                        "Login",
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void login() {
    if (_key.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    };
  }

  void signInUser() async {
    dynamic authResult =
    await _auth.loginUser(_emailController.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. could not be able to login');
    } else {
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushNamed(context, '/HomeScreen');
    }
  }
}
