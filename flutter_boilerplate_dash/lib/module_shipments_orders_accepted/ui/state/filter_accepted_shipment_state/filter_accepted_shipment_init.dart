import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_client/response/client_response.dart';
import 'package:pasco_shipping/module_countries/response/country_response.dart';
import 'package:pasco_shipping/module_shipment_previous/model/drop_list_model.dart';
import 'package:pasco_shipping/module_shipment_request/response/product_categories/product_categories_response.dart';
import 'package:pasco_shipping/module_shipment_request/ui/widget/choice_card.dart';
import 'package:pasco_shipping/module_shipment_request/ui/widget/select_drop_list.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/enums/accepted_shipment_status.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/request/shipment_filter_request.dart';
import 'package:pasco_shipping/module_sub_contract/response/subcontract_response.dart';
import 'package:pasco_shipping/module_theme/service/theme_service/theme_service.dart';
import 'package:pasco_shipping/module_travel/request/travel_filter_request.dart';
import 'package:pasco_shipping/utils/styles/AppTextStyle.dart';
import 'package:pasco_shipping/utils/widget/roundedButton.dart';
import 'package:pasco_shipping/utils/widget/text_edit.dart';

class FilterAcceptedShipmentInit extends StatefulWidget {
  final List<CountryModel> countries;
  final List<ClientModel> clients;
  final Function onSave;
  final AcceptedShipmentFilterRequest filterRequest;
  const FilterAcceptedShipmentInit({ required this.onSave ,required this.filterRequest,required this.countries,required this.clients});

  @override
  _AddCountryInitState createState() => _AddCountryInitState();
}

class _AddCountryInitState extends State<FilterAcceptedShipmentInit> {
  // late AcceptedShipmentFilterRequest acceptedShipmentFilterRequest;

 late List<Category> stats;
 late List<Category> statsRefused;

 late DropListModel dropListModelFromCountries;
 late DropListModel dropListModelToCountries;
 late DropListModel dropListModelClients;
 late Entry optionItemSelectedTim;
 late Entry optionItemSelectedTo;
 late Entry optionItemSelectedClient;
 DropListModel dropListModelTime = DropListModel(dataTime);


 late List<Entry> entryTo;
 late List<Entry> entryClient;

 late String launchCountry;
 late String target;

 DateTime now = DateTime.now();

