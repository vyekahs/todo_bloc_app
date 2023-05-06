import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String id;
  final String discrption;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task(
      {required this.title,
      required this.id,
      required this.discrption,
      required this.date,
      this.isDone = false,
      this.isDeleted = false,
      this.isFavorite = false}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? title,
    String? id,
    String? discrption,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      id: id ?? this.id,
      discrption: discrption ?? this.discrption,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'discrption': discrption,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      discrption: map['discrption'] ?? '',
      date: map['date'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props =>
      [title, id, date, discrption, isDone, isDeleted, isFavorite];
}
