import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_botton.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String,String> formData ={};

  void _onSubmitTap() {

    /*
    if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }
    
        if (_formKey.currentState != null) {
      _formKey.currentState!.validate();
    }

    또는 _formKey.currentState?.validate();     이거 한 줄로 해도됨.
    */

    if (_formKey.currentState != null) {
      if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();

          Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const InterestsScreen()));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (value) {
                  return null;
                },
                 onSaved: (newValue) {
                  
                  if(newValue != null)
                  {
                    formData['password'] = newValue;
                  }
                 },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
                validator: (value) {
                  return null;
                },
                 onSaved: (newValue) {
                  //validator에서 null 이 안들어온경우.
                  if(newValue != null)
                  {
                    formData['password'] = newValue;
                  }
                 },              ),
              Gaps.v28,
              GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(disabled: false)),
            ],
          ),
        ),
      ),
    );
  }
}
