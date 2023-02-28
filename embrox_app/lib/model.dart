class TVShow {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String summary;
  final List<String> genres;
  final String status;
  final String link;
  final String schedule;

  TVShow({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.summary,
    required this.genres,
    required this.status,
    required this.link,
    required this.schedule,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['show']['id'],
      name: json['show']['name'],
      image: json['show']['image'] != null ? json['show']['image']['medium'] : "",
      rating: json['show']['rating']['average'] != null ? json['show']['rating']['average'].toDouble() : 0,
      summary: json['show']['summary'] != null ? json['show']['summary'].replaceAll(RegExp('<[^>]*>'), '') : "",
      genres: List<String>.from(json['show']['genres']),
      status: json['show']['status'],
      link: json['show']['url'],
      schedule: json['show']['schedule']['time'] + " " + json['show']['schedule']['days'][0],
    );
  }
}
