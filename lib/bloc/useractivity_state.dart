part of 'useractivity_bloc.dart';

abstract class UseractivityState extends Equatable {
  const UseractivityState();
}

class UseractivityInitial extends UseractivityState {
  @override
  List<Object> get props => [];
}

class Loading extends UseractivityState {
  const Loading();
  @override
  List<Object> get props => [];
}

class LoggedIn extends UseractivityState {
  final User user;
  const LoggedIn(this.user);
  @override
  List<Object> get props => [user];
}

class LogInFailed extends UseractivityState {
  const LogInFailed();
  @override
  List<Object> get props => [];
}

class LogInError extends UseractivityState {
  final String error;
  const LogInError(this.error);
  @override
  List<Object> get props => [error];
}

class LoggedOut extends UseractivityState {
  const LoggedOut();
  @override
  List<Object> get props => [];
}

class Registered extends UseractivityState {
  const Registered();
  @override
  List<Object> get props => [];
}

//::::::::::::::::::::::::::::::::States for the post liking functionality
abstract class FeedState extends Equatable {
  const FeedState();
}

class FeedInitial extends FeedState {
  @override
  List<Object> get props => [];
}

class PostLiked extends FeedState {
  final int likes;
  const PostLiked(this.likes);
  @override
  List<Object> get props => [likes];
}

class LikeAPostError extends FeedState {
  final String error;
  const LikeAPostError(this.error);
  @override
  List<Object> get props => [error];
}

class PostCommented extends FeedState {
  final int comments;
  PostCommented(this.comments);
  @override
  List<Object> get props => [comments];
}

class CommentOnAPostError extends FeedState {
  final String error;
  CommentOnAPostError(this.error);
  @override
  List<Object> get props => [error];
}

//::::::::::::::::::::::::::::::::States for message functionality
abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class UpdatingMessages extends MessageState {
  const UpdatingMessages();
  @override
  List<Object> get props => [];
}

class MessagesInitial extends MessageState {
  final List<Message> msgs;
  const MessagesInitial(this.msgs);
  @override
  List<Object> get props => [msgs];
}

class MessagesUpdated extends MessageState {
  final List<Message> msgs;
  const MessagesUpdated(this.msgs);
  @override
  List<Object> get props => [msgs];
}

//::::::::::::::::::::::::::::::::States for theme changing
abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeDarkened extends ThemeState {
  final Brightness brightness;

  const ThemeDarkened(this.brightness);
  @override
  List<Object> get props => [brightness];
}
