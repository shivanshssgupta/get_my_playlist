import 'package:flutter/material.dart';

import '../Dataset/songs_dataset.dart';

class Search extends SearchDelegate<List> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? songs
        : songs
            .where((element) =>
                element[1].toLowerCase().contains(query.toLowerCase()) &&
                element[1].toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          close(context, suggestions[index]);
        },
        leading: Icon(Icons.music_note),
        title: RichText(
          text: TextSpan(
              text: suggestions[index][1].substring(0, query.length),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
              children: [
                TextSpan(
                    text: suggestions[index][1].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
        subtitle: Text(
          suggestions[index][2] + " - " + suggestions[index][0],
          style: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
        ),
      ),
      itemCount: suggestions.length,
    );
  }
}
