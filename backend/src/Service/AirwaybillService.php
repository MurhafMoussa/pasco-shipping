<?php

namespace App\Service;

use App\AutoMapping;
use App\Constant\HolderTypeConstant;
use App\Constant\ShippingTypeConstant;
use App\Constant\ShippingWayConstant;
use App\Entity\AirwaybillEntity;
use App\Manager\AirwaybillManager;
use App\Request\AirwaybillCreateRequest;
use App\Request\AirwaybillShippingStatusUpdateRequest;
use App\Request\AirwaybillStatusUpdateRequest;
use App\Request\AirwaybillUpdateRequest;
use App\Request\DeleteRequest;
use App\Response\AirwaybillCreateResponse;
use App\Response\AirwaybillFilterResponse;
use App\Response\AirwaybillGetResponse;
use App\Response\DeleteAllGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class AirwaybillService
{
    private $autoMapping;
    private $airwaybillManager;
    private $params;
    private $trackService;

    public function __construct(AutoMapping $autoMapping, AirwaybillManager $airwaybillManager, ParameterBagInterface $params, TrackService $trackService)
    {
        $this->autoMapping = $autoMapping;
        $this->airwaybillManager = $airwaybillManager;
        $this->trackService = $trackService;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function create(AirwaybillCreateRequest $request)
    {
        $airwaybillResult = $this->airwaybillManager->create($request);

        return $this->autoMapping->map(AirwaybillEntity::class, AirwaybillCreateResponse::class, $airwaybillResult);
    }

    public function update(AirwaybillUpdateRequest $request)
    {
        $airwaybillResult = $this->airwaybillManager->update($request);

        return $this->autoMapping->map(AirwaybillEntity::class, AirwaybillGetResponse::class, $airwaybillResult);
    }

    public function updateStatus(AirwaybillStatusUpdateRequest $request)
    {
        $airwaybillResult = $this->airwaybillManager->updateStatus($request);

        return $this->autoMapping->map(AirwaybillEntity::class, AirwaybillGetResponse::class, $airwaybillResult);
    }

    public function updateShippingStatus(AirwaybillShippingStatusUpdateRequest $request)
    {
        $airwaybillResult = $this->airwaybillManager->updateShippingStatus($request);

        return $this->autoMapping->map(AirwaybillEntity::class, AirwaybillGetResponse::class, $airwaybillResult);
    }

    public function getAirwaybillsByStatus($status)
    {
        $airwaybillsResponse = [];

        $airwaybills = $this->airwaybillManager->getAirwaybillsByStatus($status);

        foreach($airwaybills as $airwaybill)
        {
            if($airwaybill['createdByUserImage'])
            {
                $airwaybill['createdByUserImage'] = $this->params . $airwaybill['createdByUserImage'];
            }

            if($airwaybill['updatedByUserImage'])
            {
                $airwaybill['updatedByUserImage'] = $this->params . $airwaybill['updatedByUserImage'];
            }

            $airwaybillsResponse[] = $this->autoMapping->map('array', AirwaybillGetResponse::class, $airwaybill);
        }

        return $airwaybillsResponse;
    }

    public function getAirwaybillById($id)
    {
        $airwaybill['totalGunnyQuantity'] = 0;
        $airwaybill['totalReceivedShipmentsQuantity'] = 0;

        $airwaybill = $this->airwaybillManager->getAirwaybillById($id);

        if($airwaybill)
        {
            if($airwaybill['type'] == ShippingTypeConstant::$FCL_SHIPPING_TYPE)
            {
                if($airwaybill['consigneeID'] == null)
                {
                    $airwaybill['consigneeName'] = $airwaybill['consignee'];
                }
            }

            if($airwaybill['createdByUser'] == null)
            {
                $airwaybill['createdByUser'] = $airwaybill['clientUserName'];

                if($airwaybill['clientUserImage'])
                {
                    $airwaybill['createdByUserImage'] = $airwaybill['clientUserImage'];
                }
            }

            $airwaybill['shipments'] = $this->trackService->getTracksByHolderTypeAndHolderID("airwaybill", $id);

            // get the sum of total gunny and the sum of total received shipments' quantity
            $airwaybill['totalGunnyQuantity'] = $this->getTotalGunnyByAirWaybillID($id);
            $airwaybill['totalReceivedShipmentsQuantity'] = $this->getTotalReceivedShipmentsQuantityByAirWaybillID($id);

            $airwaybill['freeWeight'] = $this->trackService->getCurrentFreeWeightOfAirWaybill($airwaybill);

            if ($airwaybill['createdByUserImage']) {
                $airwaybill['createdByUserImage'] = $this->params . $airwaybill['createdByUserImage'];
            }

            if ($airwaybill['updatedByUserImage']) {
                $airwaybill['updatedByUserImage'] = $this->params . $airwaybill['updatedByUserImage'];
            }
        }

        return $this->autoMapping->map('array', AirwaybillGetResponse::class, $airwaybill);
    }

    public function filterAirwaybills($request)
    {
        $airwaybillsResponse = [];

        $airwaybills = $this->airwaybillManager->filterAirwaybills($request);

        foreach($airwaybills as $airwaybill)
        {
            // get the sum of total gunny and the sum of total received shipments' quantity
            $airwaybill['totalGunnyQuantity'] = $this->getTotalGunnyByAirWaybillID($airwaybill['id']);
            $airwaybill['totalReceivedShipmentsQuantity'] = $this->getTotalReceivedShipmentsQuantityByAirWaybillID($airwaybill['id']);

            if($airwaybill['type'] == ShippingTypeConstant::$FCL_SHIPPING_TYPE)
            {
                if($airwaybill['consigneeID'] == null)
                {
                    $airwaybill['consigneeName'] = $airwaybill['consignee'];
                }
            }

            if($this->trackService->getTracksByHolderTypeAndHolderID(HolderTypeConstant::$AIRWAYBILL_HOLDER_TYPE, $airwaybill['id']))
            {
                $airwaybill['used'] = true;
            }
            else
            {
                $airwaybill['used'] = false;
            }

            if($airwaybill['createdByUser'] == null)
            {
                $airwaybill['createdByUser'] = $airwaybill['clientUserName'];

                if($airwaybill['clientUserImage'])
                {
                    $airwaybill['createdByUserImage'] = $airwaybill['clientUserImage'];
                }
            }

            if($airwaybill['createdByUserImage'])
            {
                $airwaybill['createdByUserImage'] = $this->params . $airwaybill['createdByUserImage'];
            }

            if($airwaybill['updatedByUserImage'])
            {
                $airwaybill['updatedByUserImage'] = $this->params . $airwaybill['updatedByUserImage'];
            }

            $airwaybillsResponse[] = $this->autoMapping->map('array', AirwaybillFilterResponse::class, $airwaybill);
        }

        return $airwaybillsResponse;
    }

    public function getTotalGunnyByAirWaybillID($airWaybillID)
    {
        $totalGunny = 0;

        $shipments = $this->trackService->getTracksByHolderTypeAndHolderID(HolderTypeConstant::$AIRWAYBILL_HOLDER_TYPE, $airWaybillID);

        if($shipments)
        {
            foreach($shipments as $shipment)
            {
                $totalGunny += $shipment->guniQuantity;
            }
        }

        return $totalGunny;
    }

    public function getTotalReceivedShipmentsQuantityByAirWaybillID($airWaybillID)
    {
        $totalReceivedShipmentsQuantity = 0;

        $shipments = $this->trackService->getTracksByHolderTypeAndHolderID(HolderTypeConstant::$AIRWAYBILL_HOLDER_TYPE, $airWaybillID);

        if($shipments)
        {
            foreach($shipments as $shipment)
            {
                $totalReceivedShipmentsQuantity += $shipment->receivedShipmentQuantity;
            }
        }

        return $totalReceivedShipmentsQuantity;
    }

    public function deleteAirWaybillById(DeleteRequest $request)
    {
        // First, check if the air waybill is being used (shipments are stored in it)
        $isUsed = $this->trackService->getTracksByHolderTypeAndHolderID(HolderTypeConstant::$AIRWAYBILL_HOLDER_TYPE, $request->getId());

        $result = $this->airwaybillManager->deleteAirWaybillById($request, $isUsed);

        if($result instanceof AirwaybillEntity)
        {
            return $this->autoMapping->map(AirwaybillEntity::class, AirwaybillGetResponse::class, $result);
        }
        else
        {
            return $result;
        }
    }

    public function deleteAllAirwaybills()
    {
        $result = [];

        $result['numbersOfItemDeleted'] = $this->airwaybillManager->deleteAllAirwaybills();

        return $this->autoMapping->map('array', DeleteAllGetResponse::class, $result);
    }

}