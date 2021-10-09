import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasco_shipping/generated/l10n.dart';
import 'package:pasco_shipping/module_shipment_invoices/response/invoice_response.dart';
import 'package:pasco_shipping/utils/styles/AppTextStyle.dart';

class BillingCard extends StatelessWidget {
  final BillingDetails model;
  const BillingCard({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      S.of(context).stageCost,
                      style: AppTextStyle.mediumBlack,
                    ),
                    Text(
                      model.stageCost.toString(),
                      style: AppTextStyle.mediumBlueBold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      S.of(context).shipmentStatus+': ',
                      style: AppTextStyle.mediumBlack,
                    ),
                    Text(
                      model.shipmentStatus ?? '',
                      style: AppTextStyle.mediumBlueBold,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      S.of(context).description,
                      style: AppTextStyle.mediumBlack,
                    ),
                    Text(
                      model.stageDescription ?? '',
                      style: AppTextStyle.mediumBlueBold,
                    ),
                  ],
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Added by: ',
              //         style: AppTextStyle.mediumBlack,
              //       ),
              //       Text(
              //         model.createdByUser ?? '',
              //         style: AppTextStyle.mediumBlueBold,
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Text(
              //         'Added at: ',
              //         style: AppTextStyle.mediumBlack,
              //       ),
              //       Text(
              //         model.createdAt.toString().split('.').first,
              //         style: AppTextStyle.mediumBlueBold,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
