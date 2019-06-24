import 'package:flutter/material.dart';

import '../widgets/ui_elements/social_btn.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildLogoImage() {
    return Image.asset('assets/ballerina.png');
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 20.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        onSaved: (String value) {
          _formData['email'] = value;
        },
        validator: (String value) {
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'You must provide a valid email';
          }
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        onSaved: (String value) {
          _formData['password'] = value;
        },
        validator: (String value) {
          if (value.length < 6) {
            return 'Your password must have at least 6 characters';
          }
        },
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 5.0, right: 20.0),
        child: Text(
          'Forgot Password?',
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.blueGrey, fontSize: 14.0),
        ),
      ),
      onTap: () {
        print('Forgot password button was clicked');
      },
    );
  }

  Widget _buildLoginButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: RaisedButton(
        onPressed: () {
          _submitForm();
        },
        child: Text('LOGIN'),
        textColor: Colors.white,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_formData);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  Widget _buildRegisterText() {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 10.0, right: 20.0),
        child: Text(
          'Novo Aqui? Registre',
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        print('Register button was clicked');
      },
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialButton(
          text: 'Facebook',
          textColor: Colors.blue,
        ),
        SizedBox(
          width: 20.0,
        ),
        SocialButton(
          text: 'Google',
          textColor: Colors.redAccent,
        )
      ],
    );
  }

  Widget _buildLoginFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildEmailField(),
        _buildPasswordField(),
        _buildForgotPasswordText(),
        _buildLoginButton(),
        _buildRegisterText(),
      ],
    );
  }

  SingleChildScrollView _buildLoginForm() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[_buildSocialLoginButtons(), _buildLoginFields()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildLogoImage(),
              ),
              Flexible(
                child: _buildLoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
