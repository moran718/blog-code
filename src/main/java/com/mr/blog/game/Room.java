package com.mr.blog.game;

import org.springframework.web.socket.WebSocketSession;

import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

public class Room {
    private String id;
    private String name;
    private WebSocketSession blackPlayer;
    private WebSocketSession whitePlayer;
    private int[][] board = new int[15][15];
    private int turn = 1; // 1: Black, 2: White
    private String status = "waiting"; // waiting, playing, ended
    private int winner = 0;

    public Room(String name) {
        this.id = UUID.randomUUID().toString().substring(0, 8);
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public WebSocketSession getBlackPlayer() {
        return blackPlayer;
    }

    public void setBlackPlayer(WebSocketSession blackPlayer) {
        this.blackPlayer = blackPlayer;
    }

    public WebSocketSession getWhitePlayer() {
        return whitePlayer;
    }

    public void setWhitePlayer(WebSocketSession whitePlayer) {
        this.whitePlayer = whitePlayer;
    }

    public int getTurn() {
        return turn;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getWinner() {
        return winner;
    }

    public synchronized boolean makeMove(int x, int y, int role) {
        if (role != turn)
            return false;
        if (x < 0 || x >= 15 || y < 0 || y >= 15)
            return false;
        if (board[y][x] != 0)
            return false;

        board[y][x] = role;

        if (checkWin(x, y, role)) {
            status = "ended";
            winner = role;
        } else {
            // Switch turn
            turn = (turn == 1) ? 2 : 1;
        }
        return true;
    }

    private boolean checkWin(int x, int y, int role) {
        int[][] dirs = { { 1, 0 }, { 0, 1 }, { 1, 1 }, { 1, -1 } };
        for (int[] dir : dirs) {
            int count = 1;
            // Forward
            for (int i = 1; i < 5; i++) {
                int nx = x + dir[0] * i;
                int ny = y + dir[1] * i;
                if (!checkPos(nx, ny, role))
                    break;
                count++;
            }
            // Backward
            for (int i = 1; i < 5; i++) {
                int nx = x - dir[0] * i;
                int ny = y - dir[1] * i;
                if (!checkPos(nx, ny, role))
                    break;
                count++;
            }
            if (count >= 5)
                return true;
        }
        return false;
    }

    private boolean checkPos(int x, int y, int role) {
        return x >= 0 && x < 15 && y >= 0 && y < 15 && board[y][x] == role;
    }

    public void reset() {
        board = new int[15][15];
        turn = 1;
        status = "playing";
        winner = 0;
    }
}
