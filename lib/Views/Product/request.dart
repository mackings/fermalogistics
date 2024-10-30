import 'dart:convert';

import 'package:fama/Views/Product/Model/requests.dart';
import 'package:fama/Views/Product/cardrequestwidget.dart';
import 'package:fama/Views/Product/newrequest.dart';
import 'package:fama/Views/Product/reqstatus.dart';
import 'package:fama/Views/Product/widgets.dart';
import 'package:fama/Views/widgets/colors.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Requestproduct extends ConsumerStatefulWidget {
  const Requestproduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestproductState();
}

class _RequestproductState extends ConsumerState<Requestproduct>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeIndex = 0;
  late Future<List<Request>> _futureRequests = Future.value([]);

  dynamic userToken;

  Future<void> _retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);

      String? token = userData['token'];
      Map<String, dynamic> user = userData['user'];

      String? fullName = user['fullName'];
      String? email = user['email'];

      setState(() {
        userToken = userData['token'];
        print(userToken);
      });
    }
  }

  Future<List<Request>> fetchRequests() async {
    final response = await http.get(
      Uri.parse(
          'https://fama-logistics.onrender.com/api/v1/request/getAllRequest'),
      headers: {
        'Authorization': 'Bearer $userToken',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> data = json.decode(response.body)['request'];
      return data.map((json) => Request.fromJson(json)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load requests');
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieveUserData();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
      });
    });
    _initialize();
  }

  Future<void> _initialize() async {
    await _retrieveUserData();
    setState(() {
      _futureRequests =
          fetchRequests(); // Fetch the requests only after the token is loaded
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(text: 'Request Product'),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = constraints.maxWidth > 600
                    ? constraints.maxWidth * 0.8
                    : constraints.maxWidth - 32;

                return Center(
                  child: Container(
                    width: containerWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        controller: _tabController,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        tabs: [
                          CustomTab(
                            title: 'Ongoing',
                            isActive: _activeIndex == 0,
                          ),
                          CustomTab(
                            title: 'Cancelled',
                            isActive: _activeIndex == 1,
                          ),
                          CustomTab(
                            title: 'Completed',
                            isActive: _activeIndex == 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: _tabController != null // Ensure the TabController is initialized
            ? TabBarView(
                controller: _tabController,
                children: [

                  //Tab1

                  FutureBuilder<List<Request>>(
                    // future: _futureRequests,
                    future: _futureRequests != null
                        ? _futureRequests
                        : Future.value([]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return ImageWithText(
                          title: "No Requests Yet",
                          bodyText1:
                              "You don't have any requests yet.",
                          bodyText2: "requests will appear here.",
                          svgPath:
                              '', // Update with appropriate image path if needed
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(height: 5.h),
                              ImageWithText(
                                title: "No Request Yet",
                                bodyText1:
                                    "You haven't placed any request yet,requests",
                                bodyText2: "will be displayed here",
                                svgPath: '',
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final request = snapshot.data![index];

                            return GestureDetector(
                              onTap: () {
                                print(request.status);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => requeststatus(
                                              request: request,
                                            )));
                              },
                              child: RequestCard(
                                title: request.user.fullName,
                                subtitle: '${request.quantity} pcs',
                                leadingIconUrl: request.productImage,
                                dateTimePlaced:
                                    request.createdAt.toLocal().toString(),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),

                  //TAB2

                  // TAB2 - Cancelled Requests
                  FutureBuilder<List<Request>>(
                    future: _futureRequests != null
                        ? _futureRequests
                        : Future.value([]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return ImageWithText(
                          title: "No  Cancelled Requests Yet",
                          bodyText1:
                              "Cancelled requests will appear here.",
                          bodyText2: "",
                          svgPath:
                              '', // Update with appropriate image path if needed
                        );
                      } else if (snapshot.hasData) {
                        final cancelledRequests = snapshot.data!
                            .where((request) => request.status == 'cancelled')
                            .toList();

                        if (cancelledRequests.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(height: 5.h),
                              ImageWithText(
                                title: "No Completed Requests",
                                bodyText1:
                                    "You don't have any completed requests yet.",
                                bodyText2:
                                    "Completed requests will appear here.",
                                svgPath:
                                    '', // Update with appropriate image path if needed
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount: cancelledRequests.length,
                          itemBuilder: (context, index) {
                            final request = cancelledRequests[index];

                            return GestureDetector(
                              onTap: () {
                                print(request.status);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        requeststatus(request: request),
                                  ),
                                );
                              },
                              child: RequestCard(
                                title: request.user.fullName, // Updated field
                                subtitle: '${request.quantity} pcs',
                                leadingIconUrl: request.productImage,
                                dateTimePlaced:
                                    request.createdAt.toLocal().toString(),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),

                  //TAB3

                  FutureBuilder<List<Request>>(
                    future: _futureRequests != null
                        ? _futureRequests
                        : Future.value([]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return ImageWithText(
                          title: "No Completed Requests",
                          bodyText1:
                              "You don't have any completed requests yet.",
                          bodyText2: "completed requests will appear here.",
                          svgPath:
                              '', // Update with appropriate image path if needed
                        );
                      } else if (snapshot.hasData) {
                        final cancelledRequests = snapshot.data!
                            .where((request) => request.status == 'delivered')
                            .toList();

                        if (cancelledRequests.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(height: 5.h),
                              ImageWithText(
                                title: "No Completed Requests",
                                bodyText1:
                                    "You don't have any cancelled requests yet.",
                                bodyText2:
                                    "Cancelled requests will appear here.",
                                svgPath:
                                    '', // Update with appropriate image path if needed
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount: cancelledRequests.length,
                          itemBuilder: (context, index) {
                            final request = cancelledRequests[index];

                            return GestureDetector(
                              onTap: () {
                                print(request.status);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        requeststatus(request: request),
                                  ),
                                );
                              },
                              child: RequestCard(
                                title: request.user.fullName, // Updated field
                                subtitle: '${request.quantity} pcs',
                                leadingIconUrl: request.productImage,
                                dateTimePlaced:
                                    request.createdAt.toLocal().toString(),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              )
            : Container(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: btncolor,
            shape: CircleBorder(),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Newrequest()));
            }),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isActive;

  CustomTab({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CustomText(
          text: title,
          fontSize: 8.sp,
          color: isActive ? Colors.black : Colors.black,
        ),
      ),
    );
  }
}
