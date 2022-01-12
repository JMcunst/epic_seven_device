import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic_seven_device/model/model_movie.dart';
import 'package:epic_seven_device/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('movie')
            .where('like', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          return _buildList(context, snapshot.data!.docs);
        });
  }

  Widget _buildList(BuildContext context,
      List<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    return Expanded(
      child: GridView.count(
        crossAxisSpacing: 4.5,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: const EdgeInsets.all(3),
        children: snapshot.map((e) => _buildListItem(context, e)).toList(),
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot<Map<String, dynamic>> data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.all(10)),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 27, 20, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'images/nflix_logo.png',
                  fit: BoxFit.contain,
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text(
                    '내가 찜한 콘텐츠',
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          _buildBody(context)
        ],
      ),
    );
  }
}
