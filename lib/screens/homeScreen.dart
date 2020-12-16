import 'package:flutter/material.dart';
import 'package:newsapp/services/channelServices.dart';
import 'package:newsapp/utils/passArguments.dart';
import '.././global/appStrings.dart';
import '.././global/colors.dart';
import '.././models/newsModel.dart';
import '.././services/newsServices.dart';
import '.././utils/screenUtils.dart';
import '.././widgets/commonwidgets.dart';
import '.././widgets/newsWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currVal = 1;
  int dataToCall = 8;
  ScrollController _scrollController = ScrollController();

  String _currText = 'in';
  List<String> _locations = ['Popular', 'Newest', 'Oldest'];
  String _selectedLocation;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<GroupModel> _group = [
    GroupModel(text: "India", code: "in", index: 1),
    GroupModel(text: "Usa", code: "us", index: 2),
    GroupModel(text: "Japan", code: "jp", index: 3),
    GroupModel(text: "Poland", code: "pl", index: 4),
    GroupModel(text: "Hong Kong", code: "hk", index: 5),
  ];
  @override
  void initState() {
    super.initState();
    _addDataOnScroll();
  }

  _addDataOnScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchAdditionalPost();
      }
    });
  }

  void fetchAdditionalPost() {
    dataToCall = dataToCall + 10;
    HomeScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0XFFF5F9FD),
      appBar: AppBar(
        title: Text(App.MyNews),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on_outlined),
            onPressed: () {
              scaffoldKey.currentState.showBottomSheet((context) => Container(
                    height: getScrennheight(context, .5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(App.ChooseLocation),
                        ),
                        Divider(),
                        Expanded(
                            child: Container(
                          height: 350.0,
                          child: Column(
                            children: _group
                                .map((t) => RadioListTile(
                                      title: Text("${t.text}"),
                                      groupValue: _currVal,
                                      value: t.index,
                                      onChanged: (val) {
                                        setState(() {
                                          _currVal = t.index;
                                          _currText = t.code;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ))
                                .toList(),
                          ),
                        )),
                      ],
                    ),
                  ));
            },
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: VideoSearch());
              }),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  App.TopheadLines,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "Sort: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      hint: Text('Popular'),
                      value: _selectedLocation,
                      onChanged: (newValue) =>
                          setState(() => _selectedLocation = newValue),
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            child: FutureBuilder(
              future: getChannel(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var myData = snapshot.data[index];
                      return Container(
                        decoration: BoxDecoration(),
                        child: GestureDetector(
                          onTap: () {
                            print(index);
                            Navigator.pushNamed(context, "/ChannelDetail",
                                arguments: NewsChannelName(
                                  name: myData.name,
                                  description: myData.description,
                                  url: myData.url,
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF303F60),
                            ),
                            child: Center(
                              child: Text(myData.name.toString(),
                                  style:
                                      TextStyle(color: ColorPlate.WhiteColor)),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getData(dataToCall, _currText),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var myData = snapshot.data[index];
                      return getNewsDataWidget(context, myData);
                    },
                    controller: _scrollController,
                  );
                } else {
                  return iLoderWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(4.0),
      child: Text(message.toString(),
          maxLines: 3, style: TextStyle(color: ColorPlate.BlackColor)),
    ),
  );
}

class GroupModel {
  String text;
  int index;
  String code;
  GroupModel({this.text, this.code, this.index});
}

class VideoSearch extends SearchDelegate<Articles> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty
        ? searchValue
        : searchValue
            .where((u) =>
                (u.title.toLowerCase().contains(query.toLowerCase()) ||
                    u.source.toLowerCase().contains(query.toLowerCase())))
            .toList();
    return myList.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/nosearch.png",
                  height: 80, color: Color(0xFFCFD4DC)),
              Text("No result Found"),
            ],
          ))
        : ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 70),
            shrinkWrap: true,
            itemCount: myList.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              var myData = myList[index];
              return getNewsDataWidget(context, myData);
            },
          );
  }
}
