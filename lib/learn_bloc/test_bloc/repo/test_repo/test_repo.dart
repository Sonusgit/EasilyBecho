import 'package:easilybecho/core/network/services/api_model.dart';

abstract class TestRepo {
  Future<ApiModel> getProductData();
  Future<ApiModel> postData();
}