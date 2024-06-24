import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/controllers/forgot_password.dart';
import 'package:mobile_atma_kitchen/views/login.view.dart';

class ChangePassword extends StatefulWidget {
  final String? token;
  const ChangePassword({super.key, this.token});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isSubmit = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode
              .onUserInteraction, // Add this line for error handling
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0), // Add space here
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong!";
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20), // Add space here
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong!";
                    } else if (password.text != confirmPassword.text) {
                      return "Password tidak sama";
                    }
                    return null;
                  },
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Enter your confirm password',
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isSubmit = true;
                    });
                    final res = await forgotPasswordController().changePassword(
                        password.text, confirmPassword.text, widget.token!);
                    if (res.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: ((context) => Login())),
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
