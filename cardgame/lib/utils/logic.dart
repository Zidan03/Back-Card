class Game{
  final String hiddenCardpath = 'assets/logo_colorfull.jpg';
  List<String>? gameImg;

  // make card list
  final List<String> cards_list = [
    "assets/hexagon.jpg",
    "assets/rectangle.jpg",
    "assets/triangle.jpg",
    "assets/rectangle.jpg",
    "assets/triangle.jpg",
    "assets/hexagon.jpg",
    "assets/triangle.jpg",
    "assets/triangle.jpg",
    "assets/hexagon.jpg",
    "assets/hexagon.jpg",
    "assets/rectangle.jpg",
    "assets/rectangle.jpg",
  ];

  final int cardCount = 12;
  List<Map<int, String>> matchCheck = [];

  void initGame(){
    gameImg = List.generate(cardCount, (index)=>hiddenCardpath);
  }
}