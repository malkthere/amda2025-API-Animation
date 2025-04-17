import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MovieSearchApp());
}

class MovieSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Info Finder',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MovieSearchPage(),
    );
  }
}

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  Map<String, dynamic>? _movieData;
  String _error = '';

  Future<void> _fetchMovie() async {
    final String title = _titleController.text.trim();
    final String year = _yearController.text.trim();
    final String apiKey = '9a4290dc'; // Replace with your OMDb key
    final String url =
        'https://www.omdbapi.com/?t=${Uri.encodeComponent(title)}&y=$year&apikey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['Response'] == 'True') {
        setState(() {
          _movieData = data;
          _error = '';
        });
      } else {
        setState(() {
          _movieData = null;
          _error = data['Error'] ?? 'Movie not found';
        });
      }
    } catch (e) {
      setState(() {
        _movieData = null;
        _error = 'Failed to fetch movie data.';
      });
    }
  }

  Widget _buildMovieInfo() {
    if (_movieData == null) return SizedBox();

    return Card(
      margin: EdgeInsets.only(top: 20),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_movieData!['Title']} (${_movieData!['Year']})',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('📅 Released: ${_movieData!['Released']}'),
            Text('🎭 Genre: ${_movieData!['Genre']}'),
            Text('🎬 Actors: ${_movieData!['Actors']}'),
            Text('🌍 Language: ${_movieData!['Language']}'),
            SizedBox(height: 10),
            Text('📝 Plot:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_movieData!['Plot']),
            SizedBox(height: 10),
            Text('⭐ IMDb Rating: ${_movieData!['imdbRating']}'),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Info Finder')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Movie Title'),
            ),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchMovie,
              child: Text('Search'),
            ),
            if (_error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _error,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            _buildMovieInfo(),
          ],
        ),
      ),

    );
  }
}
