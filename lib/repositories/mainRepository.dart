//import 'dart:math';

import 'package:fima/models/loginObject.dart';
import 'package:fima/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

User user;

abstract class RepositoryOne {
  Future<LoginObject> fetchUserCredentials(String username, String password);
  Future<LoginObject> registerNewUser(User user);
}

class CredentialRepository extends RepositoryOne {
  @override
  Future<LoginObject> fetchUserCredentials(String username, String password) {
    return Future.delayed(Duration(seconds: 1), () async {
      final userDatabase = Hive.box('users');

      for (int i = 0; i < userDatabase.length; i++) {
        print("Database is having some users: ${userDatabase.length}");

        var dbuser = userDatabase.getAt(i);

        if (username == dbuser['username'] &&
            password == dbuser['userPassword']) {
          print("Username: " + dbuser["username"]);
          print("User password: " + dbuser["userPassword"]);
          userValid = true;
          tempUser.userID = dbuser["userID"];
          tempUser.username = dbuser["username"];
          tempUser.userType = dbuser["userType"];
          tempUser.userPassword = dbuser["userPassword"];
          tempUser.phone = dbuser["phone"];
          tempUser.country = dbuser["country"];
          tempUser.farmName = dbuser["farmName"];
          tempUser.streetVillage = dbuser["streetVillage"];
          tempUser.townCity = dbuser["townCity"];
          tempUser.email = dbuser["email"];
          break;
        }
      }
      return LoginObject(bol: userValid, user: tempUser);
    });
  }

  @override
  Future<LoginObject> registerNewUser(User user) {
    return Future.delayed(Duration(seconds: 1), () async {
      userValid = true;

      final userDatabase = Hive.box('users');
      Map<String, dynamic> newUSer = {
        "username": user.username,
        "userPassword": user.userPassword,
        "userID": user.userID,
        "country": user.country,
        "email": user.email,
        "farmName": user.farmName,
        "phone": user.phone,
        "streetVillage": user.streetVillage,
        "townCity": user.townCity,
        "userType": user.userType
      };
      userDatabase.add(newUSer);

      tempUser = user;

      /*Future<SharedPreferences> prefs = SharedPreferences.getInstance();

      Future<void> setNew() async {
        final SharedPreferences myPrefs = await prefs;
        myPrefs.setBool("old", true);
        if (user.userType == "Farmer") {
          myPrefs.setString("username", user.username);
          myPrefs.setString("usertype", user.userType);
          myPrefs.setString("country", user.country);
          myPrefs.setString("email", user.email);
          myPrefs.setString("farmname", user.farmName);
          myPrefs.setString("street", user.streetVillage);
          myPrefs.setString("town", user.townCity);
          myPrefs.setString("phone", user.phone);
          myPrefs.setString("userpassword", user.userPassword);
          myPrefs.setInt("userId", user.userID);
        } else {
          myPrefs.setString("username", user.username);
          myPrefs.setString("usertype", user.userType);
          myPrefs.setString("userpassword", user.userPassword);
        }
      }

      setNew();*/

      return LoginObject(bol: userValid, user: tempUser);
    });
  }
}

//::::::::::::::::::::::::::::::::Repository for the post liking functionality
abstract class RepositoryTwo {
  Future<int> likeAPost(int userID, int postID);
  Future<int> commentOnPost(String username, int postID, String comment);
}

class LikePostRepository extends RepositoryTwo {
  @override
  Future<int> likeAPost(int userID, int postID) {
    int likes = 0;

    for (int i = 0; i < feedList.length; i++) {
      if (feedList[i].feedID == postID) {
        if (feedList[i].isLikable) {
          feedList[i].numberOfLikes.add(Like(
                userID,
              ));
          feedList[i].isLikable = false;
          likes = feedList[i].numberOfLikes.length;
          break;
        } else {
          likes = feedList[i].numberOfLikes.length;
        }
      }
    }
    print(likes.toString());
    return Future.delayed(Duration(milliseconds: 2), () {
      return likes;
    });
  }

  @override
  Future<int> commentOnPost(String username, int postID, String comment) {
    int comments = 0;

    for (int i = 0; i < feedList.length; i++) {
      if (feedList[i].feedID == postID) {
        feedList[i]
            .comments
            .add(Comment(userName: tempUser.username, comment: comment));
        comments = feedList[i].comments.length;
        break;
      }
    }
    print(comments.toString());
    return Future.delayed(Duration(seconds: 1), () {
      return comments;
    });
  }
}

//::::::::::::::::::::::::::::::::Repository message functionality
abstract class RepositoryThree {
  Future<List<Message>> addMessage(Message msg);
}

class MessageRepo extends RepositoryThree {
  @override
  Future<List<Message>> addMessage(Message msg) {
    return Future.delayed(Duration(milliseconds: 1), () {
      messages.add(msg);

      print("Request recieved");
      return messages;
    });
  }
}

//::::::::::::::::::::::::::::::::Repository for theme changing
abstract class RepositoryFour {
  Future<Brightness> darkenTheme();
}

class ThemeRepository extends RepositoryFour {
  @override
  Future<Brightness> darkenTheme() {
    return Future.delayed(Duration(milliseconds: 1), () {
      //print("Request recieved");
      return Brightness.dark;
    });
  }
}
