//import 'package:flutter/material.dart';
//import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
////void main() => runApp(MyApp());
//
//void main() => runApp(ListInsideCard());
//
//class NewApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Kuch Nai Hora'),
//        ),
//        body: SafeArea(
////          child: StreamBuilder(
////            stream: Firestore.instance.collection('test').snapshots(),
////            builder: (context, snapshot) {
////              if (!snapshot.hasData) {
////                return Text('Data is been loaded...');
////              }
////              return Column(
////                children: <Widget>[
////                  Text(snapshot.data.documents[0]['brandname']),
////                  Text(snapshot.data.documents[0]['sold'].toString()),
////                ],
////              );
////            },
////          ),
//          child: ListPage(),
//        ),
//      ),
//    );
//  }
//}
//
//class ListPage extends StatefulWidget {
//  @override
//  _ListPageState createState() => _ListPageState();
//}
//
//class _ListPageState extends State<ListPage> {
//  Future getData() async {
//    var firestore = Firestore.instance;
//    QuerySnapshot qn = await firestore
//        .collection("FirstYearx")
//        .document("basicbiolab")
//        .collection("files")
//        .getDocuments();
//    return qn.documents;
//  }
//
//  navigateToDetail(DocumentSnapshot file) {
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) => MyApp(
//                  file: file,
//                )));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: FutureBuilder(
//        future: getData(),
//        builder: (_, snapshot) {
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Center(
//              child: Text('Loading...'),
//            );
//          } else {
//            return ListView.builder(
//                itemCount: snapshot.data.length,
//                itemBuilder: (_, index) {
//                  return ListTile(
//                    onTap: () => navigateToDetail(snapshot.data[index]),
//                    title: Text(snapshot.data[index].data["fname"]),
//                  );
//                });
//          }
//        },
//      ),
//    );
//  }
//}
////
////class DetailsPage extends StatefulWidget {
////  final DocumentSnapshot file;
////  DetailsPage({this.file});
////  @override
////  _DetailsPageState createState() => _DetailsPageState();
////}
////
////class _DetailsPageState extends State<DetailsPage> {
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        title: Text(widget.file.data["fname"]),
////      ),
////      body: Container(
////        child: Card(
////          child: ListTile(
////            title: Text(widget.file.data["fname"]),
////            subtitle: Text(widget.file.data["fname"]),
////          ),
////        ),
////      ),
////    );
////  }
////}
//
//class MyApp extends StatefulWidget {
//  final DocumentSnapshot file;
//  MyApp({this.file});
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  bool _isLoading = true;
//  PDFDocument document;
//
//  @override
//  void initState() {
//    super.initState();
//    loadDocument();
//  }
//
//  loadDocument() async {
//    document = await PDFDocument.fromURL(widget.file.data["furl"].toString());
//
//    setState(() => _isLoading = false);
//  }
////
////  changePDF(value) async {
////    setState(() => _isLoading = true);
////    if (value == 1) {
////      document =
////          await PDFDocument.fromAsset('assets/Aviral_Agarwal_9919103144.pdf');
////    } else if (value == 2) {
////      document = await PDFDocument.fromURL(
////          "https://firebasestorage.googleapis.com/v0/b/solve-case123.appspot.com/o/file%2FFirstYear%2Fbasicbiolab%2FBTBiotech_RevMay18.pdf?alt=media&token=fa23a7fd-fca3-4c26-b91d-72a0bbc71456");
////    } else {
////      document =
////          await PDFDocument.fromAsset('assets/Aviral_Agarwal_9919103144.pdf');
////    }
////    setState(() => _isLoading = false);
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
////        drawer: Drawer(
////          child: Column(
////            children: <Widget>[
////              SizedBox(height: 36),
////              ListTile(
////                title: Text('Load from Assets'),
////                onTap: () {
////                  changePDF(1);
////                },
////              ),
////              ListTile(
////                title: Text('Load from URL'),
////                onTap: () {
////                  changePDF(2);
////                },
////              ),
////              ListTile(
////                title: Text('Restore default'),
////                onTap: () {
////                  changePDF(3);
////                },
////              ),
////            ],
////          ),
////        ),
//        appBar: AppBar(
//          title: const Text('FlutterPluginPDFViewer'),
//        ),
//        body: Center(
//            child: _isLoading
//                ? Center(child: CircularProgressIndicator())
//                : PDFViewer(document: document)),
//      ),
//    );
//  }
//}
//
//class ListInsideCard extends StatefulWidget {
//  @override
//  _ListInsideCardState createState() => _ListInsideCardState();
//}
//
//class _ListInsideCardState extends State<ListInsideCard> {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Login / Signup"),
//        ),
//        body: Padding(
//          padding: const EdgeInsets.all(30.0),
//          child: Container(
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(30),
//              color: Colors.white,
//              boxShadow: [
//                BoxShadow(color: Colors.green, spreadRadius: 2),
//              ],
//            ),
//            child: new Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Container(
//                  child: Center(
//                    child: Text(
//                      'Hello',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(fontSize: 30.0),
//                    ),
//                  ),
//                ),
//                Container(
//                  height: 500.0,
//                  color: Colors.red,
//                  child: new ListView(
//                    scrollDirection: Axis.vertical,
//                    children: <Widget>[
//                      new ListTile(
//                        title: Text('Hello'),
//                        subtitle: Text('Hey there'),
//                        leading: Icon(Icons.video_library),
//                      ),
//                      new Padding(padding: new EdgeInsets.all(5.00)),
//                      new RaisedButton(
//                        onPressed: null,
//                        child: new Text("Google"),
//                      )
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
