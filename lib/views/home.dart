import 'package:flutter/material.dart';
import 'package:yournews/helper/data.dart';
import 'package:yournews/helper/news.dart';
import 'package:yournews/model/article_model.dart';
import 'package:yournews/model/category_model.dart';
import 'package:yournews/views/category_news.dart';
import 'article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel>  articles=new List<ArticleModel>();
  bool _loading=true;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }

  getNews() async{
    News newsClass= News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Text("Your"),
         Text("News", style:TextStyle(
           color:Colors.blue),)
       ], 
      ),
      elevation: 0.0,
      ),
      body: _loading ? Center(
       child: Container(
         child: CircularProgressIndicator(

         ),
        ),
      ):SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            ///categories
            children: <Widget>[
              Container(
                
                height: 70,
               child: ListView.builder(
                 itemCount: categories.length,
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context,index){
                   return CategoryTile(
                   imageUrl: categories[index].imageUrl,
                   categoryName: categories[index].categoryName,
                   );  
                 }), 
              ),
              /// Blogs
              Container(
                padding: EdgeInsets.only(top:16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                       title: articles[index].title, 
                       desc: articles[index].description,
                       url: articles[index].url,
                       );
                       
                  }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final  imageUrl, categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> CategoryNews(
            category: categoryName..toLowerCase(),
          )
        
        ));
      },
        child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imageUrl, 
                height: 120, width: 60,
                fit: BoxFit.cover,)),
          Container(
            alignment: Alignment.center,
            height: 120,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black
            ),
            child: Text(categoryName,
            style: TextStyle(color:Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.w500
            ),
          ),)
          ],
        ),
      ),
    );
  }
}

//Blog tile
class BlogTile extends StatelessWidget {

  final String imageUrl, title ,desc,url;

  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> ArticleView(
            blogUrl:url,
          )));
          },
        child: Container(
        margin: EdgeInsets.only(bottom:16),
        child: Column(
         children: <Widget>[
           ClipRRect(
             borderRadius: BorderRadius.circular(6),
             child: Image.network(imageUrl)),
           SizedBox(height: 8,),
           Text(title, style: 
           TextStyle(
             fontSize: 17,
             fontWeight: FontWeight.w500,
             color: Colors.black87
           ),),
           SizedBox(height: 8,),
           Text(desc,
           style: TextStyle(
              color: Colors.black54
           ),)
         ],
       ), 
      ),
    );
  }
}