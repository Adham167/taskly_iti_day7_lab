import 'package:flutter/material.dart';
import 'package:multi_creen_flutter_app/services/shared_preferences_service.dart';
import 'package:multi_creen_flutter_app/views/home_view.dart';
import 'package:multi_creen_flutter_app/widgets/custom_text_field.dart';

class AccountCreationView extends StatefulWidget {
  const AccountCreationView({super.key});

  @override
  State<AccountCreationView> createState() => _AccountCreationViewState();
}

class _AccountCreationViewState extends State<AccountCreationView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _selectedGender = 'Male';

  void _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      await SharedPreferencesService.saveUserData(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        jobTitle: _jobTitleController.text.trim(),
        address: _addressController.text.trim(),
        gender: _selectedGender,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account saved successfully!')));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeView();
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _jobTitleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Creation Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                message: "First Name",
                controller: _firstNameController,
              ),
              CustomTextField(
                message: "Last Name",
                controller: _lastNameController,
              ),
              CustomTextField(message: "Email", controller: _emailController),
              CustomTextField(
                message: "Job Title",
                controller: _jobTitleController,
              ),
              CustomTextField(
                message: "Address",
                controller: _addressController,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items:
                    ['Male', 'Female']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveAccount,
                child: Text('Save Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
