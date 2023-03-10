
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_delivery/core/colors.dart';
import 'package:raya_delivery/core/font.dart';

import '../../../../core/compnents.dart';
import '../../../../core/constants.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_cubit.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Orderr order;
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loadingComplete=false;
    bool loadingReturn=false;
    OrderCubit orderCubit=OrderCubit.get(context);
    return Scaffold(
      backgroundColor: cultured,
      appBar: defaultAppBar(context: context,title: 'OrderDetails',withBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h,horizontal: 16.w),
        child: BlocConsumer<OrderCubit, OrderState>(
  listener: (context, state) {
    if(state is LoadingCompleteOrderState){
      loadingComplete=true;
    }else if(state is LoadedCompleteOrderState){
      loadingComplete=false;
      orderCubit.getOrders();
      showToast(msg: 'Order Completed', state: ToastStates.success);
      Navigator.of(context).pop();
    }else if(state is ErrorCompleteOrderState){
      loadingComplete=false;
      showToast(msg: 'Failed', state: ToastStates.success);
    }else if(state is LoadingReturnOrderState){
      loadingReturn=true;
    }else if(state is LoadedReturnOrderState){
      loadingReturn=false;
      orderCubit.getOrders();
      showToast(msg: 'Order Returned', state: ToastStates.success);
      Navigator.of(context).pop();
    }else if(state is ErrorReturnOrderState){
      loadingReturn=false;
      showToast(msg: 'Failed', state: ToastStates.success);
    }
  },
  builder: (context, state) {
    return SingleChildScrollView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Details : ',style: openSans(16.sp, Colors.black, FontWeight.bold),),
                  SizedBox(width: 4.w,),
                  Text(order.details,style: openSans(16.sp, Colors.black, FontWeight.bold),),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Address : ',style: openSans(16.sp, Colors.black, FontWeight.bold),),
                  SizedBox(width: 4.w,),
                  Text(order.address,style: openSans(16.sp, Colors.black, FontWeight.bold),),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Created On : ',style: openSans(16.sp, Colors.black, FontWeight.bold),),
                  SizedBox(width: 4.w,),
                  Text(convertDate(order.createdOn),style: openSans(16.sp, Colors.black, FontWeight.bold),),
                ],
              ),
              SizedBox(height: 24.h,),
Row(
  children: [
    Flexible(
      child: defaultButton(onTap: (){
        if(!loadingReturn&&!loadingComplete){
orderCubit.completeOrder(order);
        }
      }, text: 'Complete',isLoading: loadingComplete,background: Colors.green),
    ),
    SizedBox(width: 16.w,),
    Flexible(
      child: defaultButton(onTap: (){
        if(!loadingReturn&&!loadingComplete){
          orderCubit.returnOrder(order);
        }
      }, text: 'Return',isLoading: loadingReturn,background: Colors.red),
    ),

  ],
)
            ],
          ),
        );
  },
),
      ),
    );
  }
}
