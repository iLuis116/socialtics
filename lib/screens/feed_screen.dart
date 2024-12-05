import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instoo/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.transparent,
        title: Text("Social Tics"),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.how_to_vote_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 39, 144, 134), // Color 1
              Color.fromARGB(255, 42, 52, 69), // Color 2
              Colors.blue, // Color 3
            ],
            stops: [
              1,
              0.3,
              1
            ], // Controla cómo se distribuyen los colores en el gradiente.
            begin: FractionalOffset.topLeft, // Dirección del gradiente.
            end: FractionalOffset.bottomRight, // Dirección del gradiente.
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ),
      ),
    );
  }
}
