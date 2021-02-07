import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/margins.dart';
import 'package:mdi/mdi.dart';
import '../../core/mixins/validators.dart';
import '../../core/router/router.dart';

import '../../core/utils/basic_utils.dart';

import '../widgets/custom_flat_button.dart';
import '../widgets/custom_input_field.dart';
import 'components/greeting_header.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../core/services/dialog/dialog_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obsecure = true;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final _dialog = locator<DialogService>();

  @override
  void dispose() {
    // controllers
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);

    var loading = prov.modelStatus == ModelStatus.busy;

    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const BackButton(),
              const YMargin(32),
              buildGreetingHeader(
                'Create Account,',
                'Sign up to get started!',
                context,
              ),
              const YMargin(32),
              Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CustomInputField(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      enabled: !loading,
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Jhon Doe',
                      prefixIcon: Mdi.accountOutline,
                      keyBoardType: TextInputType.name,
                      validator: (value) => Validators().emptyValidaton(value),
                      textInputAction: TextInputAction.next,
                    ),
                    // Email Field
                    CustomInputField(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                    CustomInputField(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      enabled: !loading,
                      controller: _contactController,
                      label: 'Contact',
                      hint: '987654310 (without prefix)',
                      prefixIcon: Mdi.phone,
                      textInputAction: TextInputAction.next,
                      keyBoardType: TextInputType.phone,
                      validator: (value) =>
                          Validators().validatePhoneNumber(value),
                    ),
                    CustomInputField(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await _selectDate();
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      enabled: !loading,
                      controller: _dobController,
                      label: 'Date of Birth',
                      hint: 'yyyy-mm-dd',
                      prefixIcon: Mdi.calendar,
                      keyBoardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators().emptyValidaton(value),
                    ),
                    CustomInputField(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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

                    // register button
                    CustomFlatButton(
                      loading: loading,
                      onPressed: validateAndSubmit,
                      buttonText: 'REGISTER',
                    ),

                    // Takes to the Registration page.
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: loading
                            ? null
                            : () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.loginRoute,
                                );
                              },
                        child: Text(
                          'Already have an account? Sign In',
                          style: theme.textTheme.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
        var email =
            await context.read<AuthProvider>().registerWithEmailAndPassword(
                  _nameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  _contactController.text.trim(),
                  _dobController.text.trim(),
                );

        if (email != null) {
          await _dialog.showAlertDialog(
            title: 'Registration successful.',
            showCancelBUtton: false,
            okButtonText: 'CONTINUE',
          );
          //
          await Navigator.pushReplacementNamed(context, Routes.loginRoute);
          BasicUtils.toast('Registered with $email');
        }
      } else {
        setState(() => _autovalidateMode = AutovalidateMode.always);
      }
    }
  }

  Future<void> _selectDate() async {
    var picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2022),
    );
    if (picked != null) {
      setState(() => {_dobController.text = picked.toString().split(' ')[0]});
    }
  }
}
