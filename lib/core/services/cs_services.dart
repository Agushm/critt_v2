part of 'services.dart';

class CSService extends BaseServices {
  static CSService instance = CSService();

  Future<List<CustomerService>?> getListCS(BuildContext context,
      {int? bankID, String? nameAccount, String? bankNumber}) async {
    var res = await request(
      Api.cs,
      RequestType.GET,
      context,
      useToken: true,
    );
    print("URL=>${Api.cs}");
    if (res["status"] == "success") {
      List<CustomerService> load = [];
      res['data'].forEach((e) => load.add(CustomerService.fromJson(e)));
      return load;
    } else {
      return null;
    }
  }
}
