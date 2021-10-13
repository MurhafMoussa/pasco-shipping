<?php

namespace App\Entity;

use App\Repository\AirwaybillFCLFinanceEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=AirwaybillFCLFinanceEntityRepository::class)
 */
class AirwaybillFCLFinanceEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="integer")
     */
    private $airwaybillID;

    /**
     * @ORM\Column(type="string", length=50)
     */
    private $status;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $stageDescription;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $stageCost;

    /**
     * @ORM\Column(type="string", length=50)
     */
    private $currency;

    /**
     * @Gedmo\Timestampable(on="create")
     * @ORM\Column(type="datetime")
     */
    private $createdAt;

    /**
     * @Gedmo\Timestampable(on="update")
     * @ORM\Column(type="datetime")
     */
    private $updatedAt;

    /**
     * @ORM\Column(type="integer")
     */
    private $createdBy;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $updatedBy;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $subcontractID;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $importWarehouseID;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $trackNumber;

    /**
     * @ORM\Column(type="integer")
     */
    private $clientUserID;

    /**
     * @ORM\Column(type="string", length=50)
     */
    private $paymentType;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $chequeNumber;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $financialFundName;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $sellingCost;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $buyingCost;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getAirwaybillID(): ?int
    {
        return $this->airwaybillID;
    }

    public function setAirwaybillID(int $airwaybillID): self
    {
        $this->airwaybillID = $airwaybillID;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;

        return $this;
    }

    public function getStageDescription(): ?string
    {
        return $this->stageDescription;
    }

    public function setStageDescription(?string $stageDescription): self
    {
        $this->stageDescription = $stageDescription;

        return $this;
    }

    public function getStageCost(): ?float
    {
        return $this->stageCost;
    }

    public function setStageCost(float $stageCost): self
    {
        $this->stageCost = $stageCost;

        return $this;
    }

    public function getCurrency(): ?string
    {
        return $this->currency;
    }

    public function setCurrency(string $currency): self
    {
        $this->currency = $currency;

        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(\DateTimeInterface $createdAt): self
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(\DateTimeInterface $updatedAt): self
    {
        $this->updatedAt = $updatedAt;

        return $this;
    }

    public function getCreatedBy(): ?int
    {
        return $this->createdBy;
    }

    public function setCreatedBy(int $createdBy): self
    {
        $this->createdBy = $createdBy;

        return $this;
    }

    public function getUpdatedBy(): ?int
    {
        return $this->updatedBy;
    }

    public function setUpdatedBy(?int $updatedBy): self
    {
        $this->updatedBy = $updatedBy;

        return $this;
    }

    public function getSubcontractID(): ?int
    {
        return $this->subcontractID;
    }

    public function setSubcontractID(?int $subcontractID): self
    {
        $this->subcontractID = $subcontractID;

        return $this;
    }

    public function getImportWarehouseID(): ?int
    {
        return $this->importWarehouseID;
    }

    public function setImportWarehouseID(?int $importWarehouseID): self
    {
        $this->importWarehouseID = $importWarehouseID;

        return $this;
    }

    public function getTrackNumber(): ?string
    {
        return $this->trackNumber;
    }

    public function setTrackNumber(string $trackNumber): self
    {
        $this->trackNumber = $trackNumber;

        return $this;
    }

    public function getClientUserID(): ?int
    {
        return $this->clientUserID;
    }

    public function setClientUserID(int $clientUserID): self
    {
        $this->clientUserID = $clientUserID;

        return $this;
    }

    public function getPaymentType(): ?string
    {
        return $this->paymentType;
    }

    public function setPaymentType(string $paymentType): self
    {
        $this->paymentType = $paymentType;

        return $this;
    }

    public function getChequeNumber(): ?string
    {
        return $this->chequeNumber;
    }

    public function setChequeNumber(string $chequeNumber): self
    {
        $this->chequeNumber = $chequeNumber;

        return $this;
    }

    public function getFinancialFundName(): ?string
    {
        return $this->financialFundName;
    }

    public function setFinancialFundName(string $financialFundName): self
    {
        $this->financialFundName = $financialFundName;

        return $this;
    }

    public function getSellingCost(): ?float
    {
        return $this->sellingCost;
    }

    public function setSellingCost(?float $sellingCost): self
    {
        $this->sellingCost = $sellingCost;

        return $this;
    }

    public function getBuyingCost(): ?float
    {
        return $this->buyingCost;
    }

    public function setBuyingCost(?float $buyingCost): self
    {
        $this->buyingCost = $buyingCost;

        return $this;
    }
}
