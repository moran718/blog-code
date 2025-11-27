package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.DanmakuVO;
import com.mr.blog.dto.MessageRequest;
import com.mr.blog.dto.MessageReplyRequest;
import com.mr.blog.dto.MessageVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.service.MessageService;
import com.mr.blog.utils.JwtUtils;
import com.mr.blog.utils.PageUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/message")
@CrossOrigin(origins = "http://localhost:8080", allowCredentials = "true")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private JwtUtils jwtUtils;

    /**
     * 获取弹幕列表
     */
    @GetMapping("/list")
    public Result<List<DanmakuVO>> getDanmakuList(HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        List<DanmakuVO> list = messageService.getDanmakuList(userId);
        return Result.success(list);
    }

    /**
     * 发送弹幕
     */
    @PostMapping("/send")
    public Result<String> sendDanmaku(@RequestBody Map<String, String> body, HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        String content = body.get("content");
        if (content == null || content.trim().isEmpty()) {
            return Result.error("弹幕内容不能为空");
        }

        messageService.sendDanmaku(userId, content.trim());
        return Result.success("发送成功");
    }

    /**
     * 切换弹幕点赞
     */
    @PostMapping("/like")
    public Result<Boolean> toggleLike(@RequestBody Map<String, Long> body, HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        Long messageId = body.get("messageId");
        if (messageId == null) {
            return Result.error("参数错误");
        }

        boolean liked = messageService.toggleLike(userId, messageId);
        return Result.success(liked);
    }

    /**
     * 获取留言列表
     */
    @GetMapping("/comments")
    public Result<List<MessageVO>> getMessageList() {
        List<MessageVO> list = messageService.getMessageList();
        return Result.success(list);
    }

    /**
     * 获取留言列表（分页）
     * 
     * @param page     页码，默认1
     * @param pageSize 每页条数，默认5
     */
    @GetMapping("/comments/page")
    public Result<PageVO<MessageVO>> getMessageListWithPage(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "5") Integer pageSize) {
        int[] params = PageUtils.validateParams(page, pageSize);
        PageVO<MessageVO> result = messageService.getMessageListWithPage(params[0], params[1]);
        return Result.success(result);
    }

    /**
     * 发布留言
     */
    @PostMapping("/comment")
    public Result<MessageVO> addMessage(@RequestBody MessageRequest body, HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        if ((body.getContent() == null || body.getContent().trim().isEmpty())
                && (body.getImages() == null || body.getImages().isEmpty())) {
            return Result.error("留言内容不能为空");
        }

        MessageVO vo = messageService.addMessage(userId, body);
        return Result.success(vo);
    }

    /**
     * 回复留言
     */
    @PostMapping("/reply")
    public Result<MessageVO.ReplyVO> addReply(@RequestBody MessageReplyRequest body, HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        if (body.getMessageId() == null) {
            return Result.error("参数错误");
        }
        if (body.getContent() == null || body.getContent().trim().isEmpty()) {
            return Result.error("回复内容不能为空");
        }

        MessageVO.ReplyVO vo = messageService.addReply(userId, body);
        return Result.success(vo);
    }

    private Long getUserIdFromRequest(HttpServletRequest request) {
        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }
        if (token != null && jwtUtils.validateToken(token)) {
            return jwtUtils.getUserIdFromToken(token);
        }
        return null;
    }
}
