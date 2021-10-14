<?php

namespace App\Manager;

use App\AutoMapping;
use App\Entity\PriceEntity;
use App\Repository\PriceEntityRepository;
use App\Request\ContainerSpecificationPriceUpdateRequest;
use App\Request\DeleteRequest;
use App\Request\PriceCreateRequest;
use App\Request\PriceUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PriceManager
{
    private $autoMapping;
    private $entityManager;
    private $containerSpecificationManager;
    private $priceEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PriceEntityRepository $priceEntityRepository,
     ContainerSpecificationManager $containerSpecificationManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->containerSpecificationManager = $containerSpecificationManager;
        $this->priceEntityRepository = $priceEntityRepository;
    }

    public function create(PriceCreateRequest $request)
    {
        $priceEntity = $this->autoMapping->map(PriceCreateRequest::class, PriceEntity::class, $request);

        $this->entityManager->persist($priceEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $priceEntity;
    }

    public function update(PriceUpdateRequest $request)
    {
        $priceEntity = $this->priceEntityRepository->find($request->getId());

        if(!$priceEntity)
        {

        }
        else
        {
            $priceEntity = $this->autoMapping->mapToObject(PriceUpdateRequest::class, PriceEntity::class, $request, $priceEntity);

            $this->entityManager->flush();
            $this->entityManager->clear();

            if($request->getContainerSpecificationID())
            {
                //Now update the price of specific container specification
                $this->updateContainerSpecificationPrice($request->getContainerSpecificationID(), $request->getContainerSpecificationPrice(), $request->getUpdatedBy());
            }

            return $priceEntity;
        }
    }

    public function updateContainerSpecificationPrice($containerSpecificationID, $containerSpecificationPrice, $updatedBy)
    {
        $updateSpecificationPriceRequest = new ContainerSpecificationPriceUpdateRequest();

        $updateSpecificationPriceRequest->setId($containerSpecificationID);
        $updateSpecificationPriceRequest->setPrice($containerSpecificationPrice);
        $updateSpecificationPriceRequest->setUpdatedBy($updatedBy);

        $this->containerSpecificationManager->updatePrice($updateSpecificationPriceRequest);
    }

    public function getPrices()
    {
        $result = [];

        $result['prices'] = $this->priceEntityRepository->getAllPrices();

        $result['containerSpecifications'] = $this->containerSpecificationManager->getAllContainerSpecifications();

        return $result;
    }

    public function delete(DeleteRequest $request)
    {
        $item = $this->priceEntityRepository->find($request->getId());

        if(!$item)
        {
            return "No prices record was found!";
        }
        else
        {
            $this->entityManager->remove($item);
            $this->entityManager->flush();

            return $item;
        }
    }

}