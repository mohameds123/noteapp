import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/logic/get_note_cubit/state.dart';
import 'package:noteapp/model/note_model.dart';

class GetNoteCubit extends Cubit<GetNotesState> {
  GetNoteCubit() : super(GetNoteInitialState());

  /// Get Notes
  Future getNotes() async {
    emit(GetNoteLoadingState());

    try {
      final getData =
          await FirebaseFirestore.instance.collection("notes").get();
      final notes = getData.docs
          .map((doc) => NotesModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      emit(GetNoteSuccessState(notes));
    } catch (e) {
      emit(GetNoteErrorState(e.toString()));
    }
  }

  ///

}
