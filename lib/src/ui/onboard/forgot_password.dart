import 'package:flutter/material.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/margins.dart';
import 'package:provider/provider.dart';

import '../../core/constants/constants.dart';
import '../../core/mixins/validators.dart';
import '../../core/router/router.dart';
import '../widgets/custom_flat_button.dart';
import '../widgets/custom_input_field.dart';
import 'components/greeting_header.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String greetingText = 'Forgot Password ?';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              const YMargin(32),
              buildGreetingHeader(
                '$greetingText',
                'Enter your email to continue!',
                context,
              ),
              const YMargin(32),
              buildForgotPasswordForm()
            ],
          ),
        ),
      );

  Form buildForgotPasswordForm() {
    final prov = Provider.of<AuthProvider>(context);

    var loading = prov.modelStatus == ModelStatus.busy;

    //
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // Email Field
          CustomInputField(
            enabled: !loading,
            autoValidateMode: _autovalidateMode,
            prefixIcon: Icons.email,
            label: 'Email',
            hint: 'xxx@example.com',
            controller: _emailController,
            validator: (value) => Validators().validateEmail(value),
            keyBoardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),

          //ForgotPassword  button
          CustomFlatButton(
            loading: loading,
            onPressed: validateAndSubmit,
            buttonText: 'Proceed',
          ),
        ],
      ),
    );
  }

  Future<void> validateAndSubmit() async {
    {
      if (_formKey.currentState.validate()) {
        FocusScope.of(context).requestFocus(FocusNode());

        var sent = await context
            .read<AuthProvider>()
            .sendPasswordResetEmail(_emailController.text.trim());

        if (sent) {
          await Navigator.pushNamed(context, Routes.loginRoute);
        }
      } else {
        setState(() => _autovalidateMode = AutovalidateMode.always);
      }
    }
  }
}
