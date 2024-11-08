import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/logic/get_note_cubit/cubit.dart';
import 'package:noteapp/logic/get_note_cubit/state.dart';
import 'package:noteapp/ui/screens/create_note_screen.dart';
import 'package:noteapp/ui/screens/login_screen.dart';
import 'package:noteapp/ui/widgets/note_widget.dart';

import '../../core/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNoteCubit()..getNotes(),
      child: Scaffold(
        backgroundColor: ColorsManager.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateNoteScreen()),
                        );
                      },
                      child: Container(
                        width: 164,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Add Note",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InkWell(
                      onTap: ()async {
                       await FirebaseAuth.instance.signOut();
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        width: 164,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<GetNoteCubit, GetNotesState>(
                  builder: (context, state) {
                    if (state is GetNoteLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetNoteSuccessState) {
                      final notes = state.notes;
                      return ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return NoteWidget(notes: note);
                        },
                      );
                    } else if (state is GetNoteErrorState) {
                      print(state.errorMessage);
                      return Center(child: Text('Error: ${state.errorMessage}'));
                    } else {
                      return const Center(child: Text('No notes found'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
