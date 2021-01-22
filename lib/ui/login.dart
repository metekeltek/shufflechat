import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/ui/forgotPassword.dart';
import 'package:shufflechat/ui/register1.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              'welcome'.tr(),
                              style: TextStyle(
                                  fontSize: 78.0, fontWeight: FontWeight.w800),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              'Shufflechat',
                              style: TextStyle(
                                  fontSize: 78.0, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
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
                          labelText: 'email'.tr(),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.black,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'required'.tr()),
                          EmailValidator(errorText: 'validMail'.tr()),
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
                          labelText: 'password'.tr(),
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          fillColor: Colors.black,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'required'.tr()),
                          MinLengthValidator(6, errorText: 'passwordMin'.tr()),
                          MaxLengthValidator(30, errorText: 'passwordMax'.tr())
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 40,
                      child: Center(
                        child: Visibility(
                          visible: _isVisible,
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xffff9600)),
                            strokeWidth: 4,
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width / 1.6,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xffff9600),
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
                              child: Text('login'.tr()),
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
                            'forgotPassword'.tr(),
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15),
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
                            'noAccount'.tr(),
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
                              'registerHere'.tr(),
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
      errorMessage = 'invalidMail'.tr();
      break;
    case 'user-not-found':
      errorMessage = 'noUserWithMail'.tr();
      break;
    case 'wrong-password':
      errorMessage = 'wrongPassword'.tr();
      break;
    default:
      errorMessage = 'error';
      break;
  }
  return errorMessage;
}
