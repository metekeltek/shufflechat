import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/ui/register1.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                        maxLength: 30,
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
                          MaxLengthValidator(15,
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
                            var result = await context
                                .read<AuthProvider>()
                                .login(_emailController.text,
                                    _passwordController.text);
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
                            _showNameDialog(context, _emailController.text);
                          },
                          child: Text(
                            'Forgot password?',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
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
                          Text('Have no Account? '),
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

void sendPasswordResetMail(context, String mail) {
  context.read<AuthProvider>().resetPassword(mail);
}

void _showNameDialog(context, String mail) {
  TextEditingController _nameController = TextEditingController();
  _nameController.text = mail;

  bool _isVisible = false;
  String responseMessage = '';
  Color responseColor;

  void showResponse(message, responseColor) {
    responseMessage = message;
    _isVisible = true;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Send Password Reset Mail'),
          content: Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  child: Center(
                    child: Visibility(
                      visible: _isVisible,
                      child: Text(
                        responseMessage,
                        style: TextStyle(color: responseColor, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    counterText: '',
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                  autofocus: true,
                  controller: _nameController,
                  maxLength: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.amberAccent[700],
                  ),
                  width: 150,
                  height: 40,
                  child: MaterialButton(
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_nameController.text.isNotEmpty) {
                          //sendPasswordResetMail(context, mail);
                          showResponse(
                              'We have send you a email to reset your password',
                              Colors.green);
                        } else {
                          showResponse(
                              'You need to enter a valid email', Colors.red);
                        }
                      }),
                )
              ],
            ),
          ),
          contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
        ),
      );
    },
  );
}
