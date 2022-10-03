import 'package:equatable/equatable.dart';

class Issue extends Equatable {
  const Issue({
    required this.id,
    required this.title,
    required this.number,
    required this.state,
    required this.url,
    this.visited = false,
  });

  factory Issue.fromJSON(Map<String, dynamic> json) => Issue(
        id: json['id'] as String,
        title: json['title'] as String,
        number: json['number'] as int,
        state: json['state'] as String,
        url: json['url'] as String,
      );

  Issue copyWith({required bool visited}) {
    return Issue(
      id: id,
      title: title,
      number: number,
      state: state,
      url: url,
      visited: visited,
    );
  }

  final String id;
  final String title;
  final int number;
  final String state;
  final String url;
  final bool visited;

  @override
  List<Object?> get props => [
        id,
        title,
        number,
        state,
        url,
        visited,
      ];
}
