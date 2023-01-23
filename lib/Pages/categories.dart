import 'package:flutter/material.dart';
import 'package:inshorts_app/Pages/news_feed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<String> categories = [
    "All",
    "National",
    "Business",
    "Sports",
    "World",
    "Politics",
    "Technology",
    "Startup",
    "Entertainment",
    "Miscellaneous",
    "Hatke",
    "Science",
    "Automobile"
  ];

  String selectedCategory = "National";
  @override
  void initState() {
    getValue();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Category"),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: BorderSide(
                              width: 2,
                              color: (selectedCategory.toLowerCase() ==
                                      categories[index].toLowerCase())
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                        },
                        child: Text(categories[index]));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    saveStringToSharedPreferences(
                        selectedCategory.toLowerCase());
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => NewsFeed()));
                  },
                  child: const Text("Select",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> saveStringToSharedPreferences(String value) async {
    final selectedCategory = await SharedPreferences.getInstance();
    selectedCategory.setString('selectedCategory', value);
  }

  Future<String> getStringFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedCategory') ?? "National";
  }

  getValue() async {
    selectedCategory = await getStringFromSharedPreferences();

    setState(() {});
  }
}
