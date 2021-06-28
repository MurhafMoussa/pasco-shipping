
import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/module_general/response/confirm_response.dart';
import 'package:pasco_shipping/module_mark/manager/mark_manager.dart';
import 'package:pasco_shipping/module_mark/request/mark_request.dart';
import 'package:pasco_shipping/module_mark/response/mark_response.dart';

@injectable
class MarkService {
  final MarkManager _manager;
  MarkService(this._manager);

  Future<ConfirmResponse?> createMark(String markNumber) {
    return _manager.createMark(MarkRequest(markNumber));
  }
  Future<ConfirmResponse?> deleteMark(String id) {
    return _manager.deleteMark(id);
  }
  Future<List<Mark>?> getMyMarks() {
    return _manager.getMyMarks();
  }
}