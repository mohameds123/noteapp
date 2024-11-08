import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/utils/colors.dart';
import 'package:noteapp/logic/login_cubit/cubit.dart';
import 'package:noteapp/logic/login_cubit/state.dart';
import 'package:noteapp/ui/screens/home_screen.dart';
import 'package:noteapp/ui/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> LoginCubit(),
      child: Scaffold(
        backgroundColor: ColorsManager.primaryColor,
        body: BlocConsumer <LoginCubit , LoginState>(
          listener: (context, state){
            if (state is LoginSuccessState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login is successful")),
              );
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(),));
            }else if (state is LoginErrorState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state){
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Center(
                    child: Text(
                      "Hi, Welcome Back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                  //
                  const SizedBox(
                    height: 22,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),

                  ),
                  //
                  const SizedBox(height: 10,),

                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // Email
                        TextFormField(
                          style:  TextStyle(
                              color: Colors.white
                          ),

                          controller: emailController,
                          decoration: InputDecoration(

                              fillColor: ColorsManager.lightPurple,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent
                                ),

                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent
                                ),
                              )



                          ),

                        ),
                        //password
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          style:  TextStyle(
                              color: Colors.white
                          ),
                          controller: passwordController,
                          decoration: InputDecoration(
                              fillColor: ColorsManager.lightPurple,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent
                                ),

                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.transparent
                                ),
                              )



                          ),

                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),

                  InkWell(
                    onTap: (){
                      if (formKey.currentState?.validate()??false){
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<LoginCubit>().login(email, password);
                      }


                    },
                    child: Container(
                      width: 312,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: ColorsManager.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700

                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),

                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("Don’t have an account ? ",style: TextStyle(

                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                          },
                          child: Text("SignUp"))
                    ],
                  )


                ],
              ),
            );
          },

        ),

      ),
    );
  }
}
