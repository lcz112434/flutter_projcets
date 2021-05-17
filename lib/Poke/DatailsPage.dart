import 'package:flutter/material.dart';

import 'HomeData.dart';



/**
 * <pre>
 *     @author : Lichengze
 *     @e-mail : lcz3466601343@163.com
 *     @time   : 2021/05/14
 *     @desc   :
 *     version : 1.0
 * </pre>
 */
class DetailsBody extends StatelessWidget {
  Pokemon homeData;

  DetailsBody({Key key, @required this.homeData}) : super(key: key);

  Widget bodypage(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 1.5,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 80)),
                  Text(
                    homeData.name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "height:" + homeData.height,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "weight:" + homeData.weight,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "Types",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: homeData.type
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  Text(
                    "weaknesses",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: homeData.weaknesses
                          .map(
                            (e) => FilterChip(
                                backgroundColor: Colors.red,
                                label: Text(e,style: TextStyle(color: Colors.white),),
                                onSelected: (b) {}),
                          )
                          .toList()),
                  Text("Next Evolution",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: homeData.nextEvolution
                        .map((e) => FilterChip(
                            backgroundColor: Colors.blueAccent,
                            label: Text(e.name,style: TextStyle(color: Colors.white),),
                            onSelected: (b) {}))
                        .toList(),
                  )
                ],
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 200.0,
            width: 200.0,
            child: Image.network(homeData.img, fit: BoxFit.cover),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text('${homeData.name}'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: bodypage(context),
    );
  }
}
