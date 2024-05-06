

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mobile_atma_kitchen/controllers/forgot_password.dart';
import 'package:mobile_atma_kitchen/views/ubahPassword/change_password_view.dart';
class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  TextEditingController emailController = TextEditingController();
  bool isSubmit = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Input Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value){
                  if(value== null || value.isEmpty){
                    return "Email tidak boleh kosong!";
                  }else if(!EmailValidator.validate(value)){
                    return "Email tidak valid";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                      print("KONTOL");
          
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isSubmit = true;
                      });
                      final res = await forgotPasswordController().sendRequest(emailController.text);
                      if(res.statusCode == 200){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: ((context) => ChangePassword(token: res.data['token'].toString(),))
                        ),);
                      }
                      print("KONTOL");
                      print(res.statusCode);
                      print(res.data['token'].toString());
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
