enum Gender { male, female }

enum Times {
  notmuch,
  little,
  medium,
  many,
  somany,
}

Map<Times, String> listTimesString = {
  Times.notmuch: 'Not Much',
  Times.little: 'Little',
  Times.medium: 'Medium',
  Times.many: 'Many',
  Times.somany: 'So Many',
};

Map<Gender, String> listGenderString = {
  Gender.male: 'Male',
  Gender.female: 'Female',
};
