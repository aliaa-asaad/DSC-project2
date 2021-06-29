import 'package:dsc/Layout/CountriesHandler.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'country_details.dart';

class Countries extends StatefulWidget {
  const Countries({Key key, this.continentKey}) : super(key: key);
  final continentKey;
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<Map>(
            future: CountriesHandler().getCountries(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                List<MapEntry> countries = snapshot.data.entries
                    .where((element) =>
                        element.value['continent'] == widget.continentKey)
                    .toList();
                return ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (BuildContext context, int index) => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      InkWell(
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
                      // IconButton(icon:Icon( Icons.favorite_outline),  onPressed:(){})
                      Positioned(
                          right: 30,
                          top: 20,
                          child: Favorite_icon(
                              countries: countries, index: index)),
                    ],
                  ),
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }),
      ),
    );
  }
}

class Favorite_icon extends StatefulWidget {
  const Favorite_icon({Key key, this.countries, this.index}) : super(key: key);
  final List countries;
  final int index;
  @override
  _Favorite_iconState createState() => _Favorite_iconState();
}

class _Favorite_iconState extends State<Favorite_icon> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          (check) ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () async {
          SharedPreferences pref;
          while (pref == null) pref = await SharedPreferences.getInstance();
          setState(() {
            check = !check;
            List<String> list = [];

            if (pref.containsKey('Favorites'))
              list = pref.getStringList('Favorites');
            pref.setStringList('Favorites', list);

            (check)
                ? list.add(widget.countries[widget.index].value['name'])
                : list.remove(widget.countries[widget.index].value['name']);
            pref.setStringList('Favorites', list);
          });
        });
  }
}
