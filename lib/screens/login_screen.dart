



import 'package:chat_app/extensions/build_context_extension.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/styles/constant_styles.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login", style:titleTextStyle,),

          //Email Vala Box
          CustomTextField(hintText: "Email", isPassword: false, icon:Icons.email,controller: emailController,),
          CustomTextField(hintText: "Password", isPassword: true, icon:Icons.lock,controller: passwordController,),

          ElevatedButton(onPressed: () {
          loginUser();
          },
          child: Text("Login")),

          GestureDetector(
            onTap: (){
              context.navigateToScreen(RegistrationPage(), isReplace: true);
            },
            child: Text("new user ?  create new account")
            ),


        ],
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
    .signInWithEmailAndPassword(
      email: emailController.text, password: passwordController.text)
    .then((value) {
      context.navigateToScreen(ChatScreen(), isReplace: true);
    });
  }
}

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//         obscureText: true,
    
//         decoration: InputDecoration(
//           suffixIcon: Icon(Icons.visibility),
//           prefixIcon: Icon(Icons.email,color: Colors.amber,),
    
//           hintText: "Email",
    
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10))
//           ),
    
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Colors.blue ,width: 2),
//           ),
    
//           errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.red,width: 2),
//           ),
//         ),
//       ),
//     );
//   }
// }