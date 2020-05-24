import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:yournews/model/article_model.dart';
import 'package:http/http.dart' as http;

class News{

 List<ArticleModel> news = [];

 Future<void> getNews() async {
 String url="http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=f7ffc5e64c244ecb91fdd0b5b886739d";
 var response= await http.get(url);
 var jsonData= jsonDecode(response.body);
  if(jsonData['status']=="ok"){
    jsonData["articles"].forEach((element){
    if(element["urlToImage"] != null && element["description"] != null){
     ArticleModel articleModel=ArticleModel(
      title: element["title"],
      author: element["author"],
      description: element["description"],
      url: element["url"],
      urlToImage: element["urlToImage"],
      content: element["content"]

     );
     news.add(articleModel);
    }
    });
  }
 } 
}

class CategoryNewsClass{
  
 List<ArticleModel> news = [];

 Future<void> getNews(String category) async {
 String url="https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=f7ffc5e64c244ecb91fdd0b5b886739d";
 var response= await http.get(url);
 var jsonData= jsonDecode(response.body);
  if(jsonData['status']=="ok"){
    jsonData["articles"].forEach((element){
    if(element["urlToImage"] != null && element["description"] != null){
     ArticleModel articleModel=ArticleModel(
      title: element["title"],
      author: element["author"],
      description: element["description"],
      url: element["url"],
      urlToImage: element["urlToImage"],
      content: element["content"]

     );
     news.add(articleModel);
    }
    });
  }
 } 
}