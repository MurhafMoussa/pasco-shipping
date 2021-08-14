import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_general/response/confirm_response.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/repository/accepted_shipment_repository.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/request/measured_shipment_request.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/request/received_deliered_shipment_request.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/request/shipemnt_finance_request.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/request/shipment_filter_request.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/request/stored_shipment_request.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/response/accepted_shipment_details_response.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/response/accepted_shipment_response.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/response/accepted_shipment_status_response.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/response/shipment_finance_response.dart';
import 'package:pasco_shipping/module_shipments_orders_accepted/response/warehouse_response.dart';

@injectable
class AcceptedShipmentManager{
  final AcceptedShipmentRepository _repository;
  AcceptedShipmentManager(this._repository);

  Future<List<AcceptedShipmentModel>?> getAcceptedShipment(AcceptedShipmentFilterRequest transportationType) => _repository.getAcceptedShipment(transportationType);
  Future<List<AcceptedShipmentStatusModel>?> getAcceptedShipmentStatus(String id,String trackNumber) => _repository.getAcceptedShipmentStatus(id,trackNumber);
  Future<List<WarehouseModel>?> getWarehouse(String cityName) => _repository.getWarehouses(cityName);
  Future<AcceptedShipmentDetailsModel?> getShipmentDetails(String id) => _repository.getShipmentDetails(id);
  Future<ConfirmResponse?> changeShipmentStatus(ReceivedOrDeliveredRequest id) => _repository.recivedOrDeliverdShipment(id);
  Future<ConfirmResponse?> measuredShipment(MeasuredRequest request) => _repository.measuredShipment(request);
  Future<ConfirmResponse?> storedShipment(StoredRequest request) => _repository.storedShipment(request);

  Future<ConfirmResponse?> createShipmentFinance(ShipmentFinanceRequest request) => _repository.createShipmentFinance(request);
  // Future<ConfirmResponse?> deleteProxy(String id) => _repository.deleteProxy(id);
  Future<List<ShipmentFinanceModel>?> getShipmentFinance(String id , String trackNumber) => _repository.getShipmentFinance(id, trackNumber);
// Future<ConfirmResponse?> updateProxy(ProxyRequest request) => _repository.updateProxy(request);

}