import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  bool _isVisible = false;

  void showResponse() {
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'resetPasswordTitle'.tr(),
                      style: TextStyle(
                          fontSize: 56.0, fontWeight: FontWeight.w800),
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
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Visibility(
                        visible: _isVisible,
                        child: Text(
                          'resetPasswordMail'.tr(),
                          style: TextStyle(
                              color: Colors.green,
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
                                await context
                                    .read<AuthProvider>()
                                    .resetPassword(_emailController.text);
                                setState(() {
                                  isLoading = false;
                                });
                                showResponse();
                              }
                            },
                            child: Text('resetPassword'.tr()),
                          ),
                        ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
