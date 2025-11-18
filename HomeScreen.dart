import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController addController = TextEditingController();

  TextEditingController editController = TextEditingController();

  List<String> names = [
    'Ayesha',
    'Amna',
    'Areeba',
    'Zarmeen',
    'Asma',
  ];

  void addItems() {
    String text = addController.text;
    if (text.isNotEmpty) {
      setState(() {
        names.add(text);
      });
      addController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Value cant be empty',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void removeItem(int myIndex) {
    setState(() {
      names.removeAt(myIndex);
    });
  }

  void editItem(int myIndex) {
    editController.text = names[myIndex];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          shape: LinearBorder(),
          title: Text('Edit Item'),
          content: TextField(
            controller: editController,
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  names[myIndex] = editController.text;
                });
                Navigator.pop(context);
              },
              color: Colors.cyan,
              child: Text('Save'),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.cyan,
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        shadowColor: Colors.grey,
        elevation: 5,
        toolbarHeight: 75,
        title: TextField(
          controller: addController,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            hintText: 'Enter your friend name....',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              addItems();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              backgroundColor: Colors.cyan,
              shape: const LinearBorder(),
            ),
            child: const Text(
              'Add Value',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: ListTile(
              tileColor: Colors.cyanAccent,
              title: Text(names[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      editItem(index);
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      removeItem(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
