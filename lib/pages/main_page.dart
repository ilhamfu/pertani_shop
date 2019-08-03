import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pertani_shop/widgets/sliver_delegate.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Keranjang")),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        ],
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.grey.shade100,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    child: Header(), maxHeight: 50, minHeight: 50),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _NewsCarousel(),
                ]),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  minHeight: 40,
                  maxHeight: 40,
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      color: Colors.green,
                      child: Center(
                        child: Text("Produk Terbaik Kami",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      )),
                ),
              ),
              _TopProductList()
            ],
          ),
        ),
      )),
    );
  }
}

class _TopProductList extends StatefulWidget {
  _TopProductList({Key key}) : super(key: key);

  __TopProductListState createState() => __TopProductListState();
}

class __TopProductListState extends State<_TopProductList> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(3),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return new _ProductItem(index: index);
        }, childCount: 50),
      ),
    );
  }
}

class _ProductItem extends StatefulWidget {
  const _ProductItem({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;
  @override
  __ProductItemState createState() => __ProductItemState();
}

class __ProductItemState extends State<_ProductItem> {
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
  }

  void _doScroll() async {
    await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 3000));
    await Future.delayed(Duration(seconds: 1));
    await _scrollController.animateTo(0,
        curve: Curves.easeOut, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 2, offset: Offset(2, 2))
          ]),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl:
                    "https://picsum.photos/id/${widget.index % 10}/150/200",
              )),
          Positioned.fill(
            child: GestureDetector(
              onLongPress: _doScroll,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black54,
                        Colors.black12,
                        Colors.transparent
                      ],
                          stops: [
                        0.2,
                        0.4,
                        0.9,
                      ])),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Text(
                          "aklsjdlkasjdlkajsdlkaj alksjdlkasjdlkajs lkd alskdjalksjd askdj asl",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class _NewsCarousel extends StatefulWidget {
  const _NewsCarousel({
    Key key,
  }) : super(key: key);

  @override
  __NewsCarouselState createState() => __NewsCarouselState();
}

class __NewsCarouselState extends State<_NewsCarousel> {
  PageController _pageController = PageController();
  double _page = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 40,
            width: double.infinity,
            color: Colors.green,
            child: Center(
              child: Text("Kabar Pertani",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
            )),
        Container(
            width: double.infinity,
            color: Colors.white,
            height: 200,
            child: Stack(children: <Widget>[
              PageView.builder(
                controller: _pageController,
                itemBuilder: (ctx, idx) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: "https://picsum.photos/id/$idx/250/200",
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                Colors.black38,
                                Colors.black12,
                                Colors.transparent
                              ],
                                  stops: [
                                0.2,
                                0.5,
                                0.9
                              ])),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Align(
                              child: Text("This is the $idx news",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              alignment: Alignment.bottomCenter,
                            )),
                      )
                    ],
                  );
                },
                itemCount: 7,
              ),
              Positioned.fill(
                child: _PageIndicator(page: _page),
              )
            ])),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({Key key, this.page}) : super(key: key);
  final double page;
  @override
  Widget build(BuildContext context) {
    List<Widget> output = [];
    for (var i = 0; i < 7; i++) {
      output.add(Container(
          height: 2,
          width: 15,
          decoration: BoxDecoration(
              color: i == page.round() ? Colors.green : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: i == page.round() ? Colors.green : Colors.white,
                    blurRadius: 2)
              ]),
          margin: EdgeInsets.symmetric(horizontal: 2)));
    }
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: output),
    );
  }
}

class Header extends StatefulWidget {
  const Header({Key key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(2, 2, 2, 1),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                border: Border.all(color: Colors.green, width: 3)),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: TextField(
                  maxLines: 1,
                  focusNode: searchFocusNode,
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                  ))),
          !searchFocusNode.hasFocus
              ? Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 2),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green, width: 2)),
                      child: Icon(
                        Icons.chat,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),Container(
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 2),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green, width: 2)),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
