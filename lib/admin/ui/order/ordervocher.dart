import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/admin/bloc/order/bloc/order_bloc.dart';
import 'package:mystore/admin/models/orderproductModel.dart';

class VoucherScreen extends StatefulWidget {
  Orderproduct? invoice;

  VoucherScreen({Key? key, required this.invoice})
      : super(key: key); //= Orderproduct;

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  late String dropdownvalue = "All";
  late List<Order_DStatus> order_status;
  late List<Order_DStatus> selectedstatus;

  bool _isShown = true;
  @override
  void initState() {
    super.initState();
    /*  for (var element in widget.invoice!.orderitem!) {
      selectedstatus.add(element);
    } */
    order_status = Order_DStatus.getUsers();
    //order_status.forEach(((element) => selectedstatus)
    var data = widget.invoice!.orderitem!.asMap().entries.map((item) {
      return item.value.itemStatus.toString();
    });

    selectedstatus = Order_DStatus.getintial();
    //print("select length" + selectedstatus.length.toString());
    /*  final state = BlocProvider.of<OrderBloc>(context).state;
    if (state is OrderLoadedState) {
      widget.invoice = state.orders as Orderproduct?;
    } */
  }

  void updateOrderStatus(String orstr) {
    print(orstr);
    /* BlocProvider.of<OrderBloc>(context, listen: false).add(
        const OrderStatusUpdateEvent(
            orderstatus: selectedstatus, Id: "63202f832c14a15db3a3957c")); */
  }

  @override
  Widget build(BuildContext context) {
    final orderbloc = BlocProvider.of<OrderBloc>(context);
    return Scaffold(
      //backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            /*  Navigator.push(
                context, MaterialPageRoute(builder: (context) => WidgetTree())); */
          },
        ),
        elevation: 1,
        title: const Text('Print Voucher',
            style: TextStyle(
                height: 1.5,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              buildTitle(),
              //buildSupplierAddress(
              //    Supplier(name: "Mdeical", address: "aefef 987734353535")),
              const Divider(),
              buildText(title: "Customer Information", value: "", width: 200),
              buildCustomerAddress(
                  widget.invoice!.shippingaddress ?? Shippingaddress(),
                  widget.invoice!),
              const SizedBox(
                height: 10,
              ),
              buildInvoiceInfo(widget.invoice!),
              buildInvoice(widget.invoice!),
              const SizedBox(
                height: 20,
              ),
              buildTotal(widget.invoice!),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: OrderConfirm(
          invoice: widget.invoice!, selectedstatus: selectedstatus),
    );
  }

  static Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Invoice Voucher',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(""),
          SizedBox(height: 10),
        ],
      );
  /*  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(supplier.address),
        ],
      ); */

  static Widget buildCustomerAddress(
          Shippingaddress customer, Orderproduct invoice) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(customer.fullName.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(customer.phone.toString()),
              Text(customer.address.toString() +
                  "," +
                  "Postal Code: " +
                  customer.postal.toString()),
              Text(customer.city.toString() +
                  "," +
                  customer.state.toString() +
                  "," +
                  customer.country.toString()),
            ],
          ),
          const SizedBox(
            height: 80,
            width: 80,
            child: Text(""),
          ),
        ],
      );

  Widget buildInvoiceInfo(Orderproduct invoice) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildText(
          title: "Invoice Number:",
          value: invoice.barcode.toString(),
          width: 200),
      buildText(
          title: "Invoice Date:",
          value: invoice.orderdate.toString(),
          width: 200),
    ]);
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? const TextStyle(fontWeight: FontWeight.bold);

    return SizedBox(
      width: width,
      child: Row(
        children: [
          Text(title, style: style),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  Widget buildInvoice(Orderproduct invoice) {
    var data = invoice.orderitem!.asMap().entries.map((item) {
      return DataRow(cells: [
        DataCell(Text(item.key.toString())),
        DataCell(Text(item.value.quantity.toString())),
        DataCell(Text(item.value.sellprice.toString())),
        DataCell(Text((item.value.quantity! *
                int.parse(item.value.totalamount.toString()))
            .toString())),
        DataCell(Text(item.value.itemStatus.toString())),
        const DataCell(Text("=>")),
        DataCell(Center(
            child: ElevatedButton(
          child: Text(selectedstatus[item.key].ordstatus.toString()),
          onPressed: (() {
            showModalBottomSheet<void>(
                context: context,
                builder: (builder) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: DropdownButton<Order_DStatus>(
                          dropdownColor: Color.fromARGB(255, 245, 135, 100),
                          value: order_status[item.key],
                          style: const TextStyle(height: 1.5),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: order_status
                              .map<DropdownMenuItem<Order_DStatus>>(
                                  (Order_DStatus value) {
                            return DropdownMenuItem<Order_DStatus>(
                                value: value,
                                child: Text(
                                  value.ordstatus.toString(),
                                  /* style:
                                      TextStyle(backgroundColor: Colors.black), */
                                ));
                          }).toList(),
                          onChanged: (Order_DStatus? newstatus) {
                            setState(() {
                              selectedstatus[item.key] = newstatus!;
                              selectedstatus[item.key].ordItem =
                                  item.value.oid.toString();
                              selectedstatus[item.key].ordItem =
                                  item.value.oid.toString();
                              //comfirmstatuspopup(item);
                              print(selectedstatus[item.key].ordItem);
                              BlocProvider.of<OrderBloc>(context).add(
                                  OrderStatusUpdateEvent(
                                      orderstatus: selectedstatus[item.key]
                                          .ordstatus
                                          .toString(),
                                      Id: selectedstatus[item.key]
                                          .ordItem
                                          .toString()));
                            });
                          }),
                    ),
                  );
                });
          }),
        )))
      ]);
    }).toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DataTable(
            columns: const [
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Unit Price')),
              DataColumn(label: Text('Total')),
              DataColumn(label: Text('Order Status')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('change')),
            ],
            rows: data,
            headingTextStyle: const TextStyle(
              //backgroundColor: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            dividerThickness: 1,
            showBottomBorder: true,
          ),
        ],
      ),
    );
  }

  static Widget buildTotal(Orderproduct invoice) {
    final netTotal = invoice.orderitem!
        .map((item) =>
            int.parse(item.sellprice.toString()) *
            int.parse(item.quantity.toString()))
        .reduce((item1, item2) => item1 + item2);

    final Deliveryp = invoice.deliveryprice;
    final Tax = invoice.tax;
    final TotalAmount = invoice.totalAmount;
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total:',
                  value: netTotal.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'Tax:',
                  value: Tax.toString(),
                  unite: true,
                ),
                buildText(
                  title: 'Delivery Price:',
                  value: Deliveryp.toString(),
                  unite: true,
                ),
                const Divider(),
                buildText(
                  title: 'Total amount :',
                  titleStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: TotalAmount.toString(),
                  unite: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void comfirmstatuspopup(item) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(''),
              scrollable: true,
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Form(
                    child: Column(
                      children: const <Widget>[],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    updateOrderStatus(selectedstatus[item].toString());
                    /* _orderBloc.add(OrderStatusUpdateEvent(
                        orderstatus: selectedstatus[item].toString(),
                        Id: item.toString())); */
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            ));
  }
}

