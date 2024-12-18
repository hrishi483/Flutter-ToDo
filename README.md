
Interview Questions and Answers 🎯
1. What is this project about?
Answer: "This project is a To-Do list application built using Flutter. It allows users to add, update, delete, and search tasks, store them in an SQLite database, and manage task completion states with a checkbox. It also supports time-based task reminders using a Time Picker feature."

2. Why did you choose Flutter for this project?
Answer: "I chose Flutter because it allows me to create a cross-platform application efficiently with a single codebase. Its widget-based architecture makes UI development fast and highly customizable. Additionally, Dart's asynchronous capabilities help manage database operations smoothly."

3. How did you implement the database for storing tasks?
Answer: "I used SQLite as the local database. I created a helper class DBHelper to handle operations such as inserting, querying, updating, and deleting tasks. I also integrated the sqflite package to interact with the database."

4. How does the search functionality work?
Answer: "The search functionality filters tasks in real time. I implemented a listener on the TextEditingController of the search bar, which dynamically filters tasks based on the input text. For efficient searching, the database query can also be used to fetch only matching records. Tasks for each user will rarely scale up to the level where database querying will add significant latency, so I loaded all the user tasks into the RAM and then implemented string matching for them. However if there is a need I have few alternatives with me:
   --  Debouncing Input:Debouncing ensures the function is not called on every keystroke but only after a short delay (e.g., 300ms). This prevents unnecessary database queries.
   --  Full-Text Search with SQLite:SQLite supports full-text search (FTS), which is optimized for searching text in large datasets. You can create a virtual table with FTS5 to speed up search queries."

6. How did you manage the UI layout for task display?
Answer: "I used Flutter widgets like ListView, ListTile, and CircleAvatar to display tasks. Each task shows a title, time, and a checkbox. The UI is wrapped inside a container with padding and uses a responsive design for a clean look."

7. What challenges did you face while working on this project?
Answer: "One challenge was handling time formatting when working with TimeOfDay and SQLite. Since TimeOfDay is not directly storable in SQLite, I converted it into a string before saving and parsed it back while retrieving data. Another challenge was ensuring that the UI updates dynamically after every database operation."

8. How did you ensure the app data persists after restarting?
Answer: "I used SQLite to store tasks persistently. Even after the app restarts, the data is retrieved from the database and displayed using a query in the initState method of the main widget."

9. How would you improve this app in the future?
Answer: "In the future, I would add notifications for tasks using local notifications, integrate Firebase for cloud sync, allow users to categorize tasks into different lists, and implement dark mode for better user experience."

10. How does the Drawer (sidebar) work in this app?
Answer: "I implemented the Drawer using Flutter's Drawer widget. It opens using a menu button on the AppBar. The Scaffold.of(context).openDrawer() method is used to trigger the drawer programmatically."

11. How did you handle task completion in the app?
Answer: "Each task has a boolean isDone attribute, which tracks its completion state. I used a checkbox (Icons.check_box or Icons.check_box_outline_blank) to update this value and marked completed tasks with a strikethrough using TextDecoration.lineThrough."
