// ignore_for_file: unnecessary_string_escapes

const String nameRegex = r'^[a-zA-Z][a-zA-Z0-9 ]{2,15}$';
const String mailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
const String passRegex =
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
