// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roko_app1/services/auth_methods.dart';

class SignupFirstScreen extends StatefulWidget {
  const SignupFirstScreen({super.key});

  @override
  State<SignupFirstScreen> createState() => _SignupFirstScreenState();
}

class _SignupFirstScreenState extends State<SignupFirstScreen> {
  final formKey = GlobalKey<FormState>();
  bool _phoneNumberCorrect = false;
  final TextEditingController phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              const Image(
                height: 250,
                image: AssetImage("assets/sign_up/sms_code.jpg"),
              ),
              Text(
                'Registration',
                style:const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Add your phone number. We\'ll send you a verification code',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38
                ),
              ),
              const SizedBox(height: 30,),
              Form(
                key: formKey,
                child: TextFormField(
                  style: const TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold
                  ),
                  onChanged: (value){
                    setState(() {
                      phoneNumber.text = value;
                    });
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    focusedErrorBorder:const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    prefixIcon: Container(
                      padding:const EdgeInsets.all(14.0),
                      child:const Text(
                        "🇲🇦 +212",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    suffixIcon: _phoneNumberCorrect
                        ? const  Icon(Icons.done,color: Colors.green,)
                        : null,
                  ),
                  validator: (value){
                    var reg = RegExp(r"^\d+$");
                    if(value!.isEmpty) {
                      return 'registration Phone Number Empty';
                    }else if(value.length < 9){
                      return "Phone number must be 9 digit or more ";
                    }else if(!reg.hasMatch(value)){
                      return 'registration Phone Number Invalid';
                    }
                    setState(() {
                      _phoneNumberCorrect = true;
                    });
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 40,),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.2,
                child: ElevatedButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      String userPhoneNumber = "+212${phoneNumber.text.trim()}";
                       AuthMethods().signIn(
                    context: context,
                    phoneNumber: userPhoneNumber,
                  );
                    }
                  },
                  child: Text(
                    'SEND',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}