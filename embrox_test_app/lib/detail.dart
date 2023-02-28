import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TVShowDetails extends StatelessWidget {
  final dynamic _tvShow;

  TVShowDetails(this._tvShow);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tvShow['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tvShow['image'] != null
                ? Image.network(
                    _tvShow['image']['medium'],
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _tvShow['name'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                _tvShow['genres'].join(', '),
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    _tvShow['rating'] != null
                        ? '${_tvShow['rating']['average']}/10'
                        : 'No rating',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            _tvShow['officialSite'] != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: ElevatedButton(
                      child: Text('View on TVMaze'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebView(
                              initialUrl: _tvShow['officialSite'],
                              javascriptMode: JavascriptMode.unrestricted,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Text("EMPTY"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Status: ${_tvShow['status']}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Text(
                'Schedule: ${_tvShow['schedule']['days'].join(', ')} at ${_tvShow['schedule']['time']}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _tvShow['summary'] != null
                    ? _tvShow['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                    : 'No summary',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
