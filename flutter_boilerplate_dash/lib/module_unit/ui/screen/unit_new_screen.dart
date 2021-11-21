import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_general/ui/screen/connection_error_screen.dart';
import 'package:pasco_shipping/module_theme/service/theme_service/theme_service.dart';
import 'package:pasco_shipping/module_unit/state_manger/new_unit_state_manger.dart';
import 'package:pasco_shipping/module_unit/ui/state/addnew_state/add_state.dart';
import 'package:pasco_shipping/module_unit/ui/state/addnew_state/add_unit_init.dart';
import 'package:pasco_shipping/utils/widget/alert_widget.dart';
import 'package:pasco_shipping/utils/widget/background.dart';
import 'package:pasco_shipping/utils/widget/loding_indecator.dart';

@injectable
class AddNewUnit extends StatefulWidget {
  final AddUnitStateManager _stateManager;

  const AddNewUnit(this._stateManager);

  @override
  _AddNewCountryState createState() => _AddNewCountryState();
}

class _AddNewCountryState extends State<AddNewUnit> {
  late AddUnitState currentState;

  @override
  Widget build(BuildContext context) {
    return Background(
      showFilter: false,
        goBack: (){
        },
        child: Container(
          width: double.maxFinite,
          child: Center(
            child: Container(
                constraints: BoxConstraints(
                    maxWidth: 600
                ),
                child: Screen()),
          ),
        ),
        title: S.of(context).addNewUnit
    );
  }


  @override
  void initState() {
    super.initState();
    currentState = InitAddState();
    widget._stateManager.stateStream.listen((event) {
      print("newEvent"+event.toString());
      currentState = event;
      if (this.mounted) {
        setState(() {});
      }
    });
    // widget._stateManager.getCountries();
  }

  Widget Screen(){
    if(currentState is LoadingAddState){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingIndicator(AppThemeDataService.AccentColor),
          ],
        ),
      );
    }
    else if (currentState is InitAddState){
      return AddUnitInit(onSave: (request){
        widget._stateManager.createUnit(request);
      },);
    }
    else if (currentState is SuccessfullyAddState){
      Future.delayed(Duration.zero, () =>  AlertWidget.showAlert(context, true, S.of(context).addedSuccessfully));
      return AddUnitInit(onSave: (request){
        widget._stateManager.createUnit(request);
      },);
    }
    else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ErrorScreen(retry: (){},error: 'error',isEmptyData: false,),
          ],
        ),
      );
    }
  }
}
