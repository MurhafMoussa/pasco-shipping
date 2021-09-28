<?php

namespace App\Entity;

use App\Repository\ContainerSpecificationEntityRepository;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * @ORM\Entity(repositoryClass=ContainerSpecificationEntityRepository::class)
 */
class ContainerSpecificationEntity
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="float")
     */
    private $capacityCPM;

    /**
     * @ORM\Column(type="float")
     */
    private $widthInMeter;

    /**
     * @ORM\Column(type="float")
     */
    private $hightInMeter;

    /**
     * @ORM\Column(type="float")
     */
    private $lengthInMeter;

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
     * @ORM\Column(type="string", length=100)
     */
    private $name;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $price;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCapacityCPM(): ?float
    {
        return $this->capacityCPM;
    }

    public function setCapacityCPM(float $capacityCPM): self
    {
        $this->capacityCPM = $capacityCPM;

        return $this;
    }

    public function getWidthInMeter(): ?float
    {
        return $this->widthInMeter;
    }

    public function setWidthInMeter(float $widthInMeter): self
    {
        $this->widthInMeter = $widthInMeter;

        return $this;
    }

    public function getHightInMeter(): ?float
    {
        return $this->hightInMeter;
    }

    public function setHightInMeter(float $hightInMeter): self
    {
        $this->hightInMeter = $hightInMeter;

        return $this;
    }

    public function getLengthInMeter(): ?float
    {
        return $this->lengthInMeter;
    }

    public function setLengthInMeter(float $lengthInMeter): self
    {
        $this->lengthInMeter = $lengthInMeter;

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

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getPrice(): ?float
    {
        return $this->price;
    }

    public function setPrice(?float $price): self
    {
        $this->price = $price;

        return $this;
    }
}
