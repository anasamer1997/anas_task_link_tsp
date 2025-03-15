class EnvironmentVariables {
  EnvironmentVariables._();

  // base url Endpoint
  static String get baseUrl => 'https://rickandmortyapi.com';
  // get Products
  static String get getCharacters => '$baseUrl/api/character/?page=';
}
