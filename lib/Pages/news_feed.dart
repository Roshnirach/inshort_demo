import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:inshorts_app/Provider/apiProvider.dart';
import 'package:inshorts_app/Pages/categories.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeed extends StatefulWidget {
  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<NewsProvider>(context, listen: false);
    dataProvider.getMyData();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      drawer: Drawer(
        child: navigationlist(),
      ),
      body: SafeArea(
        child: newsProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : PageView.builder(
                itemCount: newsProvider.news.data.length,
                itemBuilder: ((context, index) {
                  final news = newsProvider.news.data[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.3,
                        width: double.infinity,
                        child: Image.network(
                          news.imageUrl,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 20, 8),
                        child: Text(
                          news.title,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 20),
                        child: Text(
                          news.content,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              wordSpacing: 4,
                              height: 1.6),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () => _launchUrl(news.url),
                            child: Stack(children: [
                              ImageFiltered(
                                imageFilter:
                                    ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(news.imageUrl),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0, left: 15),
                                child: Text(
                                  'Tap to read more',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      )
                    ],
                  );
                }),
                controller: controller,
                scrollDirection: Axis.vertical,
              ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Widget navigationlist() {
    return ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text("Side Navigation"),
        ),
        ListTile(
          title: const Text("Home"),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: const Text("Profile"),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: const Text("Categoties"),
          onTap: () {
            Navigator.of(context).pop();

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CategoryScreen()));
          },
        ),
      ],
    );
  }
}
