class User {
  int userId;
  String lastName;
  String firstName;
  String addressLine1;
  String addressLine2;
  String zipCode;
  String email;
  String city;
  String phoneNumber;
  String token;
  String renewalToken;

  User(
      {this.userId,
      this.lastName,
      this.firstName,
      this.addressLine1,
      this.addressLine2,
      this.email,
      this.city,
      this.phoneNumber,
      this.token,
      this.zipCode,
      this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        lastName: responseData['last_name'],
        firstName: responseData['first_name'],
        addressLine1: responseData['addressLine1'],
        addressLine2: responseData['addressLine2'],
        city: responseData['city'],
        zipCode: responseData['zip_code'],
        email: responseData['email'],
        phoneNumber: responseData['phone_number'],
        token: responseData['access_token'],
        renewalToken: responseData['refresh_token']);
  }

  get getZipCode => this.zipCode;

  set setZipCode(zipCode) => this.zipCode = zipCode;

  get getUserId => this.userId;

  set setUserId(userId) => this.userId = userId;

  get getLastName => this.lastName;

  set setLastName(lastName) => this.lastName = lastName;

  get getFirstName => this.firstName;

  set setFirstName(firstName) => this.firstName = firstName;

  get getAddressLine1 => this.addressLine1;

  set setAddressLine1(addressLine1) => this.addressLine1 = addressLine1;

  get getAddressLine2 => this.addressLine2;

  set setAddressLine2(addressLine2) => this.addressLine2 = addressLine2;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getCity => this.city;

  set setCity(city) => this.city = city;

  get getPhoneNumber => this.phoneNumber;

  set setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;

  get getToken => this.token;

  set setToken(token) => this.token = token;

  get getRenewalToken => this.renewalToken;

  set setRenewalToken(renewalToken) => this.renewalToken = renewalToken;
}
