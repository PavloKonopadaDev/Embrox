import 'dart:convert';
import 'package:embrox_test_app/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV Show List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TVShowList(),
    );
  }
}

class TVShowList extends StatefulWidget {
  @override
  _TVShowListState createState() => _TVShowListState();
}

class _TVShowListState extends State<TVShowList> {
  List _tvShows = [];
  bool _isLoading = false;

  Future<List> _fetchTVShows(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$searchTerm'));

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _tvShows = json.decode(response.body);
      });
    } else {
      setState(() {
        _isLoading = false;
        _tvShows = [];
      });
    }

    return _tvShows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Show List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                if (value.length >= 2) {
                  _fetchTVShows(value);
                } else {
                  setState(() {
                    _tvShows = [];
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Search TV Shows',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _tvShows.isEmpty
                    ? Center(
                        child: Text('Type the show\'s name'),
                      )
                    : ListView.builder(
                        itemCount: _tvShows.length,
                        itemBuilder: (BuildContext context, int index) {
                          final tvShow = _tvShows[index]['show'];
                          return ListTile(
                            leading: tvShow['image'] != null
                                ? Image.network(
                                    tvShow['image']['medium'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.image),
                            title: Text(tvShow['name']),
                            subtitle: Text(tvShow['rating'] != null
                                ? 'Rating: ${tvShow['rating']['average']}'
                                : 'No rating'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TVShowDetails(tvShow),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
