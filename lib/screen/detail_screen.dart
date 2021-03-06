import 'dart:ui';
import 'package:epic_seven_device/model/model_movie.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final Movie? movie;

  const DetailScreen({this.movie});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    super.initState();
    like = widget.movie!.like;
  }

  @override
  Widget build(BuildContext context) {
    print('build detail screen');
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.movie!.poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.1),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  child: Image.network(widget.movie!.poster),
                                  height: 300,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  child: const Text(
                                    '99% dlfcl 2019 15+ ?????? 1???',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Text(
                                    widget.movie!.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(Icons.play_arrow),
                                        Text('??????'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(widget.movie!.toString()),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    '??????: ??????, ????????? \n?????????: ?????????, ?????????',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  )),
                ],
              ),
              Container(
                color: Colors.black26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {setState(() {
                          like = !like;
                          widget.movie?.reference.update({'like': like});
                        });},
                        child: Column(
                          children: <Widget>[
                            like ? Icon(Icons.check) : const Icon(Icons.add),
                            const Padding(padding: EdgeInsets.all(5)),
                            const Text(
                              '?????? ?????? ?????????',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        child: Column(
                          children: const <Widget>[
                            Icon(Icons.thumb_up),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              '??????',
                              style: TextStyle(fontSize: 11, color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        child: Column(
                          children: const <Widget>[
                            Icon(Icons.send),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              '??????',
                              style: TextStyle(fontSize: 11, color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
