// import 'package:demo_bloc/business_logic/blocs/form/form_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';

// class SubmitButton extends StatelessWidget {
//   const SubmitButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FormBloC, DemoFormState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return ElevatedButton(
//           onPressed: state.status.isValidated
//               ? () => context.read<FormBloC>().add(FormSubmitted())
//               : null,
//           child: const Text('Submit'),
//         );
//       },
//     );
//   }
// }
