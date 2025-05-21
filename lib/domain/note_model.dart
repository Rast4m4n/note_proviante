import 'package:json_annotation/json_annotation.dart';
part 'note_model.g.dart';

@JsonSerializable()
final class NoteModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toMap() => _$NoteModelToJson(this);

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
  }) => NoteModel(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: $content, createdAt: $createdAt)';
  }
}
