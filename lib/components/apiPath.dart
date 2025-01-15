const baseUrl = "https://fullstack-server-fi54.onrender.com/api/v1";

class ApiPath {
  static const String login = "${baseUrl}/user/login";
  static const String register = "${baseUrl}/user/register";
  static const String checkTable = "${baseUrl}/tables/getOne/";
  static const String getProduct = "${baseUrl}/product/getAll";
  static const String order = "${baseUrl}/order/insert";
  static const String getOrderByUserStatus = "${baseUrl}/order/getBy/";
  static const String updateStatus = "${baseUrl}/order/update/";
  static const String orderDetail = "${baseUrl}/order_detail/insert";
  static const String getOrderDetailBy = "${baseUrl}/order_detail/getBy/";
}
