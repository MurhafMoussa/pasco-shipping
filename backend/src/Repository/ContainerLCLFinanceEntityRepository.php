<?php

namespace App\Repository;

use App\Entity\AdminProfileEntity;
use App\Entity\ContainerLCLFinanceEntity;
use App\Entity\ProxyEntity;
use App\Entity\SubcontractEntity;
use App\Entity\WarehouseEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ContainerLCLFinanceEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ContainerLCLFinanceEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ContainerLCLFinanceEntity[]    findAll()
 * @method ContainerLCLFinanceEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ContainerLCLFinanceEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ContainerLCLFinanceEntity::class);
    }

    public function getCurrentTotalCostByFilterOptions($containerID, $status)
    {
        $query = $this->createQueryBuilder('containerFinance')
            ->select('SUM(containerFinance.stageCost) as currentTotalCost');

        if($containerID)
        {
            $query->andWhere('containerFinance.containerID = :containerID');
            $query->setParameter('containerID', $containerID);
        }

        if($status)
        {
            $query->andWhere('containerFinance.status = :status');
            $query->setParameter('status', $status);
        }
        
        return $query->getQuery()->getOneOrNullResult();
    }

    public function getContainerLCLFinancesByContainerID($containerID)
    {
        return $this->createQueryBuilder('containerLCLFinanceEntity')
            ->select('containerLCLFinanceEntity.containerID', 'containerLCLFinanceEntity.stageCost as buyingCost', 'containerLCLFinanceEntity.stageDescription', 'containerLCLFinanceEntity.status', 'containerLCLFinanceEntity.paymentType',
                'containerLCLFinanceEntity.createdAt', 'containerLCLFinanceEntity.updatedAt', 'containerLCLFinanceEntity.createdBy', 'containerLCLFinanceEntity.updatedBy', 'containerLCLFinanceEntity.currency', 'containerLCLFinanceEntity.proxyID',
             'containerLCLFinanceEntity.subcontractID', 'subcontractEntity.fullName as subcontractName', 'proxyEntity.fullName as proxyName', 'adminProfileEntityOne.userName as createdByUser', 'adminProfileEntityOne.image as createdByUserImage',
                'adminProfileEntityTwo.userName as updatedByUser', 'adminProfileEntityTwo.image as updatedByUserImage')

            ->andWhere('containerLCLFinanceEntity.containerID = :containerID')
            ->setParameter('containerID', $containerID)

            ->leftJoin(
                SubcontractEntity::class,
                'subcontractEntity',
                Join::WITH,
                'subcontractEntity.id = containerLCLFinanceEntity.subcontractID'
            )

            ->leftJoin(
                ProxyEntity::class,
                'proxyEntity',
                Join::WITH,
                'proxyEntity.id = containerLCLFinanceEntity.proxyID'
            )

            ->leftJoin(
                AdminProfileEntity::class,
                'adminProfileEntityOne',
                Join::WITH,
                'adminProfileEntityOne.userID = containerLCLFinanceEntity.createdBy'
            )

            ->leftJoin(
                AdminProfileEntity::class,
                'adminProfileEntityTwo',
                Join::WITH,
                'adminProfileEntityTwo.userID = containerLCLFinanceEntity.updatedBy'
            )

            ->orderBy('containerLCLFinanceEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function filterContainerLCLFinances($containerID, $status)
    {
        $query = $this->createQueryBuilder('containerFinance')
            ->select('containerFinance.id', 'containerFinance.containerID', 'containerFinance.status', 'containerFinance.stageCost', 'containerFinance.stageDescription', 'containerFinance.currency', 'containerFinance.createdAt',
                'containerFinance.updatedAt', 'containerFinance.createdBy', 'containerFinance.updatedBy', 'containerFinance.subcontractID', 'containerFinance.importWarehouseID', 'containerFinance.paymentType',
                'containerFinance.proxyID', 'containerFinance.chequeNumber', 'adminProfile1.userName as createdByUser', 'adminProfile1.image as createdByUserImage', 'adminProfile2.userName as updatedByUser', 'adminProfile2.image as updatedByUserImage',
             'subcontractEntity.fullName as subcontractName', 'warehouseEntity.name as importWarehouseName', 'proxyEntity.fullName as proxyName')

            ->leftJoin(
                AdminProfileEntity::class,
                'adminProfile1',
                Join::WITH,
                'adminProfile1.userID = containerFinance.createdBy'
            )

            ->leftJoin(
                AdminProfileEntity::class,
                'adminProfile2',
                Join::WITH,
                'adminProfile2.userID = containerFinance.updatedBy'
            )

            ->leftJoin(
                SubcontractEntity::class,
                'subcontractEntity',
                Join::WITH,
                'subcontractEntity.id = containerFinance.subcontractID'
            )

            ->leftJoin(
                WarehouseEntity::class,
                'warehouseEntity',
                Join::WITH,
                'warehouseEntity.id = containerFinance.importWarehouseID'
            )

            ->leftJoin(
                ProxyEntity::class,
                'proxyEntity',
                Join::WITH,
                'proxyEntity.id = containerFinance.proxyID'
            )

            ->orderBy('containerFinance.id', 'DESC');

        if($containerID)
        {
            $query->andWhere('containerFinance.containerID = :containerID');
            $query->setParameter('containerID', $containerID);
        }

        if($status)
        {
            $query->andWhere('containerFinance.status = :status');
            $query->setParameter('status', $status);
        }
        
        return $query->getQuery()->getResult();
    }

    public function deleteAllContainersLCLFinances()
    {
        return $this->createQueryBuilder('container_finance_entity')
            ->delete()

            ->getQuery()
            ->getResult();
    }

}
