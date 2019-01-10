import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  ThemeData _themeData;

  _MyAppState({Key key}) : super() {
    _themeData = ThemeData(
      primarySwatch: Colors.blue,
    );
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (++_counter % 16 == 0) {
        _counter = 1;
        _themeData = ThemeData(
            primarySwatch: _themeData.primaryColor == Colors.red
                ? Colors.blue
                : Colors.red);
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyHomePage page = MyHomePage(
        title: "You clicked the FAB $_counter times",
        counter: _counter,
        onFabPressed: _incrementCounter);

    return new MaterialApp(
      title: 'Test',
      theme: _themeData,
      home: page,
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title, this.counter, this.onFabPressed})
      : super(key: key);

  final String title;
  final int counter;
  final VoidCallback onFabPressed;

  Widget buildContent(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 225.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(title),
            background: const Image(
              image: const AssetImage("assets/background.jpg"),
              fit: BoxFit.fill
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Theme.of(context).accentColor.withAlpha(25 * (index % 11)),
                child: Text('grid item $index',
                    style: Theme.of(context).textTheme.body2),
              );
            },
            childCount: 21,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor.withAlpha(25 * (index % 11)),
                child: Text('list item $index',
                    style: Theme.of(context).textTheme.body1),
              );
            },
            childCount: counter + 10,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return new Scaffold(
      body: buildContent(context),
      floatingActionButton: new FloatingActionButton(
        onPressed: onFabPressed,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
