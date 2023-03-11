import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../../../core/constants.dart';
import '../../../../core/local_notification_service.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_cubit.dart';
import '../widgets/order_item_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  void initState() {
    notification(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setDefaultStatusBar();

    OrderCubit orderCubit = OrderCubit.get(context);
    List<Orderr>? orders = orderCubit.orders;
    List<Orderr>? newOrders;
    if (orders != null) {
      newOrders = orders!.where((element) => element.stats == 'new').toList();
    }
    orderCubit.getOrders();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: cultured,
        appBar: defaultAppBar(title: 'Orders', context: context,),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
           if(state is LoadedOrdersState){
             orders=state.orders;
             if (orders != null) {
               newOrders = orders!.where((element) => element.stats == 'new').toList();
             }
           }else if(state is ErrorOrdersState){
              showToast(msg: state.errorMessage, state: ToastStates.error);
           }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: orders != null,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: outerSpace,
                ),
              ),
              builder: (context) => ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>OrderItemView(order: newOrders![index],),
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 16.h,
                ),
                itemCount: newOrders!.length,
              ),
            );
          },
        ),
      ),
    );
  }

  notification(context) {
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        navigateToAndFinish(context,const OrderScreen());

      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        // print(message.notification!.body);
        // print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      navigateToAndFinish(context,const OrderScreen());
    });
  }
}
