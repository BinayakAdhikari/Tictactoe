import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/ui/home_presenter.dart';
import 'package:flutter_tic_tac_toe/ui/game_page.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomePresenter _presenter;

  _HomePageState() {
    _presenter = HomePresenter();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("TicTacToe!", style: TextStyle(fontSize: 20,color: Colors.deepOrange),),
          Text("#",style: TextStyle(fontSize: 250,color: Colors.orange,),),
          Center(
            child: ButtonTheme(
              minWidth: 200,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.deepOrangeAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage(widget.title))
                  );
                },
                child: Text("Start New game!", style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
          ),
          StreamBuilder(
              stream: _presenter.buildVictoriesStream(),
              builder: (context, snapshot) {
                var playerCount = _presenter.getVictoryCountFromStream(snapshot);
                if (playerCount <= 0) {
                  return Text("No AI wins yet!", style: TextStyle(fontSize: 15,color: Colors.deepOrangeAccent ));
                }

                return Text("Number of AI wins: $playerCount", style: TextStyle(fontSize: 25,color: Colors.orangeAccent));
          }),

        ],
      ),
    );
  }
}
