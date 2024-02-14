


import 'dart:developer';
import 'package:chat_app/extensions/build_context_extension.dart';
import 'package:chat_app/model/users.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
   RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController= TextEditingController();

  final emailController= TextEditingController();

  final passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            
              CustomTextField(hintText: "Email", isPassword: false, icon: Icons.mail, controller: emailController,),
              CustomTextField(hintText: "Full Name", isPassword: false, icon: Icons.person,controller: nameController),
              CustomTextField(hintText: "Password", isPassword: true, icon: Icons.lock,controller: passwordController),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  registerNewUser();
                },
                 child: Text("Register Now")
                                
                                ),
              ),
        
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text("Already an user? Go to Login")
                ),
          ],
        ),
      ),
    );
  }

  // Future<void> registerNewUser(String email , String password) async{
  Future<void> registerNewUser() async{

    final email = emailController.text;
    final password=passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty){

     await  FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: email , password: password)
      .then((value){
        // iss syntax ka mtlb hai 
        log(value.user!.uid);
        addDataToDatabase(uid: value.user!.uid);
      });
    }
  }

  //Jab required daalte hai tab hum {} brackets daalte hai  
  Future<void> addDataToDatabase({required String uid}) async{

    final user = Users(nameController.text, emailController.text, uid, passwordController.text, true, "say cheese");

    // toJson user vale data 
    await FirebaseFirestore.instance
    .collection('users')
    .add(user.toJson())
    .then((value){
      log("User Created Succesfully");
      context.navigateToScreen(const ChatScreen(),isReplace: true);
    }).catchError((e){
      log("Failed to create user $e");
    });
  }
}