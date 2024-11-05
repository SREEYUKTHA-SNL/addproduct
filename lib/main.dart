import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddItemPage(),
    );
  }
}

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  List<Map<String, String>> categories = [];

  void dialogbox({int? index}) {
    TextEditingController categorynamecontroller = TextEditingController();
    TextEditingController categorydescriptioncontroller =
        TextEditingController();

    if (index != null) {
      categorynamecontroller.text = categories[index]['categoryname']??'';
      categorydescriptioncontroller.text = categories[index]['description']??'';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
             
              children: [
                TextField(
                  controller: categorynamecontroller,
                  decoration: InputDecoration(labelText: 'Enter category name'),
                ),
                TextField(
                  controller: categorydescriptioncontroller,
                  decoration:
                      InputDecoration(labelText: 'Enter category description'),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: () {
                    setState(() {
                      if(index==null){
                   categories.add({
                        'categoryname': categorynamecontroller.text,
                        'description': categorydescriptioncontroller.text
                      });
                    }
                    else{
                      categories[index]={
                        'categoryname':categorynamecontroller.text,
                        'description':categorydescriptioncontroller.text,

                      };
                    }
                    });
                  },
                  child: Text(index==null?'add':'update'))
            ],
          );
        });
  }
  void delete(int index){
    setState(() {
      categories.removeAt(index);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Added items'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index]['categoryname']??''),
              subtitle: Text(categories[index]['description']??''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    dialogbox(index: index);
                  }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      delete(index);
                    }, icon: Icon(Icons.delete))
                ],
              ),
            );

          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogbox();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
