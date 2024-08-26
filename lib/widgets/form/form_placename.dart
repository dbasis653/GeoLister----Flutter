import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  const MyForm(
      {super.key, required this.formKey, required this.onSaveFunction});
  final GlobalKey<FormState> formKey;
  final Function(String) onSaveFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Place Name'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().length < 2) {
                  return 'Please Enter a valid place name with more than one character';
                }
                return null;
              },
              onSaved: (newValue) => onSaveFunction(newValue!),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