 DateTime startDate = DateTime.now();
 DateTime endDate = DateTime.now();
 var formatter = new DateFormat('dd-MM-yyyy');
 late String formattedDateStart;
 late String formattedDateEnd;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            widget.filterRequest.transportationType=='sea'?  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).containerNumber,
                      style: AppTextStyle.mediumBlackBold,
                    ),
                  ),
                  TextEdit(hint:S.of(context).containerNumber ,title:  widget.filterRequest.containerNumber??'',onChange: (containerNumber) {
                    widget.filterRequest.containerNumber = containerNumber;
                  }),

                ],
              )
             : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).airwaybillNumber,
                      style: AppTextStyle.mediumBlackBold,
                    ),
                  ),
                  TextEdit(hint: S.of(context).airwaybillNumber, title:widget.filterRequest.airWaybillNumber??'' ,onChange: (airWaybillNumber) {
                    widget.filterRequest.airWaybillNumber = airWaybillNumber;
                  }),

                ],
              ),

            Text(S.of(context).status+': ' , style: AppTextStyle.mediumBlackBold,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing:30,
                runSpacing: 10.0,
                children: stats.map((item) {
                  var index = stats.indexOf(item);
                  return InkWell(
                      onTap: () {
                        setState(() {
                          stats.forEach((element) {
                            element.isSelected = false;
                          });
                        });
                        stats[index].isSelected = true;
                        widget.filterRequest.status = stats[index].description;
                        widget.filterRequest.acceptedUntilCleared=false;
                        // widget.shipmentRequest.productCategoryID = widget.categories[index].id;
                        // widget.shipmentRequest.productCategoryName = widget.categories[index].name;
                      },
                      child: ChoiceCard(item));
                }).toList(),
              ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(S.of(context).date+': ', style: AppTextStyle.mediumBlackBold,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(S.of(context).from , style: AppTextStyle.mediumBlackBold,),
                      ),
                      InkWell(
                        onTap: (){
                          _selectStartDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 4,left: 16, right: 16, bottom: 4
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5
                                  )
                                ]
                            ),
                            child: Text(formattedDateStart),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(S.of(context).to , style: AppTextStyle.mediumBlackBold,),
                      ),
                      InkWell(
                        onTap: (){
                          _selectEndDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 4,left: 16, right: 16, bottom: 4
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5
                                  )
                                ]
                            ),
                            child: Text(formattedDateEnd),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).destinationCountry, style: AppTextStyle.mediumBlackBold,),
              ),
              SelectDropList(
                this.optionItemSelectedTo,
                this.dropListModelToCountries,
                    (optionItem) {
                  optionItemSelectedTo = optionItem;
                  widget.filterRequest.targetCountry = optionItem.title;
                  // destinationCountry = optionItem.title;
                  // travelFilterRequest.destinationCountry = optionItem.title;
                  setState(() {});
                },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(S.of(context).client, style: AppTextStyle.mediumBlackBold,),
              ),
              SelectDropList(
                this.optionItemSelectedClient,
                this.dropListModelClients,
                    (optionItem) {
                  optionItemSelectedClient = optionItem;
                  widget.filterRequest.clientUserID = optionItem.id;
                  // destinationCountry = optionItem.title;
                  // travelFilterRequest.destinationCountry = optionItem.title;
                  setState(() {});
                },
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).paymentTime,
                  style: AppTextStyle.mediumBlackBold,
                ),
              ),
              SelectDropList(
                this.optionItemSelectedTim,
                this.dropListModelTime,
                    (optionItem) {
                  optionItemSelectedTim = optionItem;
                  widget.filterRequest.paymentTime = optionItem.title;
                  setState(() {});
                },
              ),

              RoundedButton(lable: S.of(context).save, icon: '', color: AppThemeDataService.AccentColor, style: AppTextStyle.largeWhiteBold, go: (){
                widget.onSave(widget.filterRequest);

              }, radius: 15)
          ],),
        ),
      ),
    );
  }


 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.filterRequest.dateTow='';
    widget.filterRequest.dateOne='';
    widget.filterRequest.containerNumber='';
    widget.filterRequest.airWaybillNumber='';
    widget.filterRequest.status='';
    widget.filterRequest.targetCountry='';
    widget.filterRequest.paymentTime='';
  }

  @override
  void initState() {
    super.initState();
    initList();
    if(widget.filterRequest.orderStatus=='refused') {
      stats = [
        Category(id: 1, name: 'Refused', description: AcceptedShipmentStatusName[AcceptedShipmentStatus.RECEIVED]!, isSelected: true),
      ];
    }else {
      stats = [
      Category(id: 1, name: 'Accepted', description: AcceptedShipmentStatusName[AcceptedShipmentStatus.ACCEPTED]!, isSelected: false),
      Category(id: 1, name: 'Received in warehouse', description: AcceptedShipmentStatusName[AcceptedShipmentStatus.RECEIVED]!, isSelected: false),
      Category(id: 1, name: 'Measured', description: AcceptedShipmentStatusName[AcceptedShipmentStatus.MEASURED]!, isSelected: false),
      Category(id: 1, name: 'Stored in holder', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.STORED]!, isSelected: false),
      Category(id: 1, name: 'On board', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.UPLOADED]!, isSelected: false),
      Category(id: 1, name: 'Started Travel', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.STARTED]!, isSelected: false),
      Category(id: 1, name: 'Released Travel', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.RELEASED]!, isSelected: false),
      Category(id: 1, name: 'Cleared holder', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.CLEARED]!, isSelected: false),
      Category(id: 1, name: 'Arrived to warehouse', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.ARRIVED]!, isSelected: false),
      Category(id: 1, name: 'Delivered to Client', description:AcceptedShipmentStatusName[AcceptedShipmentStatus.DELIVERED]!, isSelected: false),
      Category(id: 1, name: 'All',description: '', isSelected: false),
    ];
    }

  }
 void initList(){
   formattedDateStart = ''; //formatter.format(startDate);
   formattedDateEnd =''; //  formatter.format(endDate);
   entryTo = <Entry>[];
   entryClient = <Entry>[];

   optionItemSelectedTim =  Entry('choose', 0, []);
   optionItemSelectedTo =  Entry('choose', 0, []);
   optionItemSelectedClient =  Entry('choose', 0, []);
   for(CountryModel item in widget.countries){
     Entry v = Entry(item.name! ,item.id! ,[]);
     // entryFrom.add(v);
     entryTo.add(v);
   }
   dropListModelToCountries = DropListModel(entryTo);


   for(ClientModel item in widget.clients){
     Entry v = Entry(item.userName! ,item.id! ,[]);
     // entryFrom.add(v);
     entryClient.add(v);
   }
   dropListModelClients= DropListModel(entryClient);
 }
 Future<void> _selectStartDate(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: now,
       firstDate: DateTime(2021, 6),
       lastDate: DateTime(2101));
   if (picked != null && picked != now) {
     setState(() {
       startDate = picked;
       widget.filterRequest.dateOne = DateTime(startDate.year , startDate.month , startDate.day).toUtc().toString();
       formattedDateStart = formatter.format(startDate);
     });
   }
 }
 Future<void> _selectEndDate(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: now,
       firstDate: DateTime(2021, 6),
       lastDate: DateTime(2101));
   if (picked != null && picked != now) {
     setState(() {
       endDate = picked;
       widget.filterRequest.dateTow = DateTime(endDate.year , endDate.month , endDate.day).toUtc().toString();
       formattedDateEnd = formatter.format(endDate);
     });
   }
 }
}
