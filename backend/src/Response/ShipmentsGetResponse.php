<?php

namespace App\Response;

class ShipmentsGetResponse
{
    public $id;

    public $target;

    public $supplierName;

    public $distributorName;

    public $exportWarehouseName;

    public $importWarehouseName;

    public $quantity;

    public $image;

    public $createdAt;

    public $updatedAt;

    public $productCategoryName;

    public $subProductCategoryName;

    public $unit;

    public $receiverName;

    public $receiverPhoneNumber;

    public $markNumber;

    public $packetingBy;

    public $paymentTime;

    public $weight;

    public $volume;

    public $qrCode;

    public $guniQuantity;

    public $vehicleIdentificationNumber;

    public $extraSpecification;

    public $status;

    // external warehouse info
    public $externalWarehouseInfo;

    // indicates to whether external wharehouse is used or not.
    public $isExternalWarehouse;

    public $clientUsername;

    public $clientUserImage;
    
    public $orderUpdatedByUser;

    public $orderUpdatedByUserImage;
    
    public $shipmentStatusCreatedByUser;

    public $shipmentStatusUpdatedByUser;

}