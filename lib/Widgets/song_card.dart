import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final String name;
  final String artist;
  final String album;
  final int index;
  final Function deleteHandler;

  SongCard({this.name, this.artist, this.album,this.index,this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.11,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.008,
        horizontal: size.width * 0.015,
      ),
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(size.height * 0.02),
        gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor.withOpacity(0.3),
          Theme.of(context).primaryColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
            stops: [0.6,1]
        ),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.35),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3))
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            child: Icon(
              Icons.music_video,
              color: Colors.black87,
              size: 50,
            ),
            top: size.height * 0.0125,
          ),
          Positioned(
            child: Container(
              width: size.width*0.58,
              child: Text(
                name,
                style:
                    TextStyle(color: Color.fromRGBO(20, 51, 51, 1), fontSize: 25),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            left: size.width * 0.17,
            top: size.height * 0.01,
          ),
          Positioned(
            child: Container(
              width: size.width * 0.58,
              child: Text(
                artist + " - " + album,
                style: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1), fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            left: size.width * 0.18,
            top: size.height * 0.045,
          ),
          Positioned(
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                deleteHandler(index);
              },
            ),
            top: size.height * 0.01,
            right: 0,
          )
        ],
      ),
    );
  }
}
