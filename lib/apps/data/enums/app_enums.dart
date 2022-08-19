enum Gender { male, female }

enum Times {
  notmuch,
  little,
  medium,
  many,
  somany,
}

enum SignInType { withGoogle, withFacebook, withEmail, none }

Map<Times, String> listTimesString = {
  Times.notmuch: 'Not Much',
  Times.little: 'Little',
  Times.medium: 'Medium',
  Times.many: 'Many',
  Times.somany: 'So Many',
};
Map<String, Times> listTimesEnum = {
  'Not Much': Times.notmuch,
  'Little': Times.little,
  'Medium': Times.medium,
  'Many': Times.somany,
  'So Many': Times.somany,
};
Map<Gender, String> listGenderString = {
  Gender.male: 'Male',
  Gender.female: 'Female',
};
Map<String, Gender> listGenderEnum = {
  'Male': Gender.male,
  'Female': Gender.female,
};

Gender getGender(String value) {
  switch (value) {
    case 'Male':
      return Gender.male;
    case 'Femail':
      return Gender.female;
    default:
      return Gender.female;
  }
}

Times getTimes(String value) {
  switch (value) {
    case 'Not Much':
      return Times.notmuch;
    case 'Little':
      return Times.little;
    case 'Medium':
      return Times.medium;
    case 'Many':
      return Times.many;
    case 'So Many':
      return Times.somany;
    default:
      return Times.somany;
  }
}
