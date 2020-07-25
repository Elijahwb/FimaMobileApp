class FeedClass {
  String title;
  String imageUrl;
  String feedInfo;
  List<Like> numberOfLikes;
  int feedID;
  bool isLikable;
  List<Comment> comments;

  FeedClass(
      {this.imageUrl,
      this.title,
      this.comments,
      this.numberOfLikes,
      this.feedInfo,
      this.feedID,
      this.isLikable});
}

class Comment {
  String userName;
  String comment;
  Comment({this.userName, this.comment});
}

class Like {
  int userId;
  Like(this.userId);
}

List<FeedClass> feedList = [
  new FeedClass(
      feedID: 1,
      isLikable: true,
      title: "Coffee Breed",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/coffee.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [
        new Comment(userName: "Musaha", comment: "This is very helpful"),
        new Comment(
            userName: "Musah",
            comment:
                "Where could i really find some the new breed of coffee being talked about?"),
        new Comment(
            userName: "Musah",
            comment: "I can't wait starting on this project"),
        new Comment(userName: "Musaha", comment: "Guys! is this for real?"),
        new Comment(userName: "Musaha", comment: "Some comment"),
      ],
      numberOfLikes: [
        Like(1)
      ]),
  new FeedClass(
      feedID: 2,
      isLikable: true,
      title: "Chicken Rearing",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/chicken.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
  new FeedClass(
      feedID: 3,
      isLikable: true,
      title: "How To Gain From Matooke",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/matooke.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
  new FeedClass(
      feedID: 4,
      isLikable: true,
      title: "How To Rear Goats",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/goats.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
  new FeedClass(
      feedID: 5,
      isLikable: true,
      title: "Tractor Hiring",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/tractor.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
  new FeedClass(
      feedID: 6,
      isLikable: true,
      title: "Make The Most Out Of Cattle",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/cattle.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
  new FeedClass(
      feedID: 7,
      isLikable: true,
      title: "Onion Farming",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/onions.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
  new FeedClass(
      feedID: 8,
      isLikable: true,
      title: "Irish Potatoes",
      imageUrl:
          "https://github.com/Elijahwb/Fima_files/blob/master/images/irish.jpg?raw=true",
      feedInfo:
          "This type of breed is very resistant from many kinds of diseases ands suits the African weather conditions. It feeds on the already available food that we usually feed the local breeds and has a very high productivity rate.",
      comments: [],
      numberOfLikes: []),
];
