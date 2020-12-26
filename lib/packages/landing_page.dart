import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool isplaying = false;
  IconData idata = Icons.play_arrow_sharp;
  @override
  Widget build(BuildContext context) {
    AudioPlayer _player;
    AudioCache cache;
    Duration position = new Duration();
    Duration musicLength = new Duration();

    void seektosec(int sec) {
      Duration newpos = new Duration(seconds: sec);
      _player.seek(newpos);
    }

    Widget slider() {
      return Slider.adaptive(
          activeColor: Colors.amber,
          inactiveColor: Colors.black,
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seektosec(value.toInt());
          });
    }

    //pipeline1;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          title: Text(
            "Symphony",
            style: (GoogleFonts.sacramento(fontSize: 30)),
          ),
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey[900],
                    Colors.grey[400],
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset("./lib/pics/album1.png"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "Disclosure",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "Latch",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                  SizedBox(height: 40),
                  slider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.skip_previous_sharp,
                            size: 40,
                          ),
                          onPressed: () {}),
                      IconButton(
                        onPressed: () async {},
                        icon: Icon(
                          idata,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              )),
            )));
  }
}
