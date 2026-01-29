package com.mr.blog.game;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class GameRoomManager {
    private final Map<String, Room> rooms = new ConcurrentHashMap<>();
    // Map session ID to Room ID for quick lookup
    private final Map<String, String> playerRoomMap = new ConcurrentHashMap<>();

    public Room createRoom(String name, WebSocketSession creator) {
        Room room = new Room(name);
        rooms.put(room.getId(), room);
        return room;
    }

    public Room getRoom(String roomId) {
        return rooms.get(roomId);
    }

    public void removeRoom(String roomId) {
        rooms.remove(roomId);
    }

    public List<Map<String, Object>> getRoomList() {
        List<Map<String, Object>> list = new ArrayList<>();
        rooms.values().forEach(r -> {
            list.add(Map.of(
                    "id", r.getId(),
                    "name", r.getName(),
                    "status", r.getStatus(),
                    "players", (r.getBlackPlayer() != null ? 1 : 0) + (r.getWhitePlayer() != null ? 1 : 0)));
        });
        return list;
    }

    public void mapPlayerToRoom(String sessionId, String roomId) {
        playerRoomMap.put(sessionId, roomId);
    }

    public void removePlayer(String sessionId) {
        String roomId = playerRoomMap.remove(sessionId);
        if (roomId != null) {
            Room room = rooms.get(roomId);
            if (room != null) {
                if (room.getBlackPlayer() != null && room.getBlackPlayer().getId().equals(sessionId)) {
                    room.setBlackPlayer(null);
                } else if (room.getWhitePlayer() != null && room.getWhitePlayer().getId().equals(sessionId)) {
                    room.setWhitePlayer(null);
                }

                // If room is empty, remove it
                if (room.getBlackPlayer() == null && room.getWhitePlayer() == null) {
                    rooms.remove(roomId);
                } else {
                    // If one player remains, reset status to waiting
                    room.setStatus("waiting");
                }
            }
        }
    }

    public Room getRoomByPlayer(String sessionId) {
        String roomId = playerRoomMap.get(sessionId);
        return roomId != null ? rooms.get(roomId) : null;
    }
}
