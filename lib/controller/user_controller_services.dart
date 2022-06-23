import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pullrequests_projectct/model/user_card_model.dart';

class UserFetchDataServices {
  Stream<List<UserCardModel>?> fetchData() async* {
    Dio dio = Dio();
    List<UserCardModel> userCardModelList = [];
    try {
      final Response response =
          await dio.get('https://24pullrequests.com/users.json');
      if (response.statusCode == 200) {
        for (int i = 0; i < response.data.length; i++) {
          print(i);
          userCardModelList.add(UserCardModel(
              nickName: response.data[i]["nickname"].toString(),
              date:
                  formatDate(response.data[i]["pull_requests"][0]["created_at"])
                      .toString(),
              imagePath:
                  response.data[i]["organisations"][0]["avatar_url"].toString(),
              description: response.data[i]["pull_requests"][0]["body"]));
          yield userCardModelList;
        }
      } else {
        throw DioError;
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response!.data["message"]);
      }
    }
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date.toString().substring(0, 19));
    final formatedDate = DateFormat('yyyy MMM dd h:mm aa').format(parsedDate);
    print(formatedDate);
    return formatedDate;
  }
}
