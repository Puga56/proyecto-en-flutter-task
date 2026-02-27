import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _descController = TextEditingController();
  final _responsibleController = TextEditingController();

  String? _selectedImportance;

final List<String> _importanceLevels = ['Baja', 'Media', 'Alta'];

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descController.dispose();
    _responsibleController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Tarea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    labelText: 'Título', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              
              //Input del responsable
              TextFormField(
                controller: _responsibleController,
                decoration: const InputDecoration(
                    labelText: 'Responsable', 
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline)),
                validator: (v) => v!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: _selectDate,
                decoration: const InputDecoration(
                    labelText: 'Fecha',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today)),
                validator: (v) => v!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: 'Descripción', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),

              //Dropdown de importancia
              DropdownButtonFormField<String>(
                value: _selectedImportance,
                decoration: const InputDecoration(
                  labelText: 'Grado de Importancia',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: _importanceLevels.map((String level){
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState((){
                    _selectedImportance = newValue;
                  });
                },
                validator: (v) => v == null ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newTask = Task(
                        id: DateTime.now().toString(),
                        title: _titleController.text,
                        date: _dateController.text,
                        description: _descController.text,
                        responsible: _responsibleController.text,
                        importance: _selectedImportance ?? 'Media',
                      );
                      context.pop(newTask); // Regresa la tarea nueva
                    }
                  },
                  child: const Text('Guardar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
