<?php

namespace App\Request;

class WarehouseFinanceCreateRequest
{
    private $warehouseID;

    private $cost;

    private $description;

    private $createdBy;

    public function setCreatedBy($userID)
    {
        $this->createdBy = $userID;
    }

}