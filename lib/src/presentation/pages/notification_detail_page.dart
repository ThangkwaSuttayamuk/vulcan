import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/presentation/controller/order/order_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationDetailPage extends ConsumerStatefulWidget {
  final dynamic arg;
  const NotificationDetailPage(
    this.arg, {
    super.key,
  });

  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState
    extends ConsumerState<NotificationDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      )),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
            height: 0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    widget.arg['image'],
                    fit: BoxFit.cover,
                    height: 400.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(widget.arg['title'],style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text("⏰ ตั้งแต่วันที่ "+widget.arg['period']),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(widget.arg['description']),
                                ],
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
