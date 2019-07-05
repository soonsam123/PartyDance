import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/social_btn.dart';
import '../scoped_models/main.dart';
import '../utils/strings.dart';

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
    var txt = TextEditingController();
    txt.text = "karatesoon@gmail.com";
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 20.0),
      child: TextFormField(
        controller: txt,
        decoration: InputDecoration(labelText: 'Email',),
        onSaved: (String value) {
          _formData[Strings.email] = value;
        },
        validator: (String value) {
          if (!RegExp(Strings.emailRegExp).hasMatch(value)) {
            return Strings.warningMustProvideValidEmail;
          }
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    var txt = TextEditingController();
    txt.text = "123456";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        controller: txt,
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        onSaved: (String value) {
          _formData[Strings.password] = value;
        },
        validator: (String value) {
          if (value.length < 6) {
            return Strings.warningPasswordAtLeast;
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: RaisedButton(
            onPressed: () {
              _submitForm(model);
            },
            child: Text('LOGIN'),
            textColor: Colors.white,
          ),
        );
      },
    );
  }

  void _submitForm(MainModel model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      model.login(_formData[Strings.email], _formData[Strings.password]);
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacementNamed('/home');
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
          action: _navigateToHome,
        ),
        SizedBox(
          width: 20.0,
        ),
        SocialButton(
          text: 'Google',
          textColor: Colors.redAccent,
          action: _navigateToHome,
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
