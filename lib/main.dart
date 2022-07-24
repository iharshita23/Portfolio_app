// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:awesome_app/bg_image.dart';
import 'package:awesome_app/drawer.dart';
import 'package:awesome_app/login_page.dart';
import 'package:awesome_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Awesome App",
    home: Constants.prefs.getBool("loggedIn") == true
    ? HomePage()
    : LoginPage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
    routes: {
      "/login": (context) => LoginPage(),
      "/home": (context) => HomePage(),
    },
   ),
  );
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  var myText = "Change me";
  var url = "https://jsonplaceholder.typicode.com/photos";
  var data;

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async{
    var res = await http.get(Uri.parse(url));
    data = jsonDecode(res.body);
    print(data);
    return data;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome App'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app))
        ],
      ),

       body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            return Center(
              child: Text("Fetch Something"),
            );
            case ConnectionState.active:
            case ConnectionState.waiting:
             return Center(
              child: CircularProgressIndicator(),
             );
             case ConnectionState.done:
             if(snapshot.hasError){
              return Center(
                child: Text("Error Occured"),
              );
             }

        return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(data[index]['title'].toString()),
              subtitle: Text("ID: ${data[index]["id"]}"),
              leading: Image.network(data[index]["url"]),
            ),
          );
        },
        itemCount: data.length,
        );
          }
        }
      ),
      
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myText = _nameController.text;
          setState(() {
          });
        }, 
        child: Icon(Icons.refresh),

        ),
      );
      // body: Center(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         padding: const EdgeInsets.all(8),
      //         alignment: Alignment.center,
      //         width: 100,
      //         height: 100,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               blurRadius: 5,
      //               offset: Offset(2.0,5.0)
      //             )
      //           ],
      //           color: Colors.teal,
      //           gradient: LinearGradient(colors:[Colors.blue, Colors.pink])
      //         ),
      //         child: Text("My Box 1",
      //         textAlign: TextAlign.center,
      //          style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //          ),
      //          ),
      //       ),
      //       Container(
      //         padding: const EdgeInsets.all(8),
      //         alignment: Alignment.center,
      //         width: 100,
      //         height: 100,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               blurRadius: 5,
      //               offset: Offset(2.0,5.0)
      //             )
      //           ],
      //           color: Colors.teal,
      //           gradient: LinearGradient(colors:[Colors.yellow, Colors.pink])
      //         ),
      //         child: Text("My Box 2",
      //         textAlign: TextAlign.center,
      //          style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //          ),
      //          ),
      //       ),
      //       Container(
      //         padding: const EdgeInsets.all(8),
      //         alignment: Alignment.center,
      //         width: 100,
      //         height: 100,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               blurRadius: 5,
      //               offset: Offset(2.0,5.0)
      //             )
      //           ],
      //           color: Colors.teal,
      //           gradient: LinearGradient(colors:[Colors.green, Colors.pink])
      //         ),
      //         child: Text("My Box 3",
      //         textAlign: TextAlign.center,
      //          style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20,
      //          ),
      //          ),
      //       ),
      //     ],
      //   ),
      // ),
  /*
child: Card(
            child: Column(
              children:<Widget> [
                BgImage(),
                  SizedBox(
                    height:20,
                    ),
                  Text(myText,style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height:20,
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter something here",
                      labelText: "Name",
                    ),
                  ),
                  )
              ],
            ),
          ),

  */
  }
}

