import 'package:flutter/material.dart';

class ContractInputFormCancellation extends StatefulWidget {
  const ContractInputFormCancellation({super.key});

  @override
  State<ContractInputFormCancellation> createState() =>
      _ContractInputFormCancellationState();
}

class _ContractInputFormCancellationState
    extends State<ContractInputFormCancellation> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController cancellationReasonController =
      TextEditingController();
  final TextEditingController cancellationDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contract Cancellation Form'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Cancellation Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Cancellation Reason
              TextFormField(
                controller: cancellationReasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for Cancellation',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the reason for cancellation';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Cancellation Date
              TextFormField(
                controller: cancellationDateController,
                decoration: const InputDecoration(
                  labelText: 'Cancellation Date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cancellation date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Cancellation Details Saved')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
