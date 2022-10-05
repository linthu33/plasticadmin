import 'package:flutter/material.dart';
import 'package:mystore/admin/ui/dashboard/component/allproducthome.dart';
import 'package:mystore/admin/ui/dashboard/component/appBarActionItems.dart';
import 'package:mystore/admin/ui/dashboard/component/barChart.dart';
import 'package:mystore/admin/ui/dashboard/component/header.dart';
import 'package:mystore/admin/ui/dashboard/component/historyTable.dart';
import 'package:mystore/admin/ui/dashboard/component/infoCard.dart';
import 'package:mystore/admin/ui/dashboard/component/paymentDetailList.dart';
import 'package:mystore/admin/ui/dashboard/component/sideMenu.dart';
import 'package:mystore/admin/ui/product/producthome.dart';
import 'package:mystore/config/responsive.dart';
import 'package:mystore/config/size_config.dart';
import 'package:mystore/style/colors.dart';
import 'package:mystore/style/style.dart';

class Dashboard extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.menu, color: AppColors.black)),
              actions: [
                AppBarActionItems(),
              ],
            )
          : PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              InfoCard(
                                  icon: 'assets/credit-card.svg',
                                  label: 'ကုန်ပစ္စည်းစတိုရှိရင်း',
                                  amount: '1200'),
                              InfoCard(
                                  icon: 'assets/transfer.svg',
                                  label: 'ကုန်ပစ္စည်းစတိုအရောင်း',
                                  amount: '150'),
                              InfoCard(
                                  icon: 'assets/bank.svg',
                                  label: 'ကုန်ပစ္စည်းစတိုလက်ကျန်',
                                  amount: '1000'),
                              InfoCard(
                                  icon: 'assets/invoice.svg',
                                  label: 'ကုန်ပစ္စည်းအော်ဒါ',
                                  amount: '500'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 1,
                        ),
                        const SizedBox(
                          height: 1000,
                          child: AllProductHome(),
                        ),
                      ],
                    ),
                  ),
                )),
            /*   if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(color: AppColors.secondaryBg),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          PaymentDetailList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
           */
          ],
        ),
      ),
    );
  }
}
