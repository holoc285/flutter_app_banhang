
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class DashBoardWidget extends StatefulWidget {
  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  Future<ListSanPham> _fetchAPI() async {
    final response = await http
        .get('https://holoc.herokuapp.com/api/service/Getsanphammoinhat.php');
    if (response.statusCode == 200) {
      return ListSanPham.fromJSON(json.decode(response.body));
    } else
      throw Exception('Failed to load api');
  }

  var _listImage = [
    "https://cdn.tgdd.vn/2019/06/banner/800-300-800x300-(11).png",
    "https://cdn.tgdd.vn/2019/06/banner/Oppo-f11-hot-800-300-800x300-(1).png",
    "https://cdn.tgdd.vn/2019/06/banner/Hotsale-realme-800-300-800x300.png",
    "https://cdn.tgdd.vn/2019/06/banner/laptopcuoituan-800-300-800x300.png"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Menu'),
            leading: Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {})
            ],
          ),
          drawer: Container(
            margin: EdgeInsets.fromLTRB(0, 50, 100, 40),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('User 1'),
                  accountEmail: Text('abc@test.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.white30
                            : Colors.white,
                    child: Text(
                      "A",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Danh muc'),
                  onTap: null,
                ),
                ListTile(
                  title: Text('San pham'),
                  onTap: () {}),
              
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                  height: 200.0,
                  child: Carousel(
                    images: [
                      NetworkImage(_listImage[0]),
                      NetworkImage(_listImage[1]),
                      NetworkImage(_listImage[2]),
                      NetworkImage(_listImage[3]),
                    ],
                    dotSize: 8.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.white,
                    indicatorBgPadding: 15.0,
                    dotBgColor: Colors.grey.withOpacity(0.3),
                    // borderRadius: true,
                  )),
              Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Sản phẩm mới nhất', style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),)),
              Expanded(
                child: FutureBuilder<ListSanPham>(
                  future: _fetchAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data.list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.all(10),
                              elevation: 5,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: ClipRect(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Image.network(
                                            snapshot.data.list[index].hinhanh,
                                            fit: BoxFit.contain,
                                          ),
                                          Banner(
                                              message: 'New',
                                              location: BannerLocation.topEnd),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        color: Colors.grey.withOpacity(0.2),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data.list[index].tensp,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5,),
                                              Text(
                                                  '${formatMoney(snapshot.data.list[index].giasp)} VND',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                  )
                                ],
                              ));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatMoney(value) {
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: double.parse(value));
    return fmf.output.withoutFractionDigits;
  }
}