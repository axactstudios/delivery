//This is the user model used to retrieve the record of user from firebase database.

class User {
  String name;
  String number;
  String addressLine1;
  String addressLine2;
  String pinCode;

  User(
      {this.name,
      this.number,
      this.addressLine1,
      this.addressLine2,
      this.pinCode});
}
