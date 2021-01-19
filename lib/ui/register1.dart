import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/register2.dart';

class Register1 extends StatefulWidget {
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isVisible = false;
  String errorMessage = '';

  void showError(e) {
    errorMessage = e;
    setState(() {
      _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Register2();
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 78.0, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: TextFormField(
                        maxLength: 30,
                        controller: _emailController,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'email',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.black,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid email id"),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: TextFormField(
                        maxLength: 30,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'at least 6 Characters',
                          labelText: 'password',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.black,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(6,
                              errorText:
                                  "Password should be atleast 6 characters"),
                          MaxLengthValidator(15,
                              errorText:
                                  "Password should not be greater than 15 characters")
                        ]),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Center(
                        child: Visibility(
                          visible: _isVisible,
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.6,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.amberAccent[700],
                      ),
                      child: MaterialButton(
                        textColor: Colors.white,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var registerResult = await context
                                .read<AuthProvider>()
                                .register(_emailController.text,
                                    _passwordController.text);
                            if (registerResult.error = false) {
                              UserData userData = UserData();
                              await context
                                  .read<DatabaseProvider>()
                                  .setUser(registerResult.uid, userData);
                            } else {
                              var errorMessage =
                                  translateError(registerResult.errorMessage);
                              showError(errorMessage);
                            }
                          }
                        },
                        child: Text('continue'),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'By clicking continue, you agree to our ',
                          ),
                          Text(
                            'Terms',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Read how we process you data in the ',
                          ),
                          Text(
                            'Privacy Policy',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Or '),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'sign In',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String translateError(errorMessage) {
  switch (errorMessage) {
    case 'email-already-in-use':
      errorMessage = 'The email is already in use';
      break;
    case 'invalid-email':
      errorMessage = 'The given email is not valid';
      break;
    case 'weak-password':
      errorMessage = 'The given password is too weak';
      break;
    default:
      errorMessage = 'error';
      break;
  }
  return errorMessage;
}
