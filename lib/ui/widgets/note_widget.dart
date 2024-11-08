import 'package:flutter/material.dart';
import 'package:noteapp/model/note_model.dart';

import '../../core/utils/colors.dart';

class NoteWidget extends StatelessWidget {
  NotesModel notes;
   NoteWidget({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorsManager.lightPurple,

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text(
              notes.headline,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    notes.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.lightGrey,

                    ),

                  ),
                ),
                Spacer(),
                Text(
                 "${notes.time.hour}:${notes.time.minute}${notes.time.hour >= 12 ? "Pm" : "Am"}".toString() ,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGrey,

                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
