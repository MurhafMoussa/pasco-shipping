<?php

namespace App\Manager;

use App\AutoMapping;
use App\Constant\ContainerStatusConstant;
use App\Entity\ContainerEntity;
use App\Repository\ContainerEntityRepository;
use App\Request\ContainerCreateRequest;
use App\Request\ContainerUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ContainerManager
{
    private $autoMapping;
    private $entityManager;
    private $containerEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ContainerEntityRepository $containerEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->containerEntityRepository = $containerEntityRepository;
    }

    public function create(ContainerCreateRequest $request)
    {
        $containerEntity = $this->autoMapping->map(ContainerCreateRequest::class, ContainerEntity::class, $request);

        $containerEntity->setStatus(ContainerStatusConstant::$NOTFULL_CONTAINER_STATUS);

        $this->entityManager->persist($containerEntity);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $containerEntity;
    }

    public function update(ContainerUpdateRequest $request)
    {
        $containerEntity = $this->containerEntityRepository->find($request->getId());

        if(!$containerEntity)
        {
            return  $containerEntity;
        }
        else
        {
            $containerEntity = $this->autoMapping->mapToObject(ContainerUpdateRequest::class, ContainerEntity::class,
                $request, $containerEntity);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $containerEntity;
        }
    }

    public function getByStatus($status)
    {
        return $this->containerEntityRepository->getByStatus($status);
    }

    public function getContainerById($id)
    {
        return $this->containerEntityRepository->getContainerById($id);
    }

}