class Task {
  final String id;
  final String title;
  final String date;
  final String description;
  final String responsible;
  final String importance;

  Task(
      {required this.id,
      required this.title,
      required this.date,
      required this.description,
      required this.responsible,
      required this.importance});

  // Convertir a Mapa (Guardar)
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'date': date,
        'description': description,
        'responsible': responsible,
        'importance': importance,
      };

  // Crear desde Mapa (Leer)
  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'],
        title: map['title'],
        date: map['date'],
        description: map['description'],
        responsible: map['responsible'] ?? '',
        importance: map['importance'] ?? 'Media',
      );
}
