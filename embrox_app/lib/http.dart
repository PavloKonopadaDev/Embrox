import 'dart:convert';
import 'package:embrox_app/model.dart';
import 'package:http/http.dart' as http;

class TVShowsAPI {
  static const String _baseUrl = 'https://api.tvmaze.com/search/shows?q=';

  static Future<List<TVShow>> searchTVShows(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl$query'));
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      return jsonList.map((json) => TVShow.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load TV shows');
    }
  }
}
