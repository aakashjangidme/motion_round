import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';
import '../../core/mixins/validators.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/router/router.dart';
import '../../core/utils/basic_utils.dart';
import '../widgets/custom_flat_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/margins.dart';
import 'components/greeting_header.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _obsecure = true;
  String greetingText = 'Welcome';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final prov = Provider.of<AuthProvider>(context);

    var loading = prov.modelStatus == ModelStatus.busy;

    var theme = Theme.of(context);

    //
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const YMargin(32),
              buildGreetingHeader(
                '$greetingText,',
                'Sign in to continue!',
                context,
              ),
              const YMargin(32),
              Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // Email Field
                    CustomInputField(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      enabled: !loading,
                      autoValidateMode: _autovalidateMode,
                      prefixIcon: Mdi.emailOutline,
                      label: 'Email',
                      hint: 'xxx@example.com',
                      controller: _emailController,
                      validator: (value) => Validators().validateEmail(value),
                      keyBoardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),

                    // Password Field

                    CustomInputField(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      enabled: !loading,
                      autoValidateMode: _autovalidateMode,
                      label: 'Password',
                      prefixIcon: Mdi.lockOutline,
                      controller: _passwordController,
                      obsecureText: _obsecure,
                      validator: (value) =>
                          Validators().validatePassword(value),
                      suffixIcon:
                          _obsecure ? Mdi.eyeOffOutline : Mdi.eyeOutline,
                      onTapSuffix: () => setState(() => _obsecure = !_obsecure),
                      keyBoardType: TextInputType.visiblePassword,
                    ),

                    // Forgot password button
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: loading
                            ? null
                            : () => Navigator.pushNamed(
                                  context,
                                  Routes.forgotPassword,
                                ),
                        child: Text(
                          'Forgot Password?',
                          style: theme.textTheme.button,
                        ),
                      ),
                    ),

                    //Login  button
                    CustomFlatButton(
                      loading: loading,
                      onPressed: validateAndSubmit,
                      buttonText: 'LOGIN',
                    ),

                    // Takes to the Registration page.
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: loading
                            ? null
                            : () => Navigator.pushNamed(
                                  context,
                                  Routes.registerRoute,
                                ),
                        child: Text(
                          'Don\'t have an account?',
                          style: theme.textTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future validateAndSubmit() async {
    {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());

        var email = await context.read<AuthProvider>().singInWithEmailPass(
            _emailController.text.trim(), _passwordController.text.trim());

        if (email != null) {
          BasicUtils.toast('Logged in as $email');
        }
      } else {
        setState(() => _autovalidateMode = AutovalidateMode.always);
      }
    }
  }
}
