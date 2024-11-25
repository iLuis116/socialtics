import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instoo/models/user.dart';
import 'package:instoo/providers/user_provider.dart';
import 'package:instoo/resources/firestore_methods.dart';
import 'package:instoo/screens/comments_screen.dart';
import 'package:instoo/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;

  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  bool isLoading = true;
  int commentLength = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .get();
    commentLength = snap.docs.length;

    setState(() {});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Define el ancho máximo para la tarjeta
        double cardWidth = constraints.maxWidth > 800
            ? 600 // Ancho máximo en pantallas grandes
            : constraints.maxWidth *
                0.9; // Usar 90% del ancho en pantallas pequeñas

        return Center(
          child: Container(
            width: cardWidth,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 39, 144, 134),
                  Color.fromARGB(255, 42, 52, 69),
                  Colors.blue
                ],
                stops: [1, 0.3, 1],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                // Header Section
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                      .copyWith(right: 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(widget.snap['profImage']),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.snap['username']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              backgroundColor: Colors.white,
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shrinkWrap: true,
                                children: [
                                  'Borrar',
                                ]
                                    .map(
                                      (e) => InkWell(
                                        onTap: () async {
                                          await FirestoreMethods().deletePost(
                                              widget.snap['postId']);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 16,
                                          ),
                                          child: Text(
                                            e,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.more_vert,
                        ),
                      ),
                    ],
                  ),
                ),

                // Image Section
                GestureDetector(
                  onDoubleTap: () async {
                    await FirestoreMethods().likeImage(
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['likes'],
                    );
                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio:
                            16 / 9, // Relación de aspecto fija para imágenes
                        child: Image.network(
                          widget.snap['postUrl'],
                          fit: BoxFit.contain, // Escalar sin distorsionar
                        ),
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                          child: Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                            size: 120,
                          ),
                          isAnimating: isLikeAnimating,
                          duration: Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Like Comment Section
                Row(
                  children: [
                    LikeAnimation(
                      isAnimating: widget.snap['likes'].contains(user.uid),
                      smallLike: true,
                      child: IconButton(
                        onPressed: () async {
                          await FirestoreMethods().likeImage(
                            widget.snap['postId'],
                            user.uid,
                            widget.snap['likes'],
                          );
                        },
                        icon: widget.snap['likes'].contains(user.uid)
                            ? Icon(
                                Icons.thumb_up,
                                color: Colors.yellowAccent,
                              )
                            : Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              snap: widget.snap,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.comment_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_outlined,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Description & Number of Comments
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.snap['likes'].length} likes',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 8),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: '${widget.snap['username']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlueAccent),
                              ),
                              TextSpan(
                                text: '  ${widget.snap['description']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.lightGreenAccent),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                snap: widget.snap,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            'Comentarios ${commentLength}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.lightGreenAccent,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          DateFormat.yMMMd().format(
                            widget.snap['datePublished'].toDate(),
                          ),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
