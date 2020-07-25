part of 'useractivity_bloc.dart';

abstract class UseractivityEvent extends Equatable {
  const UseractivityEvent();
}

class LogIn extends UseractivityEvent {
  final String username;
  final String password;
  const LogIn({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class LogOut extends UseractivityEvent {
  const LogOut();

  @override
  List<Object> get props => [];
}

class Register extends UseractivityEvent {
  final User user;
  const Register(this.user);

  @override
  List<Object> get props => [user];
}

class UploadUserPhoto extends UseractivityEvent {
  const UploadUserPhoto();

  @override
  List<Object> get props => [];
}

class ChangeUserName extends UseractivityEvent {
  const ChangeUserName();

  @override
  List<Object> get props => [];
}

class ChangeAccountType extends UseractivityEvent {
  const ChangeAccountType();

  @override
  List<Object> get props => [];
}

//::::::::::::::::::::::::::::::::Events for the post liking functionality
abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class LikePost extends FeedEvent {
  final int userID;
  final int postID;
  const LikePost({this.userID, this.postID});

  @override
  List<Object> get props => [userID, postID];
}

class CommentOnPost extends FeedEvent {
  final String username;
  final int postID;
  final String comment;
  const CommentOnPost({this.username, this.postID, this.comment});

  @override
  List<Object> get props => [username, postID, comment];
}

//::::::::::::::::::::::::::::::::Events for message functionality
abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class AddMessage extends MessageEvent {
  final Message msg;
  const AddMessage(this.msg);

  @override
  List<Object> get props => [msg];
}

//::::::::::::::::::::::::::::::::Events for Theme changing
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class DarkenTheme extends ThemeEvent {
  const DarkenTheme();

  @override
  List<Object> get props => [];
}

class DefaultTheme extends ThemeEvent {
  const DefaultTheme();

  @override
  List<Object> get props => [];
}
