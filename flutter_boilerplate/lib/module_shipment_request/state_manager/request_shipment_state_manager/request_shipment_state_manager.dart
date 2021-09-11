import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_mark/service/mark_service.dart';
import 'package:pasco_shipping/module_receiver/service/receiver_service.dart';
import 'package:pasco_shipping/module_shipment_request/service/shipment_request_service/first_option_service.dart';
import 'package:pasco_shipping/module_shipment_request/ui/states/request_shipment_state.dart';
import 'package:pasco_shipping/module_unit/service/unit_service.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class RequestShipmentStateManger{
  final FirstOptionService _firstOptionService;
  final MarkService _markService;
  final UnitService _unitService;
  final ReceiverService _receiverService;
  final PublishSubject<RequestShipmentState> _stateSubject = PublishSubject();
  Stream<RequestShipmentState> get stateStream => _stateSubject.stream;

  RequestShipmentStateManger(this._firstOptionService, this._markService, this._receiverService, this._unitService);

 void getFirstOption(){
   _stateSubject.add(LoadingState());

   _firstOptionService.getWarehouse().then((warehouses) {
     if(warehouses == null ){
       _stateSubject.add(errorState('error connection'));
     }
     else{
       _firstOptionService.getCategories().then((categories) {
         if(categories == null ){
           _stateSubject.add(errorState('error connection'));
         }
         else {
           _stateSubject.add(FirstOptionFetchingDataState(categories: categories ,warehouses: warehouses));
         }
       });
     }
   });
 }

 void getSecondOption(){
   _stateSubject.add(LoadingState());
   _markService.getMyMarks().then((marks) {
     if(marks == null ){
       _stateSubject.add(errorState('error connection'));
     }
     else{
       _unitService.getUnits().then((units) {
         if(units != null){
           _stateSubject.add(SecondOptionFetchingDataState(marks ,units));
         }else{
           _stateSubject.add(errorState('error connection'));
         }
       });
     }
   });

 }

 void getThirdOption(){
   _stateSubject.add(LoadingState());
   _receiverService.getMyReceiver().then((receivers) {
     if(receivers == null ){
       _stateSubject.add(errorState('error connection'));
     }
     else{
       _stateSubject.add(ThirdOptionFetchingDataState(receivers));
     }
   });
 }
}