
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raya_delivery/core/constants.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../../../core/font.dart';
import '../../domain/entities/order.dart';
import '../pages/order_details_view.dart';

class OrderItemView extends StatelessWidget {
  final Orderr order;
  const OrderItemView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>navigateTo(context, OrderDetailsScreen(order: order,)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.details,style: openSans(16.sp, raisinBlack, FontWeight.w600),textScaleFactor: 1,),
            SizedBox(height: 8.h,),
            Text(convertDate(order.createdOn),style: openSans(14.sp, dimGray, FontWeight.w600),textScaleFactor: 1,),

          ],
        ),
      ),
    );
  }
}
