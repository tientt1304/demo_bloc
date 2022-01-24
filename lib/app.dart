import 'package:demo_bloc/presentation/pages/form_validation/form_validation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/blocs/form/form_bloc.dart';

class FormValidation extends StatelessWidget {
  const FormValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Form Validation Demo BloC')),
        body: BlocProvider(
          create: (_) => FormBloC(),
          child: const FormValidationPage(),
        ),
      ),
    );
  }
}
