<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\AirwaybillFinanceEntity;
use App\Manager\AirwaybillFinanceManager;
use App\Request\AirwaybillFinanceCreateRequest;
use App\Request\AirwaybillFinanceFilterRequest;
use App\Response\AirwaybillFinanceCreateResponse;
use App\Response\AirwaybillFinanceGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class AirwaybillFinanceService
{
    private $autoMapping;
    private $airwaybillFinanceManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, AirwaybillFinanceManager $airwaybillFinanceManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->airwaybillFinanceManager = $airwaybillFinanceManager;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function create(AirwaybillFinanceCreateRequest $request)
    {
        $airwaybillEntityResult = $this->airwaybillFinanceManager->create($request);

        return $this->autoMapping->map(AirwaybillFinanceEntity::class, AirwaybillFinanceCreateResponse::class, $airwaybillEntityResult);
    }

    public function filterAirwaybillFinances(AirwaybillFinanceFilterRequest $request)
    {
        $airwaybillFinances = $this->airwaybillFinanceManager->filterAirwaybillFinances($request);
        
        foreach($airwaybillFinances['airwaybillFinances'] as $airwaybillFinance)
        {
            if($airwaybillFinance['createdByUserImage'])
            {
                $airwaybillFinance['createdByUserImage'] = $this->params . $airwaybillFinance['createdByUserImage'];
            }

            if($airwaybillFinance['updatedByUserImage'])
            {
                $airwaybillFinance['updatedByUserImage'] = $this->params . $airwaybillFinance['updatedByUserImage'];
            }
        }

        return $this->autoMapping->map('array', AirwaybillFinanceGetResponse::class, $airwaybillFinances);
    }

}