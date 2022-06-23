import 'package:flutter/material.dart';
import 'package:pullrequests_projectct/controller/user_controller_services.dart';
import 'package:pullrequests_projectct/helpers/constant_styles.dart';
import 'package:pullrequests_projectct/model/user_card_model.dart';
import 'package:pullrequests_projectct/view/screen_login/screen_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';

class ScreenDash extends StatelessWidget {
  ScreenDash({Key? key}) : super(key: key);

  UserFetchDataServices userFetchDataServices = UserFetchDataServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final sharedprefs = await SharedPreferences.getInstance();
                  await sharedprefs.setBool('isLoggedIn', false);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => ScreenLogin(),
                      ),
                      (route) => false);
                },
                icon: Icon(Icons.logout)),
          ],
          title: Text('Dash'),
        ),
        body: StreamBuilder<List<UserCardModel>?>(
            stream: userFetchDataServices.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error.toString()} occurred',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Card(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    snapshot.data![index].imagePath!.toString(),
                                    width: 30.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    snapshot.data![index].nickName!,
                                    style: normalTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    height: 20,
                                    child: Text(
                                      snapshot.data![index].description ??
                                          'No description found',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(snapshot.data![index].date!,
                                      style: normalTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox();
                }
              } else {
                return Shimmer.fromColors(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 10.h,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          );
                        }),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey);
              }
            }),
      ),
    );
  }
}
