class Urls {
  static const String baseUrl =
      'https://backend-production-91e4.up.railway.app';
  // static const String token =
      // 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdXBlckFkbWluQGdtYWlsLmNvbSIsImV4cCI6MTc1MzczMTExMiwiaWF0IjoxNzUzMTI2MzEyfQ.emjb_TARjXdjmACGb7rtvxHj3ce85ZdfI948WdLKajA';

  static const String login = 'https://backend-production-91e4.up.railway.app/login/jwt';
  static const String logout = '$baseUrl/logout';
  static const String userslist ='$baseUrl/users/getAllUsers?sortBy=id&order=dsc';
  static const String checkSession ='$baseUrl/session-check';
  static const String currentUser ='$baseUrl/users/current-user';
  static const String billsLastmonth = '$baseUrl/stock-items/stats';

  static const  token = true;

  // token
  // https://backend-production-91e4.up.railway.app/stock-items/stats
}
