import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/welcome_screen.dart';
import '../Widgets/song_card.dart';
import '../constraints.dart';
import '../Components/search.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // album song artist
  List selectedSongs = [];
  List generatedSongs =[];
  int statusCode;
  final String apiUrl = "https://playlist-gene.herokuapp.com/api/Logout";
  bool isLoading;

  deleteUserSong(index) {
    setState(() {
      selectedSongs.removeAt(index);
    });
  }

  deleteGeneratedSongs(index)
  {
    setState(() {
      generatedSongs.removeAt(index);
    });
  }

  removeUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
  }

  apiCall() async {
    final String apiUrl = "https://playlist-gene.herokuapp.com/api/Playlist";
    var apiUri = Uri.parse(apiUrl);
    var params = {
      "maxSongsPerPlaylist": 5,
      "songs": selectedSongs
    };

    setState(() {
      isLoading = true;
      generatedSongs = [];
    });
    http.post(apiUri, body: json.encode(params)).then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        var body= json.decode(response.body);
        int numberOfLists= body["playlists_number"] as int;
        List songsList=body["data"] as List;

        for(int i=0;i<numberOfLists;i++)
          {
            generatedSongs+=songsList[i];
          }
        final jsonList = generatedSongs.map((item) => jsonEncode(item)).toList();
        final uniqueJsonList = jsonList.toSet().toList();
        generatedSongs = uniqueJsonList.map((item) => jsonDecode(item)).toList();
        setState(() {
        });
      }
      else {
        Fluttertoast.showToast(
            msg: "There was an unknown error! Please try again.",toastLength: Toast.LENGTH_LONG);
      }
    });
  }

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.09,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Get my Playlist!",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway',
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    var apiUri = Uri.parse(apiUrl);
                    http.get(apiUri).then((response) {
                      statusCode = response.statusCode;
                      if (statusCode == 200) {
                        Fluttertoast.showToast(msg: "Logged Out successfully");
                        removeUid();
                        Navigator.pushReplacementNamed(
                            context, WelcomeScreen.routeName);
                      } else {
                        Fluttertoast.showToast(
                            msg:
                            "There is some unknown error. Please check your internet connection",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    });
                  },
                  icon: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      bottom: size.height * 0.01,
                    ),
                    child: Icon(Icons.logout),
                  ),
                  color: Colors.white,
                  iconSize: 30,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.02),
                child: Text(
                  "Your picked songs",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, index) {
                  return SongCard(
                    name: selectedSongs[index][1],
                    album: selectedSongs[index][0],
                    artist: selectedSongs[index][2],
                    index: index,
                    deleteHandler: deleteUserSong,
                  );
                },
                childCount: selectedSongs.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        var result = await showSearch(
                          context: context,
                          delegate: Search(),
                        );
                        if (result != null) {
                          List temp = [
                            result[0],
                            result[1],
                            result[2],
                          ];
                          var contain = selectedSongs.where((element) {
                            return element[1] == temp[1];
                          });
                          if (contain.isEmpty) {
                            setState(() {
                              selectedSongs.add(temp);
                            });
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [primaryColor, transPrimaryColor])),
                        child: Text(
                          "Add Songs",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        apiCall();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.07,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [primaryColor, transPrimaryColor])),
                        child: Text(
                          "Get my Playlist",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isLoading ? SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: size.height * 0.4,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
            ) : SliverList(
              delegate: SliverChildBuilderDelegate(
                    (_, index) {
                  return SongCard(
                    index: index,
                    name: generatedSongs[index][1],
                    album: generatedSongs[index][0],
                    artist: generatedSongs[index][2],
                    deleteHandler: deleteGeneratedSongs,
                  );
                },
                childCount: generatedSongs.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
