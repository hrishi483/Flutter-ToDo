# ToDo

## Overview
This Flutter-based To-Do Application allows users to manage their tasks efficiently. It provides features such as adding, updating, deleting, and searching tasks. All tasks are stored locally using SQLite, ensuring persistence.

## Features
- **Add New Task**: Users can add tasks with a title, time, and status.
- **Mark as Complete**: Tasks can be marked as complete/incomplete.
- **Search Functionality**: Users can search tasks based on the title.
- **Persistent Storage**: SQLite database is used to store tasks.
- **Time Picker**: Users can select a time for each task using a `TimePicker` widget.
- **Responsive UI**: The app features a responsive and interactive user interface.
- **Drawer Integration**: A navigation drawer is added for better usability.

---

## Project Setup
Follow these steps to set up the project locally:

1. **Install Flutter**
   - Ensure Flutter SDK is installed on your machine.
   - Verify installation:
     ```bash
     flutter doctor
     ```
2. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```
3. **Install Dependencies**
   Run the following command to fetch the required packages:
   ```bash
   flutter pub get
   ```

4. **Run the App**
   Start the app using:
   ```bash
   flutter run
   ```

---

## Code Structure

### 1. **Database Management**
The database operations are handled using the `DBHelper` class, which performs CRUD (Create, Read, Update, Delete) operations using SQLite.

#### `DBHelper` Class
- `addToDO(ToDo todo)`: Adds a new task to the database.
- `getAllToDos()`: Fetches all tasks stored in the database.
- `updateToDo(ToDo todo)`: Updates an existing task.
- `deleteToDo(int id)`: Deletes a task based on its ID.

Example Usage:
```dart
DBHelper dbHelper = DBHelper.getInstance;
await dbHelper.addToDO(todo: ToDo(id: '1', todoText: 'Task 1', startTime: TimeOfDay.now(), isDone: false));
```

---

### 2. **Model**
The `ToDo` class serves as a model for representing tasks.

#### `ToDo` Class:
```dart
class ToDo {
  String id;
  String? todoText;
  TimeOfDay startTime;
  bool isDone;

  ToDo({required this.id, this.todoText, required this.startTime, this.isDone = false});
}
```

---

## Future Improvements
- **Notifications**: Integrate local notifications to remind users of tasks.
- **Due Dates**: Add functionality to set and manage task due dates.
- **Categories**: Allow tasks to be organized into categories.
- **Dark Mode**: Add support for light and dark themes.
- **Animations**: Include subtle animations for better user experience.
- **Backup & Restore**: Enable cloud sync for tasks.

---


---

## Dependencies
- `sqflite`: SQLite database integration.
- `path_provider`: To determine database path.
- `flutter`: Core Flutter SDK.

Add these to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.0.0+4
  path_provider: ^2.0.11
```

---

## Conclusion
This To-Do application demonstrates efficient task management using Flutter and SQLite. The project is modular, scalable, and provides a solid foundation for future improvements.

Feel free to continue upgrading the app using the outlined **Future Improvements** section!
