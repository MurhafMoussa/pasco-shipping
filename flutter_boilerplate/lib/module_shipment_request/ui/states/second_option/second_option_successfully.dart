import 'package:flutter/material.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_mark/mark_routes.dart';
import 'package:pasco_shipping/module_mark/response/mark_response.dart';
import 'package:pasco_shipping/module_shipment_previous/model/drop_list_model.dart';
import 'package:pasco_shipping/module_shipment_request/ui/widget/select_drop_list.dart';
import 'package:pasco_shipping/module_unit/response/unit_response.dart';
import 'package:pasco_shipping/utils/widget/text_edit.dart';
import 'package:pasco_shipping/module_shipment_request/request/shipment_request.dart';
import 'package:pasco_shipping/module_theme/service/theme_service/theme_service.dart';
import 'package:pasco_shipping/utils/styles/text_style.dart';

class SecondOptionSuccessfully extends StatefulWidget {
  final List<Mark> marks;
  final List<UnitModel> units;
  final ShipmentTempRequest shipmentRequest;
  final Function goBackStep;
  final Function goNextPage;
  final Function goMarkPage;
  SecondOptionSuccessfully({required this.marks,required this.shipmentRequest,required this.goBackStep,required this.goNextPage,required this.goMarkPage,required this.units});

  @override
  _SecondOptionSuccessfullyState createState() => _SecondOptionSuccessfullyState();
}

class _SecondOptionSuccessfullyState extends State<SecondOptionSuccessfully> {
 late DropListModel dropListModelUnit;

  late DropListModel dropListModelMark;
  late DropListModel dropListModelFromMark;
  late List<Entry> marksEntry;
  late List<Entry> unitsEntry;
  late List<Entry> marksBackEntry;

  late Entry optionItemSelectedU;
  late Entry optionItemSelectedMar;

  late String supplierName;
  // late String receiverName;
  // late String receiverPhone;

  late bool isFromMarks;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('here');
    if(widget.shipmentRequest.markId !=0){
      for(Mark item in widget.marks){
        if(item.id == widget.shipmentRequest.markId) {
          optionItemSelectedMar = Entry(item.markNumber!, item.id!, []);
        }
      }
    }else {
      optionItemSelectedMar =  Entry('choose', 0, []);
    }

    if(widget.shipmentRequest.supplierName.isNotEmpty){
      supplierName = widget.shipmentRequest.supplierName;
    }else{
      supplierName=S.of(context).nameHere;
    }

    // if(widget.shipmentRequest.receiverName.isNotEmpty){
    //   receiverName = widget.shipmentRequest.receiverName;
    // }else{
    //   receiverName=S.of(context).nameHere;
    // }
    //
    // if(widget.shipmentRequest.receiverPhoneNumber.isNotEmpty){
    //   receiverPhone = widget.shipmentRequest.receiverPhoneNumber;
    // }else{
    //   receiverPhone=S.of(context).phone;
    // }


    if(widget.shipmentRequest.unit.isNotEmpty){
      optionItemSelectedU = Entry(widget.shipmentRequest.unit, 1, []);
    }else{
      optionItemSelectedU=Entry('choose', 1, []);
    }

  }

  @override
  void initState() {
    super.initState();
    isFromMarks = false;
    marksEntry = <Entry>[];
    unitsEntry = <Entry>[];
    marksBackEntry = <Entry>[];
    for(Mark item in widget.marks){
      Entry v = Entry(item.markNumber! ,item.id! ,[]);
      marksEntry.add(v);
    }
    dropListModelMark = DropListModel(marksEntry);

    for(UnitModel item in widget.units){
      Entry v = Entry(item.name! ,item.id! ,[]);
      unitsEntry.add(v);
    }
    dropListModelUnit = DropListModel(unitsEntry);
  }

  @override
  Widget build(BuildContext context) {
    print(dropListModelMark.listOptionItems.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).supplierInfo,
          style: white18text,
        ),
        TextEdit(supplierName, 50, (supplierName) {
          widget.shipmentRequest.supplierName = supplierName;
        }),
        SizedBox(
          height: 25,
        ),
        // Text(
        //   'Recipient Info : ',
        //   style: white18text,
        // ),
        // TextEdit(receiverName, 50, (receiverName) {
        //   widget.shipmentRequest.receiverName = receiverName;
        // }),
        // TextEdit(receiverPhone, 50, (receiverPhoneNumber) {
        //   widget.shipmentRequest.receiverPhoneNumber = receiverPhoneNumber;
        // }),
        // SizedBox(
        //   height: 15,
        // ),
        Text(
          'Unit : ',
          style: white18text,
        ),
        SelectDropList(
          this.optionItemSelectedU,
          this.dropListModelUnit,
          (optionItem) {
            FocusScope.of(context).unfocus();
            optionItemSelectedU = optionItem;
            widget.shipmentRequest.unit = optionItem.title;
            setState(() {});
          },
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          S.of(context).mark,
          style: white18text,
        ),
        Row(
          children: [
            Expanded(
              child: SelectDropList(
                this.optionItemSelectedMar,
               isFromMarks ? this.dropListModelFromMark : this.dropListModelMark,
                (optionItem) {
                  FocusScope.of(context).unfocus();
                  optionItemSelectedMar = optionItem;
                  widget.shipmentRequest.markId = optionItem.id;
                  widget.shipmentRequest.markName = optionItem.title;
                  print(optionItem.title);
                  setState(() {});
                },
              ),
            ),
            InkWell(
              onTap: () {
                widget.goMarkPage();
                // Navigator.pushNamed(context, MarkRoutes.mark).then((value) {
                //   print('back');
                //  setState(() {
                //    List<Mark>  marks = value as List<Mark>;
                //    isFromMarks = true;
                //    marksEntry = <Entry>[];
                //    for(Mark item in marks){
                //      Entry v = Entry(item.markNumber! ,item.id! ,[]);
                //      marksEntry.add(v);
                //    }
                //    this.dropListModelFromMark = DropListModel(marksEntry);
                //  });
                // });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_circle_outline_sharp,
                      color: AppThemeDataService.AccentColor,
                      size: 25,
                    ),
                    Text(
                      'add\nnew',
                      style: White14text,
                    )
                  ],
                ),
              ),
            ),


          ],
        ),
        Row(
          children: [
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            widget.goBackStep();
                          },
                          label: Text(S.of(context).back),
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                        )),

                  ],
                ),
              ),
            ),
            Spacer(),
            Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    widget.goNextPage();
                  },
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                  ),
                  label: Text(S.of(context).next),
                )),
          ],
        )

      ],
    );
  }
}
