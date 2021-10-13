import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_container/request/container_add_finance_request.dart';
import 'package:pasco_shipping/module_container/response/container_finance_response.dart';
import 'package:pasco_shipping/module_container/widget/container_finance_card.dart';
import 'package:pasco_shipping/module_shipment_previous/model/drop_list_model.dart';
import 'package:pasco_shipping/module_shipment_request/ui/widget/select_drop_list.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/enums/accepted_shipment_status.dart';
import 'package:pasco_shipping/module_sub_contract/response/subcontract_response.dart';
import 'package:pasco_shipping/module_theme/service/theme_service/theme_service.dart';
import 'package:pasco_shipping/utils/styles/AppTextStyle.dart';
import 'package:pasco_shipping/utils/styles/colors.dart';
import 'package:pasco_shipping/utils/widget/roundedButton.dart';

class ContainerFinanceSuccessfullyScreen extends StatefulWidget {
  final Data containerFinances;
  final Function addFinance;
  final int containerID;
  final String type;
  final List<SubcontractModel> subContracts;
  ContainerFinanceSuccessfullyScreen({required this.addFinance ,required this.containerFinances,required this.containerID,required this.type,required this.subContracts });

  @override
  _MarkSuccessfullyScreenState createState() => _MarkSuccessfullyScreenState();
}

class _MarkSuccessfullyScreenState extends State<ContainerFinanceSuccessfullyScreen> {
  DropListModel dropListModelPayment = DropListModel(paymentType);
  DropListModel dropListModelContainerFCLStatus = DropListModel(containerFclFinance);
  DropListModel dropListModelContainerLCLStatus = DropListModel(containerLclFinance);
  DropListModel dropListModelFund = DropListModel(fundName);

  TextEditingController cost = TextEditingController();
  TextEditingController selling = TextEditingController();
  TextEditingController buying = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController checkNumber = TextEditingController();

