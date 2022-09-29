import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('url here');
  return compute(parsePhotos, response.body);
}

// A function that will convert a response body into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody);
  return (parsed["data"]["categoryList"] as List)
      .map<Photo>((json) => new Photo.fromJson(json))
      .toList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new FutureBuilder<List<Photo>>(
      future: fetchPhotos(new http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new PhotosList(photos: snapshot.data)
            : new Center(child: new CircularProgressIndicator());
      },
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return new Stack(
      children: <Widget>[
        new Positioned(
            child: new Container(
              child: new ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (context,int){
              return new Text(photos[int].title);
            }
           ),
          )
        ),
        new ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context,int){
              return new CachedNetworkImage(imageUrl: photos[int].url);
            }
        ),
      ],
    );
  }
}

class Photo {
  final int catID;
  final String title;
  final String url;
  final String thumbnailUrl;
  final String description;
  final String webstiteURL;

  Photo(
      {this.catID,
      this.title,
      this.url,
      this.thumbnailUrl,
      this.description,
      this.webstiteURL});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo(
      catID: json['category_id'] as int,
      title: json['category_name'] as String,
      url: json['category_img'] as String,
      thumbnailUrl: json['thumb_img'] as String,
      description: json['description'] as String,
      webstiteURL: json['website_url'] as String,
    );
  }
}