import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Modal/userModal.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  bool isLogin = true;
  bool isChecked = false;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerNumber = TextEditingController();

  _clearControllerValues() {
    controllerEmail.clear();
    controllerPassword.clear();
  }

  bool _checkControllerValue() {
    if (controllerName.text == '' ||
        controllerEmail.text == '' ||
        controllerNumber == '' ||
        controllerPassword == '' ||
        isChecked == false) {
      return false;
    }
    return true;
  }

  Future<dynamic> add_user(Users user) async {
    final docUser = _users.doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }

  loginFunction() async {
    if (controllerPassword.text != '' && controllerEmail.text != '') {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
        SnackBar sb = SnackBar(content: Text("Login Successfull"));
        ScaffoldMessenger.of(context).showSnackBar(sb);
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          SnackBar sb =
              SnackBar(content: Text('No user found for that email.'));
          ScaffoldMessenger.of(context).showSnackBar(sb);
        } else if (e.code == 'wrong-password') {
          SnackBar sb =
              SnackBar(content: Text('Wrong password provided for that user.'));
          ScaffoldMessenger.of(context).showSnackBar(sb);
        }
      }
    } else {
      SnackBar sb = SnackBar(content: Text("Fill al the values"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }
  }

  registerFunction() async {
    if (_checkControllerValue()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
        Users user = Users(
          name: controllerName.text,
          number: controllerNumber.text,
          password: controllerPassword.text,
          email: controllerEmail.text,
        );
        print(user);
        add_user(user);
        setState(() {
          _clearControllerValues();
          isLogin = true;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          SnackBar sb =
              SnackBar(content: Text('The password provided is too weak.'));
          ScaffoldMessenger.of(context).showSnackBar(sb);
        } else if (e.code == 'email-already-in-use') {
          SnackBar sb = SnackBar(
              content: Text('The account already exists for that email.'));
          ScaffoldMessenger.of(context).showSnackBar(sb);
        }
      } catch (e) {
        print(e);
      }
    } else {
      SnackBar sb = SnackBar(content: Text("Fill al the values"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLogin == false) {
                            isLogin = true;
                            _clearControllerValues();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLogin ? Colors.red : Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: isLogin
                                ? Radius.circular(40.0)
                                : Radius.circular(0),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isLogin == true) {
                            isLogin = false;
                            _clearControllerValues();
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLogin ? Colors.white : Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: isLogin
                                ? Radius.circular(0)
                                : Radius.circular(40),
                            bottomRight: Radius.circular(40.0),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                height: MediaQuery.of(context).size.height / 1.45,
                width: MediaQuery.of(context).size.width,
                child: isLogin ? _login() : _signup(),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      isLogin ? loginFunction() : registerFunction();
                    },
                    child: Text(
                      isLogin ? "LOGIN" : "REGISTER",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 3,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textField({
    required String title,
    required TextEditingController controller,
    required String hinttext,
    required Icon icon,
    int? maxlength,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hinttext,
            counterText: "",
            suffixIcon: icon,
          ),
          obscureText: obscure,
          maxLines: 1,
          maxLength: maxlength,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  _login() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SignIn into your Account",
          style: TextStyle(
              color: Colors.red, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        _textField(
          title: "Email",
          controller: controllerEmail,
          hinttext: 'johndoe@gmail.com',
          icon: Icon(Icons.email),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        _textField(
          title: "Password",
          controller: controllerPassword,
          obscure: true,
          hinttext: 'Password',
          icon: Icon(Icons.lock_outline),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 75,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Forgot Password ? ",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login with",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _googleFacebookAuth(name: "google"),
            _googleFacebookAuth(name: "facebook"),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dont't have an Account ?",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isLogin == true) {
                    isLogin = false;
                    _clearControllerValues();
                  }
                });
              },
              child: Text(
                "Register Now",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (credential != null) {
      SnackBar sb = SnackBar(content: Text("Login Successfull"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      SnackBar sb = SnackBar(content: Text("Login Failed"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  _googleFacebookAuth({required String name}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      height: 50,
      width: 50,
      child: IconButton(
          onPressed: () {
            name == 'google' ? signInWithGoogle() : signInWithFacebook();
          },
          icon: Image.asset("assets/images/${name}.png")),
    );
  }

  _signup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create an Account",
          style: TextStyle(
              color: Colors.red, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        _textField(
          title: "Name",
          controller: controllerName,
          hinttext: "John Doe",
          icon: Icon(Icons.person),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        _textField(
          title: "Email",
          controller: controllerEmail,
          hinttext: "johndoe@gmail.com",
          icon: Icon(Icons.email),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        _textField(
          title: "Contact No",
          controller: controllerNumber,
          hinttext: "9876543210",
          maxlength: 10,
          icon: Icon(
            Icons.call,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 33,
        ),
        _textField(
          title: "Password",
          controller: controllerPassword,
          hinttext: '*********',
          obscure: true,
          icon: Icon(Icons.lock_outline),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text(
              "I agree with ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              "term & condition",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an Account ?",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (isLogin == false) {
                    isLogin = true;
                    _clearControllerValues();
                  }
                });
              },
              child: Text(
                "Sign In!",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
