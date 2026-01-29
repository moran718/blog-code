package com.mr.blog.websocket;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mr.blog.game.GameRoomManager;
import com.mr.blog.game.Room;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;

@Component
public class GameWebSocketHandler extends TextWebSocketHandler {

    private final GameRoomManager roomManager;
    private final ObjectMapper mapper = new ObjectMapper();
    private final java.util.Set<WebSocketSession> onlineSessions = java.util.concurrent.ConcurrentHashMap.newKeySet();

    public GameWebSocketHandler(GameRoomManager roomManager) {
        this.roomManager = roomManager;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        onlineSessions.add(session);
        System.out.println("New connection: " + session.getId());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        onlineSessions.remove(session);
        handleLeave(session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        JsonNode json = mapper.readTree(message.getPayload());
        String type = json.get("type").asText();

        switch (type) {
            case "LIST_ROOMS":
                sendRoomList(session);
                break;
            case "CREATE_ROOM":
                createRoom(session, json.get("name").asText());
                break;
            case "JOIN_ROOM":
                joinRoom(session, json.get("roomId").asText());
                break;
            case "MOVE":
                handleMove(session, json);
                break;
            case "RESTART":
                handleRestart(session);
                break;
            case "LEAVE_ROOM":
                handleLeave(session);
                break;
        }
    }

    private void broadcastRoomList() {
        try {
            Map<String, Object> msg = Map.of(
                    "type", "ROOM_LIST",
                    "rooms", roomManager.getRoomList());
            TextMessage textMessage = new TextMessage(mapper.writeValueAsString(msg));
            for (WebSocketSession session : onlineSessions) {
                if (session.isOpen()) {
                    session.sendMessage(textMessage);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void sendRoomList(WebSocketSession session) throws IOException {
        Map<String, Object> msg = Map.of(
                "type", "ROOM_LIST",
                "rooms", roomManager.getRoomList());
        session.sendMessage(new TextMessage(mapper.writeValueAsString(msg)));
    }

    private void createRoom(WebSocketSession session, String name) throws IOException {
        Room room = roomManager.createRoom(name, session);
        roomManager.mapPlayerToRoom(session.getId(), room.getId());
        room.setBlackPlayer(session);

        Map<String, Object> msg = Map.of(
                "type", "ROOM_CREATED",
                "roomId", room.getId());
        session.sendMessage(new TextMessage(mapper.writeValueAsString(msg)));

        broadcastRoomList();
    }

    private void joinRoom(WebSocketSession session, String roomId) throws IOException {
        Room room = roomManager.getRoom(roomId);
        if (room == null) {
            sendError(session, "Room not found");
            return;
        }
        if (room.getBlackPlayer() != null && room.getWhitePlayer() != null) {
            sendError(session, "Room is full");
            return;
        }

        roomManager.mapPlayerToRoom(session.getId(), roomId);

        if (room.getBlackPlayer() == null) {
            room.setBlackPlayer(session);
        } else {
            room.setWhitePlayer(session);
        }

        // Check if full to start
        if (room.getBlackPlayer() != null && room.getWhitePlayer() != null) {
            room.setStatus("playing");
            startGame(room);
        } else {
            Map<String, Object> msg = Map.of("type", "WAITING", "roomId", roomId);
            session.sendMessage(new TextMessage(mapper.writeValueAsString(msg)));
        }

        broadcastRoomList();
    }

    private void handleLeave(WebSocketSession session) throws IOException {
        Room room = roomManager.getRoomByPlayer(session.getId());
        if (room != null) {
            WebSocketSession opponent = null;
            if (room.getBlackPlayer() != null && !room.getBlackPlayer().getId().equals(session.getId())) {
                opponent = room.getBlackPlayer();
            } else if (room.getWhitePlayer() != null && !room.getWhitePlayer().getId().equals(session.getId())) {
                opponent = room.getWhitePlayer();
            }

            roomManager.removePlayer(session.getId());

            // Notify opponent
            if (opponent != null && opponent.isOpen()) {
                Map<String, Object> msg = Map.of("type", "OPPONENT_LEFT");
                opponent.sendMessage(new TextMessage(mapper.writeValueAsString(msg)));
            }
        }
        broadcastRoomList();
    }

    private void startGame(Room room) throws IOException {
        // Notify Black
        Map<String, Object> msg1 = Map.of("type", "GAME_START", "role", 1); // 1=Black
        room.getBlackPlayer().sendMessage(new TextMessage(mapper.writeValueAsString(msg1)));

        // Notify White
        Map<String, Object> msg2 = Map.of("type", "GAME_START", "role", 2); // 2=White
        room.getWhitePlayer().sendMessage(new TextMessage(mapper.writeValueAsString(msg2)));
    }

    private void handleMove(WebSocketSession session, JsonNode json) throws IOException {
        Room room = roomManager.getRoomByPlayer(session.getId());
        if (room == null)
            return;

        int x = json.get("x").asInt();
        int y = json.get("y").asInt();
        int role = (room.getBlackPlayer().getId().equals(session.getId())) ? 1 : 2;

        boolean success = room.makeMove(x, y, role);
        if (success) {
            // Broadcast move to both
            Map<String, Object> msg = Map.of(
                    "type", "MOVE",
                    "x", x, "y", y,
                    "role", role);
            String txt = mapper.writeValueAsString(msg);
            room.getBlackPlayer().sendMessage(new TextMessage(txt));
            room.getWhitePlayer().sendMessage(new TextMessage(txt));

            if (room.getStatus().equals("ended")) {
                Map<String, Object> endMsg = Map.of("type", "GAME_OVER", "winner", room.getWinner());
                String endTxt = mapper.writeValueAsString(endMsg);
                room.getBlackPlayer().sendMessage(new TextMessage(endTxt));
                room.getWhitePlayer().sendMessage(new TextMessage(endTxt));
            }
        }
    }

    private void handleRestart(WebSocketSession session) throws IOException {
        Room room = roomManager.getRoomByPlayer(session.getId());
        if (room == null)
            return;
        room.reset();
        startGame(room);
    }

    private void sendError(WebSocketSession session, String error) throws IOException {
        Map<String, Object> msg = Map.of("type", "ERROR", "message", error);
        session.sendMessage(new TextMessage(mapper.writeValueAsString(msg)));
    }
}
