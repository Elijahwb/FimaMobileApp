class User {
  int userID;
  String username;
  String userPassword;
  String userType;
  String email;
  String farmName;
  String streetVillage;
  String townCity;
  String phone;
  String country;

  User(
      {this.username,
      this.userPassword,
      this.userID,
      this.country,
      this.email,
      this.farmName,
      this.phone,
      this.streetVillage,
      this.townCity,
      this.userType});
}

User tempUser = new User();
bool userValid = false;

List<User> userList = [
  new User(username: "musa", userPassword: "musapass", userID: 1),
  new User(username: "wavah", userPassword: "pass", userID: 2),
  new User(username: "juma", userPassword: "jumapass", userID: 3),
];
