class Task {
  final String id;
  final String title;
  final String date;
  final String description;

  Task({
    required this.id, 
    required this.title, 
    required this.date, 
    required this.description
  });

  // Convertir a Mapa (Guardar)
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'date': date,
    'description': description,
  };

  // Crear desde Mapa (Leer)
  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    date: map['date'],
    description: map['description'],
  );
}