import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mylinks_mobile/models.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Find Me On',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SocialLinksPage(title: 'My Links'),
    );
  }
}

class SocialLinksPage extends StatefulWidget {
  const SocialLinksPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SocialLinksPage> createState() => _SocialLinksPageState();
}

class _SocialLinksPageState extends State<SocialLinksPage> {
  int _counter = 0;
  final List<double> timers = <double>[];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  /*Future<List<dynamic>>*/ allUsers() async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    final String? dbUrl = dotenv.env["DB_URL"];
    var url = Uri.https(dbUrl.toString(), '');

    // Await the http get response, then decode the json-formatted response.
    final loopStart = Stopwatch()..start();
    for (var i = 0; i < 10; i++) {
      final timer = Stopwatch()..start();
      final Map<String, List<Map<String, String>>> statements = {
        "statements": [
          {"q": "select * from users"},
        ]
      };
      print(statements.toString());
      var response = await http.post(url, body: convert.jsonEncode(statements));
      timers.add(timer.elapsed.inSeconds.toDouble());
    }
    final double totalTime =
        timers.reduce((value, element) => value + element).toDouble();
    print("average time: ${totalTime / 10}");
    print("total time: ${loopStart.elapsed}");
    // if (response.statusCode == 200) {
    //   var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    //   // var itemCount = jsonResponse['totalItems'];
    //   final returnedData = jsonResponse[0];
    //   // print('Result: $jsonResponse. ++ $returnedData');
    //   if (returnedData["error"] != null) {
    //     final ErrorData errorRes = ErrorData.fromJson(returnedData["error"]);
    //     print(errorRes.message);
    //     return [];
    //   } else {
    //     final SuccessData successRes =
    //         SuccessData.fromJson(returnedData["results"]);
    //     print("rows: ${successRes.rows}");
    //     print("columns: ${successRes.columns}");
    //     return successRes.rows;
    //   }
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    //   return [];
    // }
  }

  @override
  void initState() {
    super.initState();
    allUsers();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SocialLinksPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(),
      // body: FutureBuilder<List<dynamic>>(
      //   future: allUsers(),
      //   builder: (context, snapshot) {
      //     switch (snapshot.connectionState) {
      //       case ConnectionState.none:
      //         return Column(
      //           children: <Widget>[ Expanded( child: Center( child: Container( child: Text("Flexing!"), ), ), )], );
      //       case ConnectionState.active:
      //         return Text("active");
      //       case ConnectionState.waiting:
      //         return Text("waiting");
      //       case ConnectionState.done:
      //         if (snapshot.hasError){
      //           return Center(
      //             child: Column(children: [Text("Something went wrong!")],),
      //           );
      //         }else if(snapshot.hasData){
      //           const users = snapshot.data;
      //           ListView.builder(
      //             itemCount: allUsers(),
      //             itemBuilder: (BuildContext context, int i){
      //             return ListTile(
      //               leading: Text(),
      //               title: Text(),
      //               trailing: (),
      //             );
      //           });
      //         }
      //     }
      //     return Center();
      // }),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
