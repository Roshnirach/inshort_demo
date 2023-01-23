import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inshorts_app/Model/data_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier {
  News news = News(category: '', data: [], success: false);

  bool isLoading = false;

  getMyData() async {
    isLoading = true;

    news = await getAllData();

    isLoading = false;
    notifyListeners();
  }

  Future<News> getAllData() async {
    try {
      String selectedCategory = await getStringFromSharedPreferences();

      final response = await http.get(Uri.parse(
          "https://inshortsapi.vercel.app/news?category=$selectedCategory"));

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        news = News.fromJson(item);
        notifyListeners();
      } else {}
    } catch (e) {
      log(e.toString());
    }

    return news;
  }

  Future<String> getStringFromSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('selectedCategory') ?? "national";
  }
}
