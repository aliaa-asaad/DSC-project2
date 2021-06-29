import 'package:dsc/Layout/ContinentsHandlers.dart';
import 'package:dsc/Layout/const.dart';
import 'package:flutter/material.dart';
import 'country_details.dart';
import 'CountriesHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'countries.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int x = 0;
  List list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Countries',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xff64b67b),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: (x == 0)
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('Images/1.jpg'),
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<Map>(
                    future: ContinentsHandler().getContinents(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                            child: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xff64b67b),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data.values.elementAt(index),
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Countries(
                                          continentKey: snapshot.data.keys
                                              .elementAt(index))));
                            },
                          ),
                        );
                      } else
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                    }),
              )
            : FutureBuilder<Map>(
                future: CountriesHandler().getCountries(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<MapEntry> countries = snapshot.data.entries
                        .where(
                            (element) => list.contains(element.value['name']))
                        .toList();
                    return ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountryDetails(
                                      details: countries[index].value)));
                        },
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green[400]),
                          alignment: Alignment.center,
                          child: Text(
                            countries[index].value['name'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_sharp), label: 'Favorite'),
            ],
            currentIndex: x,
            onTap: (index) async {
              SharedPreferences pref;
              if (index == 1)
                while (pref == null)
                  pref = await SharedPreferences.getInstance();
              setState(() {
                x = index;
                if (index == 1) list = pref.getStringList('Favorites');
              });
            }));
  }
}
