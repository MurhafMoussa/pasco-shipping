import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_client/response/client_response.dart';
import 'package:pasco_shipping/module_container/enums/container_status.dart';
import 'package:pasco_shipping/module_container/request/container_request.dart';
import 'package:pasco_shipping/module_container_specification/response/container_specification_response.dart';
import 'package:pasco_shipping/module_harbor/response/harbor_response.dart';
import 'package:pasco_shipping/module_shipment_previous/model/drop_list_model.dart';
import 'package:pasco_shipping/module_shipment_request/ui/widget/select_drop_list.dart';
import 'package:pasco_shipping/module_sub_contract/response/subcontract_response.dart';
import 'package:pasco_shipping/module_theme/service/theme_service/theme_service.dart';
import 'package:pasco_shipping/utils/styles/AppTextStyle.dart';
import 'package:pasco_shipping/utils/styles/static_images.dart';
import 'package:pasco_shipping/utils/widget/roundedButton.dart';

class RequestContainerInit extends StatefulWidget {
  final List<SubcontractModel> subContracts;
  final List<ContainerSpecificationModel> specifications;
  final List<ClientModel> clients;
  final List<HarborModel> harbors;
  final Function onSave;
  const RequestContainerInit({ required this.onSave , required this.subContracts,required this.specifications,required this.clients,required this.harbors});

  @override
  _AddCountryInitState createState() => _AddCountryInitState();
}

class _AddCountryInitState extends State<RequestContainerInit> {
 late TextEditingController location ;

 late DropListModel dropListModelProvidedBy;
 late Entry optionItemSelectedProvidedBy;

 late DropListModel dropListModelConsignee;
 late Entry optionItemSelectedConsignee;

 late DropListModel dropListModelShipper;
 late Entry optionItemSelectedShipper;

 late DropListModel dropListModelSpecification;
 late Entry optionItemSelectedSpecification;

 late DropListModel dropListModelCarrier;
 late Entry optionItemSelectedCarrier;

 late DropListModel dropListModelClient;
 late Entry optionItemSelectedClient;

 late DropListModel dropListModelHarbor;
 late Entry optionItemSelectedHarbor;

 late List<Entry> entryProvidedBy;
 late List<Entry> entryConsignee;
 late List<Entry> entryShipper;
 late List<Entry> entryCarrier;
 late List<Entry> entrySpecification;
 late List<Entry> entryClient;
 late List<Entry> entryHarbor;

 late String status;
 late String type;
 late int selectedRadioType;

 late int shipperID;
 late int consigneeID;
 late int providedByID;
 late int specificationID;

 late int carrierID;
 late int clientID;

