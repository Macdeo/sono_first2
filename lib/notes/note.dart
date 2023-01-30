import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './add_note.dart';
import './appbar_section.dart';
import './edit_note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './colors.dart';

class Notes extends StatelessWidget {
  Notes({Key? key}) : super(key: key);

// create an object to read data from your Cloud forestore
// your document is arranged by 'time' which is a timestamp or else the document will be scattered

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("notes")
      // .orderBy("time", descending: true)
      // .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Notes'),
          backgroundColor: const Color(0XFF6f67f0),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              // changes the screen to the add note page
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddNote()));
            },
          ),
        ),
        body: NotesSection(ref: ref));
  }
}

class NotesSection extends StatelessWidget {
  const NotesSection({
    Key? key,
    required this.ref,
  }) : super(key: key);

  final Query<Map<String, dynamic>> ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // color: const Color(0xff252525),
      child: Column(
        children: [
          // const NoteAppBar(),
          const SizedBox(height: 15.0),
          Expanded(
            child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return MasonryGridView.count(
                      crossAxisCount: 3,
                      itemCount:
                          snapshot.hasData ? snapshot.data?.docs.length : 0,
                      itemBuilder: (context, index) {
                        return NoteTile(
                          ref: ref,
                          noteColor: noteColors[index % 7],
                          docToEdit: snapshot.data!.docs[index],
                          title: snapshot.data?.docs[index]['title'],
                          date: snapshot.data?.docs[index]['date'],
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile(
      {required this.ref,
      required this.docToEdit,
      required this.title,
      required this.date,
      required this.noteColor,
      Key? key})
      : super(key: key);

  final DocumentSnapshot docToEdit;
  final String title;
  final String date;
  final Color noteColor;
  final Query ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNote(
                      docToEdit:
                          docToEdit, //docToEdit is passed from the notetile to the edit note page
                      ref: ref,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
            color: noteColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
