<?php

namespace App\Service;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Manager\ChatManager;
use App\Request\ChatCreateRequest;
use App\Request\ChatFilterRequest;
use App\Request\ChatStateUpdateRequest;
use App\Response\ChatCreateResponse;
use App\Response\ChatGetResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ChatService
{
    private $autoMapping;
    private $chatManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, ChatManager $chatManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->chatManager = $chatManager;
        $this->params = $params->get('upload_base_url').'/';
    }

    public function chatWithAdministration(ChatCreateRequest $request)
    {
        $request->setRoomID($this->roomID());

        $result = $this->chatManager->chatWithAdministration($request);

        if($result instanceof ChatRoomEntity)
        {
            return $this->autoMapping->map(ChatRoomEntity::class, ChatCreateResponse::class, $result);
        }
        elseif(is_array($result))
        {
            return $this->autoMapping->map('array', ChatCreateResponse::class, $result);
        }
    }

    public function updateState(ChatStateUpdateRequest $request)
    {
        $chatRoomEntity = $this->chatManager->updateState($request);

        return $this->autoMapping->map(ChatRoomEntity::class, ChatGetResponse::class, $chatRoomEntity);
    }

    // for generate roomID
    public function roomID()
    {
        $data = random_bytes(16);

        $data[0] = chr(ord('a') ); 
        $data[1] = chr(ord('v') ); 
        $data[2] = chr(ord('s') ); 
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);

        return  vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }

    public function getChatByUser($userID)
    {
        $chatResponse = [];

        $chats = $this->chatManager->getChatByUser($userID);

        if ($chats)
        {
            foreach ($chats as $chat)
            {
                $chatResponse[] = $this->autoMapping->map('array', ChatGetResponse::class, $chat);
            }
        }

        return $chatResponse;
    }

    public function filterChats(ChatFilterRequest $request)
    {
        $chatResponse = [];

        $chats = $this->chatManager->filterChats($request);

        if ($chats)
        {
            foreach ($chats as $chat)
            {
                if ($chat['clientUserImage'])
                {
                    $chat['clientUserImage'] = $this->params . $chat['clientUserImage'];
                }

                $chatResponse[] = $this->autoMapping->map('array', ChatGetResponse::class, $chat);
            }
        }

        return $chatResponse;
    }

    public function deleteAllChats()
    {
        return $this->chatManager->deleteAllChats();
    }

}