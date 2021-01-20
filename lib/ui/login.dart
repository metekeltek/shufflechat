import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/ui/forgotPassword.dart';
import 'package:shufflechat/ui/register1.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Welcome to Shuffle Chat',
                        style: TextStyle(
                            fontSize: 78.0, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                        maxLength: 40,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          counterText: '',
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
                          MaxLengthValidator(40,
                              errorText:
                                  "Password should not be greater than 15 characters")
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.amberAccent[700]),
                            strokeWidth: 4,
                          )
                        : Container(
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
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var result = await context
                                      .read<AuthProvider>()
                                      .login(_emailController.text,
                                          _passwordController.text);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (result != 'success') {
                                    var errorMessage = translateError(result);

                                    showError(errorMessage);
                                  }
                                }
                              },
                              child: Text('Login'),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have no Account? ',
                            style: TextStyle(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register1(),
                                ),
                              );
                            },
                            child: Text(
                              'Register here',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15),
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
    case 'invalid-email':
      errorMessage = 'invalid email address';
      break;
    case 'user-not-found':
      errorMessage = 'There is no user with the given email';
      break;
    case 'wrong-password':
      errorMessage = 'wrong password';
      break;
    default:
      errorMessage = 'error';
      break;
  }
  return errorMessage;
}
