class LoginUser {
  String email;
  String id;
  String address;
  String password;
  int age;
  bool isMale;
  LoginUser(
      {this.password,
      this.address,
      this.age,
      this.email,
      this.id,
      this.isMale});
  toMap() {
    return {
      'email': this.email,
      'id': this.id,
      'address': this.address,
      'age': this.age,
      'isMale': this.isMale
    };
  }
}
