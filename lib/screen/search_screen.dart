import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epic_seven_device/model/model_movie.dart';
import 'package:epic_seven_device/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String? _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    List<DocumentSnapshot<Map<String, dynamic>>> searchResults = [];
    for (DocumentSnapshot<Map<String, dynamic>> d in snapshot) {
      if (d.data().toString().contains(_searchText!)) {
        searchResults.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
        mainAxisSpacing: 0.1,
        crossAxisSpacing: 4.5,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: const EdgeInsets.all(3),
        children: searchResults.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot<Map<String, dynamic>> data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
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
          const Padding(padding: EdgeInsets.all(15)),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: TextField(
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 15),
                    autofocus: true,
                    controller: _filter,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white60,
                        size: 20,
                      ),
                      suffixIcon: focusNode.hasFocus
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _filter.clear();
                                  _searchText = "";
                                });
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                              ))
                          : Container(),
                      hintText: '??????',
                      labelStyle: const TextStyle(color: Colors.white),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                focusNode.hasFocus
                    ? Expanded(
                        child: TextButton(
                        child: const Text('??????'),
                        onPressed: () {
                          setState(() {
                            _filter.clear();
                            _searchText = "";
                            focusNode.unfocus();
                          });
                        },
                      ))
                    : Expanded(
                        child: Container(),
                        flex: 0,
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
