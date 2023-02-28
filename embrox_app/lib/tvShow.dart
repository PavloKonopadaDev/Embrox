import 'package:embrox_app/detail.dart';
import 'package:embrox_app/http.dart';
import 'package:embrox_app/model.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  List<TVShow> _tvShows = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Search TV shows",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            _searchQuery = value;
            if (_searchQuery.length >= 2) {
              _searchTVShows();
            } else {
              _tvShows = [];
            }
          },
        ),
        centerTitle: true,
      ),
      body: _tvShows.isEmpty
          ? Center(
              child: Text(
                _searchQuery.length < 2
                    ? "Type the show's name"
                    : "Sorry, nothing found with this search",
                style: const TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _tvShows.length,
              itemBuilder: (context, index) {
                final tvShow = _tvShows[index];
                return ListTile(
                  leading: Image.network(tvShow.image),
                  title: Text(tvShow.name),
                  subtitle: Text("Rating: ${tvShow.rating.toStringAsFixed(1)}"),
                  onTap: () => _showDetailsScreen(tvShow),
                );
              },
            ),
    );
  }

  Future<void> _searchTVShows() async {
    try {
      final tvShows = await TVShowsAPI.searchTVShows(_searchQuery);
      setState(() {
        _tvShows = tvShows;
      });
    } catch (e) {
      // Handle error
    }
  }

  void _showDetailsScreen(TVShow tvShow) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsScreen(tvShow),
      ),
    );
  }
}
