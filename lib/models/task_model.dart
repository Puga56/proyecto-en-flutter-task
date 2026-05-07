import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.date,
    this.isCompleted = false,
  });

  TaskModel copyWith({bool? isCompleted}) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      date: date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
