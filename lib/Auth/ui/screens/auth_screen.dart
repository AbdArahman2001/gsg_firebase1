import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/models/country_model.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Container(
            height: authProvider.loginState == LoginState.signUp
                ? MediaQuery.of(context).size.height * 0.75
                : MediaQuery.of(context).size.height * 0.5,
            child: Card(
              elevation: 10,
              margin: EdgeInsets.symmetric(horizontal: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: authProvider.loginState == LoginState.signUp,
                        child: GestureDetector(
                          onTap: authProvider.pickImage,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: authProvider.pickedImage != null
                                ? Image.file(authProvider.pickedImage)
                                : Container(
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                      CustomTextField(authProvider.emailController, 'Email'),
                      CustomTextField(
                          authProvider.passwordController, 'Password'),
                      Visibility(
                        visible: authProvider.loginState == LoginState.signUp,
                        child: CustomTextField(
                            authProvider.confirmPasswordController,
                            'Confirm Password'),
                      ),
                      Visibility(
                          visible: authProvider.loginState == LoginState.signUp,
                          child: CustomTextField(
                              authProvider.fNameController, 'first Name')),
                      Visibility(
                        visible: authProvider.loginState == LoginState.signUp,
                        child: CustomTextField(
                            authProvider.lNameController, 'last Name'),
                      ),
                      Visibility(
                          visible: authProvider.loginState == LoginState.signUp,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey)),
                            child: DropdownButton<CountryModel>(
                              isExpanded: true,
                              underline: Container(),
                              onChanged: authProvider.selectCountry,
                              value: authProvider.selectedCountry,
                              items: authProvider.countries
                                  .map((CountryModel country) {
                                return DropdownMenuItem<CountryModel>(
                                  value: country,
                                  child: Text(country.name),
                                );
                              }).toList(),
                            ),
                          )),
                      Visibility(
                          visible: authProvider.loginState == LoginState.signUp,
                          child: DropdownButton(
                            onChanged: authProvider.selectCity,
                            value: authProvider.selectedCity,
                            items: authProvider.selectedCities.map((city) {
                              return DropdownMenuItem(
                                value: city.toString(),
                                child: Text(city.toString()),
                              );
                            }).toList(),
                          )),
                      Visibility(
                          visible: authProvider.loginState == LoginState.signIn,
                          child: TextButton(
                              onPressed: authProvider.resetPassword,
                              child: Text('forget password?'))),
                      ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                (states) => EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 24),
                              ),
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                          onPressed: () {
                            authProvider.authenticate();
                          },
                          child: Text(
                            authProvider.loginState == LoginState.signUp
                                ? 'SIGN UP'
                                : 'LOGIN',
                          )),
                      TextButton(
                          onPressed: authProvider.switchLoginState,
                          child: Text(
                              (authProvider.loginState == LoginState.signUp
                                      ? 'LOGIN'
                                      : 'SIGN UP') +
                                  ' INSTEAD')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
