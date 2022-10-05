import 'package:flutter/material.dart';
import 'package:mystore/admin/ui/product/addproduct.dart';
import 'package:mystore/admin/ui/product/producthome.dart';

class AllProductHome extends StatefulWidget {
  const AllProductHome({Key? key}) : super(key: key);

  @override
  State<AllProductHome> createState() => _AllProductHomeState();
}

class _AllProductHomeState extends State<AllProductHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  unselectedLabelColor: Colors.redAccent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  /*  indicator: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.redAccent, Colors.orangeAccent]),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent), */
                  tabs: const [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("ကုန်ပစ္စည်းစာရင်း"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("ကုန်ပစ္စည်းအသစ်ထည့်ရန်"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("ဘောင်ချာစာရင်း"),
                      ),
                    ),
                  ]),
            ),
          ),
          body: Container(
            height: 700,
            child: TabBarView(children: [
              ProductHome(),
              AddProduct(),
              Icon(Icons.games),
            ]),
          ),
        ));
  }
}