class OrderConfirm extends StatefulWidget {
  Orderproduct invoice;
  late List<Order_DStatus> selectedstatus;
  OrderConfirm({Key? key, required this.invoice, required this.selectedstatus})
      : super(key: key);
  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(31, 5, 5, 5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3)),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        height: 10,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0,
            //primary: kPrimaryColor,
          ),
          onPressed: () async {
            /* BlocProvider.of<OrderBloc>(context).add(OrderStatusUpdateEvent(
                orderstatus: widget.selectedstatus,
                Id: widget.invoice.Id.toString())); */
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('continue'),
              //SizedBox(width: SizeConfig.screenWidth * 0.01),
              Icon(Icons.check_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

class Order_DStatus {
  late String? ordID;
  late String? ordItem;
  late String? ordstatus;

  Order_DStatus({this.ordItem, this.ordstatus});

  static List<Order_DStatus> getUsers() {
    return <Order_DStatus>[
      Order_DStatus(
        ordstatus: "ALl",
      ),
      Order_DStatus(ordItem: "1", ordstatus: "order"),
      Order_DStatus(ordItem: "2", ordstatus: "Cancel"),
      Order_DStatus(ordItem: "3", ordstatus: "Processing"),
      Order_DStatus(ordItem: "4", ordstatus: "Delivery"),
      Order_DStatus(ordItem: "5", ordstatus: "completed"),
    ];
  }

  static List<Order_DStatus> getintial() {
    return <Order_DStatus>[
      Order_DStatus(ordItem: "1", ordstatus: "Change Status"),
      Order_DStatus(ordItem: "2", ordstatus: "Change Status"),
      Order_DStatus(ordItem: "3", ordstatus: "Change Status"),
      Order_DStatus(ordItem: "4", ordstatus: "Change Status"),
      Order_DStatus(ordItem: "5", ordstatus: "Change Status"),
    ];
  }
}
