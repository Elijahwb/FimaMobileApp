import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fima/models/models.dart';
import 'package:fima/repositories/mainRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'useractivity_event.dart';
part 'useractivity_state.dart';

class UseractivityBloc extends Bloc<UseractivityEvent, UseractivityState> {
  final RepositoryOne repository;

  UseractivityBloc(this.repository);

  @override
  UseractivityState get initialState => UseractivityInitial();

  @override
  Stream<UseractivityState> mapEventToState(
    UseractivityEvent event,
  ) async* {
    yield Loading();
    //::::::::::::::::::Logging in
    if (event is LogIn) {
      try {
        final user = await repository.fetchUserCredentials(
            event.username, event.password);
        if (user.bol == false) {
          yield LogInFailed();
        } else if (user.bol == true) {
          yield LoggedIn(user.user);
        }
      } on Error {
        yield LogInError("User credentials may be wrong");
      }
    }
    if (event is Register) {
      try {
        final user = await repository.registerNewUser(event.user);
        if (user.bol == false) {
          yield LogInFailed();
        } else if (user.bol == true) {
          yield Registered();
        }
      } on Error {
        yield LogInError("User credentials may be wrong");
      }
    }
    //::::::::::::::::::::Logging out
    if (event is LogOut) {
      userValid = false;
      Future<SharedPreferences> prefs = SharedPreferences.getInstance();
      Future<void> resetNew() async {
        final SharedPreferences myPrefs = await prefs;
        myPrefs.setBool("old", false);
      }

      resetNew();
      yield UseractivityInitial();
    }
  }
}

//::::::::::::::::::::::::::::::::Bloc for the post liking functionality
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final RepositoryTwo repository;

  FeedBloc(this.repository);

  @override
  FeedState get initialState => FeedInitial();

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    //::::::::::::::::::::Liking post
    if (event is LikePost) {
      try {
        final numberOfLikes =
            await repository.likeAPost(event.userID, event.postID);
        yield PostLiked(numberOfLikes);
      } on Error {
        yield LikeAPostError("Check the internet connection");
      }
    }

    if (event is CommentOnPost) {
      try {
        final nComments = await repository.commentOnPost(
            event.username, event.postID, event.comment);
        yield PostCommented(nComments);
      } on Error {
        yield CommentOnAPostError("Plese check your internet connection");
      }
    }
  }
}

//::::::::::::::::::::::::::::::::Bloc for the messaging functionality
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final RepositoryThree repository;

  MessageBloc(this.repository);

  @override
  MessageState get initialState => MessageInitial();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    yield UpdatingMessages();

    if (event is AddMessage) {
      try {
        final updatedMsgs = await repository.addMessage(event.msg);
        yield MessagesUpdated(updatedMsgs);
      } on Error {}
    }
  }
}

//::::::::::::::::::::::::::::::::Bloc for theme changing
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final RepositoryFour repository;

  ThemeBloc(this.repository);

  @override
  ThemeState get initialState => ThemeInitial();

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    yield ThemeInitial();
    if (event is DarkenTheme) {
      final brightness = await repository.darkenTheme();
      yield ThemeDarkened(brightness);
    }
    if (event is DefaultTheme) {
      yield ThemeInitial();
    }
  }
}
