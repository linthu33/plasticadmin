import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mystore/admin/bloc/product/products_bloc.dart';
import 'package:mystore/admin/models/ProductsModel.dart';
import 'package:mystore/config/size_config.dart';
import 'package:mystore/style/colors.dart';

import 'description.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<Description> descriptionForm = [];
  List<Pricetype> priceForm = [];
  //ui for description
  List<Subcategory> category = [];
  final formalldata = GlobalKey<FormState>();
  late TextEditingController _maincatname;
  late TextEditingController _subcatname;

  late TextEditingController _title;
  late TextEditingController _color;
  late TextEditingController _experDate;
  late TextEditingController desController;
  late TextEditingController langController;
  late TextEditingController _pricepackagenameCon;
  late TextEditingController _listController;
  late TextEditingController _buyController;
  late TextEditingController _sellController;

  late TextEditingController _quantityCont;
  late TextEditingController _sellquantitConr;

  bool _activedes = true;
  bool _activeprice = true;
  bool _activecategory = true;
  @override
  void initState() {
    super.initState();
    _subcatname = TextEditingController();
    _maincatname = TextEditingController();
    _title = TextEditingController();
    _color = TextEditingController();
    _experDate = TextEditingController();
    desController = TextEditingController();
    langController = TextEditingController();

    _pricepackagenameCon = TextEditingController();
    _listController = TextEditingController();
    _buyController = TextEditingController();
    _sellController = TextEditingController();
    _quantityCont = TextEditingController();
    _sellquantitConr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: formalldata,
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      controller: _title,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'အမျိုးအမည်',
                      )),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1,
                  ),
                  TextField(
                      controller: _color,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'အရောင်',
                      )),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1,
                  ),
                  TextField(
                      controller: _experDate,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'သတ်မှတ်ရက်စွဲ',
                      )),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1,
                  ),
                  _renderSteps(),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          var prod = ProductsModel(
                              maincategory: _maincatname.value.text,
                              subcategory: category.map<Subcategory>((sub) {
                                return Subcategory(
                                  subcatname: sub.subcatname,
                                );
                              }).toList(),
                              title: _title.value.text,
                              images: ["/uploads"],
                              color: _color.value.text,
                              brand: Brand(name: "plastic"),
                              experDate: "2/2/2022",
                              shipping: Shipping(
                                weigh: 1,
                                dimensions: Dimensions(width: 1, height: 1),
                              ),
                              reviewPoint: ReviewPoint(username: 'admin'),
                              //certification: null,
                              //returnPolicy: null,
                              sublabel: _subcatname.value.text,
                              description:
                                  descriptionForm.map<Description>((dec) {
                                return Description(
                                    lang: dec.lang, details: dec.details);
                              }).toList(),
                              pricetype: priceForm.map<Pricetype>((p) {
                                return Pricetype(
                                  pricepackagename: p.pricepackagename,
                                  list:
                                      p.list, //int.parse(memberField['list']),
                                  sellprice: p.sellprice,
                                  buyprice: p.buyprice,

                                  quantity: p.quantity,
                                  //sellquantity://int.parse(memberField['sellquantity']),
                                  //indate: memberField['indate'],
                                );
                              }).toList());

                          BlocProvider.of<ProductsBloc>(context)
                              .add(ProductAdd(product: prod));
                        },
                        child: Text('စာရင်းသွင်းရန်')),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
        elevation: 0,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            if (index == 0) {
              _activedes = !_activedes;
            } else if (index == 1) {
              _activeprice = !_activeprice;
            } else {
              _activecategory = !_activecategory;
            }
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                  title: const Text('ကုန်ပစ္စည်းအချက်လက်'),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                        controller: langController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'language',
                                        )),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    TextField(
                                      controller: desController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Description',
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            var des = Description(
                                                details: desController
                                                    .value.text
                                                    .toString(),
                                                lang: langController.value.text
                                                    .toString());
                                            descriptionForm.add(des);
                                          });
                                        },
                                        child: Text("add description"))
                                  ],
                                ),
                              ));
                            });
                      },
                      icon: SvgPicture.asset('assets/ring.svg', width: 20.0)));
            },
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: descriptionForm.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ဘာသာစကား",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                descriptionForm[index].lang.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ကုန်ပစ္စည်းအချက်အလက်",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                descriptionForm[index].details.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/delete.svg',
                                  width: 20.0,
                                  color: Colors.redAccent,
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            isExpanded: _activedes,
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                  title: const Text('ဈေးနှန်းသတ်မှတ်ရန်'),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                        controller: _pricepackagenameCon,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'အမျိုးအစား',
                                        )),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    TextField(
                                        controller: _listController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'ဖောက်သည်ဈေး',
                                        )),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    TextField(
                                        controller: _buyController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'ဝယ်ဈေး',
                                        )),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    TextField(
                                      controller: _sellController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'ရောင်းဈေး',
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    TextField(
                                      controller: _quantityCont,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'အရေတွက်',
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            var pric = Pricetype(
                                              pricepackagename:
                                                  _pricepackagenameCon
                                                      .value.text,
                                              list: int.parse(_listController
                                                  .value.text
                                                  .toString()),
                                              buyprice: int.parse(_buyController
                                                  .value.text
                                                  .toString()),
                                              sellprice: int.parse(
                                                  _sellController.value.text
                                                      .toString()),
                                              quantity: int.parse(_quantityCont
                                                  .value.text
                                                  .toString()),
                                            );
                                            priceForm.add(pric);
                                          });
                                        },
                                        child: const Text("add Price"))
                                  ],
                                ),
                              ));
                            });
                      },
                      icon: SvgPicture.asset('assets/ring.svg', width: 20.0)));
            },
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: priceForm.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ဈေးနှုန်းအမျိုးအစား",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                priceForm[index].pricepackagename.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ဖောက်တည်ဈေး",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                priceForm[index].list.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ဝယ်ဈေး",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                priceForm[index].buyprice.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ရောင်းဈေး",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                priceForm[index].sellprice.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "အရေတွက်",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                priceForm[index].quantity.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ဖောက်တည်ဈေး",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                priceForm[index].list.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/delete.svg',
                                  width: 20.0,
                                  color: Colors.redAccent,
                                )),
                          ],
                        ),
                      ),
                      Divider(
                        height: SizeConfig.blockSizeVertical! * 1,
                        color: AppColors.black,
                      ),
                    ],
                  );
                }),
            isExpanded: _activeprice,
          ),
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                  title: const Text('အုပ်စုဖွဲ့ရန်'),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    TextField(
                                        controller: _maincatname,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'အမျိုးအစား',
                                        )),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    TextField(
                                      controller: _subcatname,
                                      // obscureText: true,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'ဒုတိယအမျိုးအစား',
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 1,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            var sub = Subcategory(
                                                subcatname:
                                                    _subcatname.value.text);
                                            category.add(sub);
                                          });
                                        },
                                        child: const Text("add category"))
                                  ],
                                ),
                              ));
                            });
                      },
                      icon: SvgPicture.asset('assets/ring.svg', width: 20.0)));
            },
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ပထမအမျိုးအစား",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _maincatname.value.text.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              child: Text(
                                "ဒုတိယအမျိုးအစား",
                              ),
                            ),
                            Expanded(
                              child: Text(
                                category[index].subcatname.toString(),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/delete.svg',
                                  width: 20.0,
                                  color: Colors.redAccent,
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            isExpanded: _activecategory,
          )
        ]);
  }
}
