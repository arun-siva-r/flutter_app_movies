class MovieListDetails {
  late String title;
  late String year;
  late String imdbID;
  late String type;
  late String poster;

  MovieListDetails(
      {required this.title,
      required this.year,
      required this.imdbID,
      required this.type,
      required this.poster});

  MovieListDetails.fromJson(Map<String, dynamic> json) {
    title = json['Title'] ?? '';
    year = json['Year'] ?? '';
    imdbID = json['imdbID'] ?? '';
    type = json['Type'] ?? '';
    poster = json['Poster'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Year'] = year;
    data['imdbID'] = imdbID;
    data['Type'] = type;
    data['Poster'] = poster;
    return data;
  }
}