  late bool visAddCard;
  late List<Entry> entrySub;
  late DropListModel dropListModelSubContract;
  late Entry optionItemSelectedSubContract;
  late Entry optionItemSelectedPayment;
  late Entry optionItemSelectedStatus;
  late Entry optionItemSelectedFund;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
             widget.type =='FCL'?
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.green[50]),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).sellingCost ,style: AppTextStyle.mediumBlackBold,),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(start: 8,end: 8,bottom: 8),
                                child: Text(widget.containerFinances.currentTotalSellingCost ??'' ,style: AppTextStyle.largeBlue,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.green[50]),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(S.of(context).buyingCost ,style: AppTextStyle.mediumBlackBold,),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(start: 8,end: 8,bottom: 8),
                                child: Text(widget.containerFinances.currentTotalBuyingCost ??'' ,style: AppTextStyle.largeBlue,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.green[50]),
                    child:
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Total cost' ,style: AppTextStyle.mediumBlackBold,),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8,end: 8,bottom: 8),
                          child: Text(widget.containerFinances.currentTotalCost ??'' ,style: AppTextStyle.largeBlue,),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add"),
                  onPressed: () {
                    visAddCard = !visAddCard;
                    setState(() {

                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                )
              ],),
            SizedBox(height: 30,),
            Visibility(
              visible:visAddCard ,
              child:  Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                  widget.type=='FCL'?
                  Column(children: [
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).sellingCost,
                          ),
                          controller: selling,
                        ),
                      ),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).buyingCost,
                          ),
                          controller: buying,
                        ),
                      ),
                    ),
                  ],) :Padding(
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: S.of(context).cost,
                            ),
                            controller: cost,
                          ),
                        ),
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
                              hintText: S.of(context).details,
                            ),
                            controller: description,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                          SizedBox(width: 5,),
                          Text(S.of(context).subcontract , style: AppTextStyle.mediumBlackBold,)
                        ],),
                      ),
                      SelectDropList(
                        this.optionItemSelectedSubContract,
                        this.dropListModelSubContract,
                            (optionItem) {
                          optionItemSelectedSubContract = optionItem;
                          setState(() {});
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                          SizedBox(width: 5,),
                          Text('Stage' , style: AppTextStyle.mediumBlackBold,)
                        ],),
                      ),
                      widget.type=='LCL'?  SelectDropList(
                        this.optionItemSelectedStatus,
                        this.dropListModelContainerLCLStatus,
                            (optionItem) {
                          optionItemSelectedStatus = optionItem;
                          setState(() {});
                        },
                      ) : SelectDropList(
                        this.optionItemSelectedStatus,
                        this.dropListModelContainerFCLStatus,
                            (optionItem) {
                          optionItemSelectedStatus = optionItem;
                          setState(() {});
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                          SizedBox(width: 5,),
                          Text(S.of(context).paymentType , style: AppTextStyle.mediumBlackBold,)
                        ],),
                      ),
                      SelectDropList(
                        this.optionItemSelectedPayment,
                        this.dropListModelPayment,
                            (optionItem) {
                          optionItemSelectedPayment = optionItem;
                          setState(() {});
                        },
                      ),

                      optionItemSelectedPayment.title=='Check' ?  Padding(
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Check Number',
                            ),
                            controller: checkNumber,
                          ),
                        ),
                      ) : optionItemSelectedPayment.title=='Cash' ?Column(children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Icon(Icons.circle ,color: AppThemeDataService.AccentColor,),
                            SizedBox(width: 5,),
                            Text('Fund Name' , style: AppTextStyle.mediumBlackBold,)
                          ],),
                        ),
                        SelectDropList(
                          this.optionItemSelectedFund,
                          this.dropListModelFund,
                              (optionItem) {
                            optionItemSelectedFund = optionItem;
                            setState(() {});
                          },
                        ),

                      ],) :Container(),
                      RoundedButton(lable: S.of(context).add, icon: '', color: blue, style: AppTextStyle.mediumWhiteBold, go: (){
                         ContainerAddFinanceRequest mark = ContainerAddFinanceRequest(
                            status:optionItemSelectedStatus.children[0].title ,currency:' ',
                            containerID: widget.containerID,
                            stageCost: int.parse(cost.text) ,
                            stageDescription: description.text,
                            paymentType: optionItemSelectedPayment.title,
                            subcontractID: optionItemSelectedSubContract.id,
                            chequeNumber: checkNumber.text,
                            buyingCost:int.parse(buying.text),
                            sellingCost:int.parse(selling.text),
                            financialFundName: optionItemSelectedFund.title =='choose'?'' :optionItemSelectedFund.title,

                          );
                          widget.addFinance(mark);
                      }, radius: 12)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(height: 2,thickness: 3,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Expenses' ,style: AppTextStyle.mediumBlackBold,),
                Row(children: [
                  Text('Total Amount ' ,style: AppTextStyle.mediumBlack,),
                  Text(widget.containerFinances.currentTotalCost.toString() ,style: AppTextStyle.mediumBlack,),

                ],)
              ],),
            SizedBox(height: 15,),
            widget.containerFinances.data!.isEmpty ?
            Text(S.of(context).nothingAdded , style: AppTextStyle.mediumRedBold,)
                :ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.containerFinances.data!.length,
                itemBuilder: (context, index) {
                  return ContainerFinanceCard(
                    model: widget.containerFinances.data![index]
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    visAddCard = false;
    entrySub= <Entry>[];
    optionItemSelectedSubContract =  Entry('choose', 0, []);
    optionItemSelectedPayment =  Entry('choose', 0, []);
    optionItemSelectedStatus =  Entry('choose', 0, []);
    optionItemSelectedFund =  Entry('choose', 0, []);
    cost..text='0';
    buying..text='0';
    selling..text='0';
    initSubs();
  }

  void initSubs(){
    for(SubcontractModel item in widget.subContracts){
      Entry v = Entry(item.fullName! ,item.id! ,[]);
      entrySub.add(v);
    }
    dropListModelSubContract = DropListModel(entrySub);
  }
}
