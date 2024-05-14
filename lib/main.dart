import 'package:flutter/material.dart';
import "package:flutter_application_2/src/constructor.dart";
import "package:flutter_application_2/src/llamado.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsListScreen(),
    );
  }
}

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> _news;

  @override
  void initState() {
    super.initState();
    _news = NewsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New news",
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black, 
      ),


      backgroundColor: Color.fromARGB(255, 13, 10, 27),
      body: FutureBuilder<List<News>>(
        future: _news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final news = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    news.urlToImage,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: news.title, 
                      style: TextStyle(color: Colors.white), 
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: news.source, 
                      style: TextStyle(color: Colors.blue), 
                    ),
                  ),
                  onTap: () {
                    _openNewsUrl(context, news.url);
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No se encontraron noticias'));
          }
        },
      ),
    );
  }

  void _openNewsUrl(BuildContext context, String url) {
    // Reemplaza esta función para abrir el enlace en el navegador.
    print('Abriendo URL: $url');
  }
}
