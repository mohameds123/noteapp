import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/core/utils/colors.dart';
import 'package:noteapp/logic/create_note_cubit/cubit.dart';
import 'package:noteapp/logic/create_note_cubit/state.dart';
import 'package:noteapp/model/note_model.dart';

import 'home_screen.dart';


class CreateNoteScreen extends StatelessWidget {
  CreateNoteScreen({super.key});

  TextEditingController headLineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CreateNoteCubit(),
      child: BlocConsumer<CreateNoteCubit, CreateNoteStates>(
        listener: (context, state){
          if(state is CreateNoteSuccessStates){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Note is Created successful")),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(),));

          }else if (state is CreateNoteErrorStates){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage.toString())),
            );
          }
        },
        builder: (context, state){
          return Scaffold(
            backgroundColor: ColorsManager.primaryColor,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Text(
                      "Create New Note ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                    //
                    const SizedBox(
                      height: 22,
                    ),
                    const Text(
                      "Head line",
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
                            style: TextStyle(
                                color: Colors.white
                            ),


                            controller: headLineController,
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
                            "Description",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 192,
                            decoration: BoxDecoration(
                              color: ColorsManager.lightPurple,

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(


                              style: TextStyle(
                                  color: Colors.white
                              ),
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  )


                              ),

                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),

                    InkWell(
                      onTap: () {
                        context.read<CreateNoteCubit>().createNote(
                          NotesModel(
                              description: descriptionController.text,
                              headline: headLineController.text,
                              time: DateTime.now(),
                          )
                        );

                      },
                      child: Container(
                        width: 312,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text("Create",
                            style: TextStyle(
                                color: ColorsManager.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700

                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),


            ),
          );
        },

      ),
    );


  }
}
