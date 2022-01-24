import 'package:demo_bloc/business_logic/blocs/form/form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FormValidationPage extends StatefulWidget {
  const FormValidationPage({Key? key}) : super(key: key);

  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<FormBloC>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<FormBloC>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloC, DemoFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => const SuccessDialog(),
          );
        }
      },
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                EmailInput(focusNode: _emailFocusNode),
                PasswordInput(
                  focusNode: _passwordFocusNode,
                ),
                SubmitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<FormBloC>().add(FormSubmitted())
              : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'Enter your email',
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. tientt@gmail.com',
            errorText: state.email.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<FormBloC>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Enter your password',
            labelText: 'Password',
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            context.read<FormBloC>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Icon(Icons.info),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