 // TimeOfDay selectedTimeStart = TimeOfDay.now();
 // TimeOfDay selectedTimeEnd = TimeOfDay.now();
 //
 // DateTime now = DateTime.now();
 //
 // DateTime startDate = DateTime.now();
 // DateTime endDate = DateTime.now();
 // var formatter = new DateFormat('dd-MM-yyyy');
 // late String formattedDateStart;
 // late String formattedDateEnd;
 //
 // late String formattedTimeStart;
 // late String formattedTimeEnd;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Image.asset(StaticImage.container),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                  SizedBox(width: 5,),
                  Text(S.of(context).shippingType, style: AppTextStyle.mediumBlackBold,)
                ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppThemeDataService.AccentColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: () {
                    },
                    child: Row(
                      children: [
                        Radio(
                          onChanged: (value) {
                            _setSelectedRadioGender(1);
                          },
                          value: 1,
                          groupValue: selectedRadioType,
                          activeColor: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).LCL,
                          style: AppTextStyle.mediumWhite,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppThemeDataService.AccentColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: () {
                    },
                    child: Row(
                      children: [
                        Radio(
                          onChanged: (value) {
                            _setSelectedRadioGender(2);
                          },
                          value: 2,
                          groupValue: selectedRadioType,
                          activeColor: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).FCL,
                          style: AppTextStyle.mediumWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                  SizedBox(width: 5,),
                  Text(S.of(context).location , style: AppTextStyle.mediumBlackBold,)
                ],),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 4,left: 16, right: 16, bottom: 4
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: TextField(

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).location,
                    ),
                    controller: location,
                  ),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                  SizedBox(width: 5,),
                  Text(S.of(context).harbors , style: AppTextStyle.mediumBlackBold,)
                ],),
              ),
              SelectDropList(
                this.optionItemSelectedHarbor,
                this.dropListModelHarbor,
                    (optionItem) {
                      FocusScope.of(context).unfocus();
                  optionItemSelectedHarbor = optionItem;
                  setState(() {});
                },
              ),
              //
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(children: [
              //     Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
              //     SizedBox(width: 5,),
              //     Text(S.of(context).consignee , style: AppTextStyle.mediumBlackBold,)
              //   ],),
              // ),
              // SelectDropList(
              //   this.optionItemSelectedConsignee,
              //   this.dropListModelConsignee,
              //       (optionItem) {
              //         optionItemSelectedConsignee = optionItem;
              //     consigneeID = optionItem.id;
              //     setState(() {});
              //   },
              // ),
              //
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(children: [
              //     Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
              //     SizedBox(width: 5,),
              //     Text(S.of(context).shipper , style: AppTextStyle.mediumBlackBold,)
              //   ],),
              // ),
              // SelectDropList(
              //   this.optionItemSelectedShipper,
              //   this.dropListModelShipper,
              //       (optionItem) {
              //     optionItemSelectedShipper = optionItem;
              //     shipperID = optionItem.id;
              //     setState(() {});
              //   },
              // ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                  SizedBox(width: 5,),
                  Text(S.of(context).carrier , style: AppTextStyle.mediumBlackBold,)
                ],),
              ),
              SelectDropList(
                this.optionItemSelectedCarrier,
                this.dropListModelCarrier,
                    (optionItem) {
                  optionItemSelectedCarrier= optionItem;
                  carrierID = optionItem.id;
                  setState(() {});
                },
              ),

              selectedRadioType==2 ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                  SizedBox(width: 5,),
                  Text(S.of(context).client , style: AppTextStyle.mediumBlackBold,)
                ],),
              ) :Container(),
              selectedRadioType==2 ? SelectDropList(
                this.optionItemSelectedClient,
                this.dropListModelClient,
                    (optionItem) {
                  optionItemSelectedClient= optionItem;
                  clientID= optionItem.id;
                  setState(() {});
                },
              ):Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                  SizedBox(width: 5,),
                  Text(S.of(context).specification , style: AppTextStyle.mediumBlackBold,)
                ],),
              ),
              SelectDropList(
                this.optionItemSelectedSpecification,
                this.dropListModelSpecification,
                    (optionItem) {
                  optionItemSelectedSpecification = optionItem;
                  specificationID = optionItem.id;
                  setState(() {});
                },
              ),

              RoundedButton(lable: S.of(context).save, icon: '', color: AppThemeDataService.AccentColor, style: AppTextStyle.largeWhiteBold, go: (){
                // DateTime arrivalDate = DateTime(endDate.year , endDate.month ,endDate.day ,selectedTimeEnd.hour ,selectedTimeEnd.minute);
                // DateTime launchDate = DateTime(startDate.year , startDate.month ,startDate.day ,selectedTimeStart.hour ,selectedTimeStart.minute);

                ContainerRequest re = ContainerRequest(status: status ,type: type
                    ,specificationID: optionItemSelectedSpecification.id ,
                    consigneeID: optionItemSelectedConsignee.id ,
                    shipperID: optionItemSelectedShipper.id,
                    carrierID: optionItemSelectedCarrier.id
                    ,location: location.text,
                  portID: optionItemSelectedHarbor.id,
                  providedBy: optionItemSelectedProvidedBy.id,
                  clientID: optionItemSelectedClient.id
                );
                  widget.onSave(re);

              }, radius: 15)
            ],),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    entryProvidedBy = <Entry>[];
    entryShipper= <Entry>[];
    entryConsignee= <Entry>[];
    entryCarrier= <Entry>[];
    entryClient= <Entry>[];
    entryHarbor= <Entry>[];

    entrySpecification = <Entry>[];

    location=TextEditingController();

    status= ContainerStatusName[ContainerStatus.NOTFULL]!;

    selectedRadioType = 1;
    type = ContainerTypeName[ContainerType.PUBLIC]!;

    optionItemSelectedProvidedBy =  Entry('choose', 0, []);
    optionItemSelectedShipper =  Entry('choose', 0, []);
    optionItemSelectedConsignee =  Entry('choose', 0, []);
    optionItemSelectedSpecification =  Entry('choose', 0, []);
    optionItemSelectedCarrier =  Entry('choose', 0, []);
    optionItemSelectedClient =  Entry('choose', 0, []);
    optionItemSelectedHarbor =  Entry('choose', 0, []);

    initList();

  }

  void initList(){
    for(SubcontractModel item in widget.subContracts){
      Entry v = Entry(item.fullName! ,item.id! ,[]);
      entryProvidedBy.add(v);
      entryShipper.add(v);
      entryConsignee.add(v);
      entryCarrier.add(v);
    }
    dropListModelProvidedBy = DropListModel(entryProvidedBy);
    dropListModelShipper = DropListModel(entryShipper);
    dropListModelConsignee= DropListModel(entryConsignee);
    dropListModelCarrier= DropListModel(entryCarrier);


    for(ContainerSpecificationModel  item in widget.specifications){
      Entry v = Entry(item.name! ,item.id! ,[]);
      entrySpecification.add(v);
    }
    dropListModelSpecification = DropListModel(entrySpecification);


    for(ClientModel  item in widget.clients){
      Entry v = Entry(item.userName! ,item.id! ,[]);
      entryClient.add(v);
    }
    dropListModelClient = DropListModel(entryClient);


    for(HarborModel  item in widget.harbors){
      Entry v = Entry(item.name! ,item.id! ,[]);
      entryHarbor.add(v);
    }
    dropListModelHarbor = DropListModel(entryHarbor);
  }

 void _setSelectedRadioGender(int val) {
   setState(() {
     selectedRadioType = val;
     if (val == 1) {
       type = ContainerTypeName[ContainerType.PUBLIC]!;
     } else if (val == 2) {
       type = ContainerTypeName[ContainerType.PRIVATE]!;
     }
     print(val);
   });
 }

}
