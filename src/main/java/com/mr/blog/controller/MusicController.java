package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.MusicVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.Music;
import com.mr.blog.service.MusicService;
import com.mr.blog.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * 音乐控制器
 */
@RestController
@RequestMapping("/api/music")
@CrossOrigin
public class MusicController {

    @Autowired
    private MusicService musicService;

    @Value("${FILE_UPLOAD_PATH:${file.upload-path:uploads/}}")
    private String uploadPath;

    /**
     * 获取音乐列表（前端展示用）
     */
    @GetMapping("/list")
    public Result<List<MusicVO>> getMusicList() {
        List<MusicVO> list = musicService.getMusicList();
        return Result.success(list);
    }

    /**
     * 分页获取音乐列表（管理端）
     */
    @GetMapping("/admin/list")
    public Result<PageVO<Music>> getAdminMusicList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword) {
        int[] params = PageUtils.validateParams(page, size);
        PageVO<Music> result = musicService.getMusicListWithPage(params[0], params[1], keyword);
        return Result.success(result);
    }

    /**
     * 根据ID获取音乐详情
     */
    @GetMapping("/{id}")
    public Result<Music> getMusicById(@PathVariable Long id) {
        Music music = musicService.getMusicById(id);
        if (music == null) {
            return Result.error("音乐不存在");
        }
        return Result.success(music);
    }

    /**
     * 添加音乐
     */
    @PostMapping("/add")
    public Result<Void> addMusic(@RequestBody Music music) {
        if (music.getName() == null || music.getName().trim().isEmpty()) {
            return Result.error("歌曲名称不能为空");
        }
        musicService.addMusic(music);
        return Result.success();
    }

    /**
     * 更新音乐
     */
    @PutMapping("/update")
    public Result<Void> updateMusic(@RequestBody Music music) {
        if (music.getId() == null) {
            return Result.error("音乐ID不能为空");
        }
        musicService.updateMusic(music);
        return Result.success();
    }

    /**
     * 删除音乐
     */
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteMusic(@PathVariable Long id) {
        musicService.deleteMusic(id);
        return Result.success();
    }

    /**
     * 更新音乐状态
     */
    @PutMapping("/status/{id}")
    public Result<Void> updateStatus(@PathVariable Long id, @RequestParam Integer status) {
        musicService.updateStatus(id, status);
        return Result.success();
    }

    /**
     * 上传音乐封面
     */
    @PostMapping("/uploadCover")
    public Result<String> uploadCover(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件不能为空");
        }

        // 验证文件类型
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return Result.error("只能上传图片文件");
        }

        // 验证文件大小（最大5MB）
        if (file.getSize() > 5 * 1024 * 1024) {
            return Result.error("图片大小不能超过5MB");
        }

        try {
            // 生成文件名
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + extension;

            // 保存文件
            String musicCoverPath = uploadPath + "music/covers/";
            File dir = new File(musicCoverPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File destFile = new File(musicCoverPath + newFilename);
            file.transferTo(destFile);

            // 返回相对路径
            String imageUrl = "/uploads/music/covers/" + newFilename;
            return Result.success(imageUrl);
        } catch (IOException e) {
            return Result.error("上传失败: " + e.getMessage());
        }
    }

    /**
     * 上传音乐文件
     */
    @PostMapping("/uploadAudio")
    public Result<String> uploadAudio(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件不能为空");
        }

        // 验证文件类型
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("audio/")) {
            return Result.error("只能上传音频文件");
        }

        // 验证文件大小（最大20MB）
        if (file.getSize() > 20 * 1024 * 1024) {
            return Result.error("音频大小不能超过20MB");
        }

        try {
            // 生成文件名
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + extension;

            // 保存文件
            String musicAudioPath = uploadPath + "music/audio/";
            File dir = new File(musicAudioPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File destFile = new File(musicAudioPath + newFilename);
            file.transferTo(destFile);

            // 返回相对路径
            String audioUrl = "/uploads/music/audio/" + newFilename;
            return Result.success(audioUrl);
        } catch (IOException e) {
            return Result.error("上传失败: " + e.getMessage());
        }
    }
}
