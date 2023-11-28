import 'dart:convert';
import 'package:birdsolutions_task/services/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/ButtonComponent.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isChecked = false;

  // Create a global key for the Form widget
  final _formKey = GlobalKey<FormState>();

  // Create controllers for email and password text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF5F5FA),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFFF5F5FA),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          backgroundColor: const Color(0xFFF5F5FA),
          elevation: 0,
        ),
        body: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
                decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Tree.png"),
                fit: BoxFit.fill,
              ),
            )),
            Container(
              color: const Color(0xFFF5F5FA).withAlpha(210),
            ),
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24,),
               child: Form(
                 key: _formKey,
                 child: SingleChildScrollView(
                   child: Column(
                    children: [
                      const Text("Welcome Back!", style: TextStyle(fontSize: 22,
                          color: Colors.black),),
                      const SizedBox(height: 2,),
                      const Text("Login to continue Radio App",
                        style: TextStyle(fontSize: 16,
                          color: Colors.black),),
                      const SizedBox(height: 32,),
                      TextFormField(
                        controller: emailController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         filled: true,
                         fillColor: Colors.white,
                         labelStyle: const TextStyle(color: Color(0xFF7377A0),),
                         labelText: "Email Address",
                         prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF7377A0),),
                         enabledBorder: OutlineInputBorder(
                             borderSide: const BorderSide(color: Color(0xFFD2D4D6)),
                             borderRadius: BorderRadius.circular(10),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: const BorderSide(color: Color(0xFFD2D4D6)),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         errorBorder: OutlineInputBorder(
                           borderSide: const BorderSide(color: Colors.red),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         focusedErrorBorder: OutlineInputBorder(
                           borderSide: const BorderSide(color: Colors.red),
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       validator: (value) {
                         if (value == "") {
                           return 'Please enter an email';
                         }
                         return null;
                       },
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Color(0xFF7377A0),),
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF7377A0),),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFD2D4D6)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFFD2D4D6)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         GestureDetector(
                           onTap: (){
                             setState(() {
                               _isChecked = !_isChecked;
                             });
                           },
                           child: Row(children: [
                             Container(
                               height: 20,
                               width: 20,
                               decoration: BoxDecoration(
                                   border: Border.all(color: const Color(0XFFCED0D2)),
                                 borderRadius: BorderRadius.circular(100),
                                 color: Colors.white,
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(4.0),
                                 child: _isChecked? Image.asset("assets/images/check.png") : Image.asset("assets/images/uncheck.png"),
                               ),
                             ),
                             const SizedBox(width: 10,),
                             const Text("Remember me", style: TextStyle(color: Colors.black),),
                           ],),
                         ),
                        TextButton(onPressed: (){},
                            child: const Text("Forgot Password?",
                              style: TextStyle(color: Color(0XFF5D5E6F)),)),
                      ],),
                      const SizedBox(height: 10,),
                      Container(
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(10),),
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(onPressed: ()  async{
                          if(_formKey.currentState!.validate()) {
                            bool loginSuccess = await LoginUser(emailController.text, passwordController.text);
                            if (loginSuccess) {
                              // Showing a Successful message indicating login success
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('Logged in Successfully.', style: TextStyle(color: Colors.white),),
                                ),
                              );

                            } else {
                              // Showing an error message indicating login failure
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Failed to log in. Please check your credentials.', style: TextStyle(color: Colors.white),),
                                ),
                              );
                            }

                          }
                        },
                          style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: const Color(0XFF7A5FC8), // Background color
                          ),
                        child: const Text("Log In",
                          style: TextStyle(color: Colors.white,),),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(child: Text("OR",
                          style: TextStyle(color: Colors.black, fontSize: 16),)),
                      ),
                      const SizedBox(height: 16,),
                      const ButtonComponent(btnTxt: 'Continue with Google',
                        btnColor: Colors.white, txtColor: Colors.black,
                         btnIcon: "assets/images/google.png",),
                      const SizedBox(height: 16,),
                      const ButtonComponent(btnTxt: "Sign In with Apple ID",
                        btnColor: Colors.black, txtColor: Colors.white,
                        btnIcon: "assets/images/apple.png",),
                      const SizedBox(height: 16,),
                      const ButtonComponent(btnTxt: "Continue with Facebook",
                        btnColor: Color(0xFF3a579b), txtColor: Colors.white,
                        btnIcon: "assets/images/facebook-logo.png",),
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical: 4.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                          const Text("Don't have an account?",
                            style: TextStyle(color: Colors.black),),
                          TextButton(onPressed: (){},
                              child: const Text("Sign up",
                                style: TextStyle(color: Color(0XFF6D4EC6)),))

                      ],),
                       ),
                      const Text("By Signing up you indicate that you have read and",
                        style: TextStyle(fontSize: 8),),
                      const Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                        Text("agreed to the Patch",
                          style: TextStyle(fontSize: 8),),
                           SizedBox(width: 4,),
                           Text("Terms of Service",
                             style: TextStyle(fontSize: 8, color:  Color(0XFF6D4EC6)),),
                      ],)
                    ],
            ),
                 ),
               ),
             )
          ],
        ));
  }
}
