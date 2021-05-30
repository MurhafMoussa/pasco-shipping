<?php

namespace App\Request;

class ShipmentStatusCreateRequest
{
    private $shipmentID;

    private $trackNumber;

    private $shipmentStatus;

    private $statusDetails;

    private $isInOneHolder;

    private $packed;

    public function setShipmentID($shipmentID)
    {
        $this->shipmentID = $shipmentID;
    }

    public function setTrackNumber($trackNumber)
    {
        $this->trackNumber = $trackNumber;
    }

    public function setShipmentStatus($shipmentStatus)
    {
        $this->shipmentStatus = $shipmentStatus;
    }

    public function setIsInOneHolder($isInOneHolder)
    {
        $this->isInOneHolder = $isInOneHolder;
    }

    public function setPacked($packed)
    {
        $this->packed = $packed;
    }

}