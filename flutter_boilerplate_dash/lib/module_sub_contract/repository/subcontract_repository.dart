
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/consts/urls.dart';
import 'package:pasco_shipping/module_auth/service/auth_service/auth_service.dart';
import 'package:pasco_shipping/module_general/response/confirm_response.dart';
import 'package:pasco_shipping/module_network/http_client/http_client.dart';
import 'package:pasco_shipping/module_sub_contract/request/subcontract_request.dart';
import 'package:pasco_shipping/module_sub_contract/response/subcontract_response.dart';

@injectable
class SubcontractRepository{
  final ApiClient _apiClient;
  final AuthService _authService;

  SubcontractRepository(this._apiClient, this._authService);

  Future<List<SubcontractModel>?> getSubContracts() async {
    // await _authService.refreshToken();
    var token =  await _authService.getToken();
    try {
      var response = await _apiClient.get(Urls.SUB_CONTRACTS,
          headers: {'Authorization': 'Bearer $token'});
      SubcontractResponse markResponse =  SubcontractResponse.fromJson(response!);
      List<SubcontractModel>? marks = [];
      if(markResponse.data != null) {
        marks =
            SubcontractResponse.fromJson(response).data;
      }
      return marks;
    } catch (_) {
      return null;
    }
  }

  Future<ConfirmResponse?> createSubcontract(SubcontractRequest request) async {
    // await _authService.refreshToken();
    var token = await _authService.getToken();

    var response = await _apiClient.post(Urls.SUB_CONTRACT, request.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    String? statusCode = SubcontractResponse.fromJson(response!).statusCode;
    String? msg = SubcontractResponse.fromJson(response).msg;
    if(statusCode =='201'){
      return ConfirmResponse(true, msg!);
    }else {
      return ConfirmResponse(false, msg!);
    }
  }

  Future<ConfirmResponse?> deleteSubcontract(String id) async {
    // await _authService.refreshToken();
    var token =await _authService.getToken();
    var response = await _apiClient.delete(Urls.SUB_CONTRACT+'/'+id,
        headers: {'Authorization': 'Bearer $token'});
    String? statusCode = SubcontractResponse.fromJson(response!).statusCode;
    String? msg = SubcontractResponse.fromJson(response).msg;
    if(statusCode =='401'){
      return ConfirmResponse(true, msg!);
    }else {
      return ConfirmResponse(false, msg!);
    }
  }

  Future<ConfirmResponse?> updateSubcontract(SubcontractRequest request) async {
    // await _authService.refreshToken();
    var token = await _authService.getToken();

    var response = await _apiClient.put(Urls.SUB_CONTRACT, request.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    String? statusCode = SubcontractResponse.fromJson(response!).statusCode;
    String? msg = SubcontractResponse.fromJson(response).msg;
    if(statusCode =='204'){
      return ConfirmResponse(true, msg!);
    }else {
      return ConfirmResponse(false, msg!);
    }
  }
}