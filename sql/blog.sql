/*
 Navicat Premium Data Transfer

 Source Server         : blog
 Source Server Type    : MySQL
 Source Server Version : 80044
 Source Host           : sjc1.clusters.zeabur.com:22888
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80044
 File Encoding         : 65001

 Date: 28/01/2026 18:18:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for browse_log
-- ----------------------------
DROP TABLE IF EXISTS `browse_log`;
CREATE TABLE `browse_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访问IP地址',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问的URL',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '浏览器User-Agent',
  `referer` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '来源页面',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '访问时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_ip`(`ip`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '浏览记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of browse_log
-- ----------------------------
INSERT INTO `browse_log` VALUES (1, '192.168.11.1', 'https://mrrblog.zeabur.app/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'https://mrrblog.zeabur.app', '2025-12-29 17:10:40');
INSERT INTO `browse_log` VALUES (2, '192.168.29.1', 'https://mrrblog.zeabur.app/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 SLBrowser/9.0.0.10191 SLBChan/30', 'https://mrrblog.zeabur.app', '2026-01-03 16:53:53');
INSERT INTO `browse_log` VALUES (3, '192.168.37.1', 'https://mrrblog.zeabur.app/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 SLBrowser/9.0.0.10191 SLBChan/30', 'https://mrrblog.zeabur.app', '2025-12-12 10:27:09');
INSERT INTO `browse_log` VALUES (4, '192.168.81.1', 'https://mrrblog.zeabur.app/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 SLBrowser/9.0.0.10191 SLBChan/30', 'https://mrrblog.zeabur.app', '2026-01-08 13:58:31');
INSERT INTO `browse_log` VALUES (5, '192.168.77.1', 'https://mrrblog.zeabur.app/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 SLBrowser/9.0.0.10191 SLBChan/30', 'https://mrrblog.zeabur.app', '2026-01-21 17:17:31');
INSERT INTO `browse_log` VALUES (6, '192.168.113.1', 'https://mrrblog.zeabur.app/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 SLBrowser/9.0.0.10191 SLBChan/30', 'https://mrrblog.zeabur.app', '2026-01-28 18:05:56');

-- ----------------------------
-- Table structure for check_in
-- ----------------------------
DROP TABLE IF EXISTS `check_in`;
CREATE TABLE `check_in`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `check_date` date NOT NULL COMMENT '签到日期',
  `exp_gained` int(0) NOT NULL COMMENT '获得的经验值',
  `continuous_days` int(0) NOT NULL DEFAULT 1 COMMENT '连续签到天数',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_date`(`user_id`, `check_date`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '签到记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of check_in
-- ----------------------------
INSERT INTO `check_in` VALUES (2, 1, '2025-11-29', 10, 1, '2025-11-29 12:03:39');
INSERT INTO `check_in` VALUES (3, 2, '2025-11-29', 10, 1, '2025-11-29 12:09:22');
INSERT INTO `check_in` VALUES (4, 2, '2025-11-30', 15, 2, '2025-11-30 10:14:18');
INSERT INTO `check_in` VALUES (5, 1, '2025-11-30', 15, 2, '2025-11-30 13:27:41');
INSERT INTO `check_in` VALUES (6, 1, '2025-12-01', 20, 3, '2025-12-01 05:05:16');
INSERT INTO `check_in` VALUES (7, 8, '2025-12-01', 10, 1, '2025-12-01 09:57:02');
INSERT INTO `check_in` VALUES (8, 1, '2025-12-02', 25, 4, '2025-12-02 06:50:13');
INSERT INTO `check_in` VALUES (9, 1, '2025-12-03', 30, 5, '2025-12-03 02:20:34');
INSERT INTO `check_in` VALUES (10, 1, '2025-12-04', 35, 6, '2025-12-04 02:24:09');
INSERT INTO `check_in` VALUES (11, 1, '2025-12-07', 10, 1, '2025-12-07 10:17:53');
INSERT INTO `check_in` VALUES (12, 1, '2025-12-08', 15, 2, '2025-12-08 13:47:24');
INSERT INTO `check_in` VALUES (13, 1, '2025-12-12', 10, 1, '2025-12-12 10:27:31');
INSERT INTO `check_in` VALUES (14, 1, '2025-12-15', 10, 1, '2025-12-15 15:32:46');
INSERT INTO `check_in` VALUES (15, 1, '2025-12-29', 10, 1, '2025-12-29 14:52:07');
INSERT INTO `check_in` VALUES (16, 1, '2025-12-30', 15, 2, '2025-12-30 17:27:30');
INSERT INTO `check_in` VALUES (17, 1, '2025-12-31', 20, 3, '2025-12-31 13:55:57');
INSERT INTO `check_in` VALUES (18, 1, '2026-01-03', 10, 1, '2026-01-03 16:54:19');
INSERT INTO `check_in` VALUES (19, 1, '2026-01-07', 10, 1, '2026-01-07 17:53:06');
INSERT INTO `check_in` VALUES (20, 1, '2026-01-21', 10, 1, '2026-01-21 17:18:04');

-- ----------------------------
-- Table structure for essay
-- ----------------------------
DROP TABLE IF EXISTS `essay`;
CREATE TABLE `essay`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '随笔ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '随笔内容',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片URL，多张用逗号分隔',
  `videos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '视频URL，多个用逗号分隔',
  `comments_count` int(0) NULL DEFAULT 0 COMMENT '评论数量',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '随笔表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of essay
-- ----------------------------
INSERT INTO `essay` VALUES (8, 1, '这是一条测试内容', '/uploads/essays/fff2e400-b19f-4f6f-b938-5882b62c8e9f.png', NULL, 3, '2025-11-28 08:43:52', '2025-11-28 08:43:52');
INSERT INTO `essay` VALUES (9, 1, '肥肥得吃', '/uploads/essays/907992ed-1595-4940-a8e8-7f57fc9661ce.png', NULL, 0, '2025-12-01 08:52:50', '2025-12-01 08:52:50');
INSERT INTO `essay` VALUES (10, 1, '2025.12.12郑州的第一场雪！❄️', NULL, NULL, 0, '2025-12-12 10:26:56', '2025-12-12 10:26:56');
INSERT INTO `essay` VALUES (11, 1, 'TODO：\n-留言图片功能失效\n-友链页面\n', NULL, NULL, 0, '2025-12-29 17:30:20', '2025-12-29 17:30:20');
INSERT INTO `essay` VALUES (12, 1, 'TODO：\n-敏感词屏蔽', NULL, NULL, 0, '2025-12-30 17:29:49', '2025-12-30 17:29:49');

-- ----------------------------
-- Table structure for essay_comment
-- ----------------------------
DROP TABLE IF EXISTS `essay_comment`;
CREATE TABLE `essay_comment`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `essay_id` bigint(0) NOT NULL COMMENT '随笔ID',
  `user_id` bigint(0) NOT NULL COMMENT '评论用户ID',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父评论ID，0表示一级评论',
  `reply_to_user_id` bigint(0) NULL DEFAULT NULL COMMENT '被回复用户ID，用于三级回复显示@用户名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '评论内容',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片URL，多张用逗号分隔',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_essay_id`(`essay_id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '随笔评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of essay_comment
-- ----------------------------
INSERT INTO `essay_comment` VALUES (26, 8, 1, 0, NULL, '测试回复', NULL, '2025-11-28 08:43:52');
INSERT INTO `essay_comment` VALUES (27, 8, 1, 26, NULL, '测试二级回复', NULL, '2025-11-28 08:43:52');
INSERT INTO `essay_comment` VALUES (28, 8, 1, 26, 1, '测试三级回复', NULL, '2025-11-28 08:43:52');

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level`  (
  `id` int(0) NOT NULL COMMENT '等级ID（1-5）',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级名称',
  `min_exp` int(0) NOT NULL COMMENT '该等级最低经验值',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级图标',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级颜色',
  `description` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '等级配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of level
-- ----------------------------
INSERT INTO `level` VALUES (1, '初来乍到', 0, '🌱', '#9e9e9e', '欢迎来到拾光博客');
INSERT INTO `level` VALUES (2, '初露锋芒', 100, '🏆', '#4caf50', '开始崭露头角');
INSERT INTO `level` VALUES (3, '小有名气', 300, '🎖️', '#2196f3', '已经小有名气了');
INSERT INTO `level` VALUES (4, '声名远扬', 600, '🌟', '#ff9800', '名声已经传开');
INSERT INTO `level` VALUES (5, '登峰造极', 1000, '👑', '#f44336', '已达巅峰');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '类型：0-弹幕，1-留言',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片URL，多张用逗号分隔（仅留言有）',
  `likes` int(0) NOT NULL DEFAULT 0 COMMENT '点赞数（仅弹幕有）',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_type`(`type`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 212 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 0, '弹幕功能测试', NULL, 0, '2025-12-01 08:47:48');
INSERT INTO `message` VALUES (2, 1, 0, '弹幕功能测试', NULL, 0, '2025-12-01 08:48:23');
INSERT INTO `message` VALUES (3, 1, 0, '弹幕功能测试', NULL, 0, '2025-12-01 08:48:34');
INSERT INTO `message` VALUES (4, 1, 0, '弹幕功能测试', NULL, 0, '2025-12-01 08:48:49');
INSERT INTO `message` VALUES (5, 1, 0, '弹幕功能测试', NULL, 0, '2025-12-01 08:48:56');
INSERT INTO `message` VALUES (207, 1, 1, '留言功能测试', NULL, 0, '2025-12-01 08:49:30');
INSERT INTO `message` VALUES (208, 8, 1, '1', NULL, 0, '2025-12-01 09:56:52');
INSERT INTO `message` VALUES (209, 8, 0, '1111111', NULL, 0, '2025-12-01 09:57:13');
INSERT INTO `message` VALUES (210, 1, 1, '🤗🤗🤗', NULL, 0, '2025-12-29 17:11:56');
INSERT INTO `message` VALUES (211, 1, 1, '', '/uploads/essays/c5e1a55f-dd5f-4bcc-bc14-32e6cd74b107.jpg', 0, '2025-12-30 13:01:33');

-- ----------------------------
-- Table structure for message_like
-- ----------------------------
DROP TABLE IF EXISTS `message_like`;
CREATE TABLE `message_like`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `message_id` bigint(0) NOT NULL COMMENT '弹幕ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_message_user`(`message_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '弹幕点赞记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_like
-- ----------------------------

-- ----------------------------
-- Table structure for message_reply
-- ----------------------------
DROP TABLE IF EXISTS `message_reply`;
CREATE TABLE `message_reply`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `message_id` bigint(0) NOT NULL COMMENT '留言ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父回复ID，0表示一级回复',
  `reply_to_user_id` bigint(0) NULL DEFAULT NULL COMMENT '被回复用户ID',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回复内容',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_message_id`(`message_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言回复表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_reply
-- ----------------------------
INSERT INTO `message_reply` VALUES (1, 101, 2, 0, NULL, '同意！博主写得确实很好', '2025-11-21 18:26:28');
INSERT INTO `message_reply` VALUES (2, 101, 3, 0, NULL, '我也学到了很多', '2025-11-22 18:26:28');
INSERT INTO `message_reply` VALUES (3, 101, 1, 1, 2, '谢谢支持！', '2025-11-23 18:26:28');
INSERT INTO `message_reply` VALUES (4, 103, 1, 0, NULL, '这个功能用的是Vue的transition组件', '2025-11-16 18:26:28');
INSERT INTO `message_reply` VALUES (5, 103, 3, 4, 1, '原来如此，谢谢博主解答', '2025-11-17 18:26:28');
INSERT INTO `message_reply` VALUES (6, 108, 1, 0, NULL, '是的，自己设计的，用了很多CSS技巧', '2025-11-11 18:26:28');
INSERT INTO `message_reply` VALUES (7, 109, 1, 0, NULL, '前端Vue，后端Spring Boot，数据库MySQL', '2025-11-06 18:26:28');
INSERT INTO `message_reply` VALUES (8, 112, 1, 0, NULL, '好建议，我考虑一下！', '2025-11-18 18:26:28');
INSERT INTO `message_reply` VALUES (9, 112, 2, 8, 1, '期待夜间模式上线', '2025-11-19 18:26:28');
INSERT INTO `message_reply` VALUES (10, 117, 1, 0, NULL, '哈哈，灵感来自B站弹幕', '2025-11-14 18:26:28');
INSERT INTO `message_reply` VALUES (11, 117, 3, 10, 1, '确实很有创意', '2025-11-15 18:26:28');
INSERT INTO `message_reply` VALUES (12, 121, 2, 0, NULL, '霞鹜文楷，一款很漂亮的开源字体', '2025-11-08 18:26:28');
INSERT INTO `message_reply` VALUES (13, 124, 1, 0, NULL, '会考虑开源的，等完善一下', '2025-11-12 18:26:28');
INSERT INTO `message_reply` VALUES (14, 124, 2, 13, 1, '期待！', '2025-11-13 18:26:28');
INSERT INTO `message_reply` VALUES (15, 124, 3, 13, 1, '等着呢！', '2025-11-14 18:26:28');
INSERT INTO `message_reply` VALUES (16, 179, 1, 0, NULL, '123', '2025-11-27 13:50:10');
INSERT INTO `message_reply` VALUES (17, 207, 1, 0, NULL, '回复测试', '2025-12-01 08:49:38');
INSERT INTO `message_reply` VALUES (18, 208, 1, 0, NULL, '11', '2025-12-01 09:57:56');

-- ----------------------------
-- Table structure for music
-- ----------------------------
DROP TABLE IF EXISTS `music`;
CREATE TABLE `music`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '歌曲名称',
  `artist` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '歌手/艺术家',
  `album` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专辑名称',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图片URL',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '音乐文件URL',
  `duration` int(0) NULL DEFAULT 0 COMMENT '时长（秒）',
  `sort_order` int(0) NULL DEFAULT 0 COMMENT '排序顺序',
  `status` tinyint(0) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_sort_order`(`sort_order`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '音乐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of music
-- ----------------------------
INSERT INTO `music` VALUES (1, '多远都要在一起', '邓紫棋', '新的心跳', '/uploads/music/covers/3e9eca87-430f-4041-9555-2ddbeb986e71.jpg', '/uploads/music/audio/53b34ef5-f09c-4154-afb7-5113d9573e7d.mp3', 217, 1, 1, '2025-11-29 14:05:35', '2025-12-01 06:10:04');
INSERT INTO `music` VALUES (2, '尽头', '赵方婧', '', '/uploads/music/covers/a687fb74-4926-4efd-a500-fefa768ed1de.jfif', '/uploads/music/audio/8297c5ac-269f-4c6f-a2bb-7742399b210b.mp3', 256, 2, 1, '2025-11-29 14:05:35', '2025-12-01 06:12:06');
INSERT INTO `music` VALUES (3, '知我', '国风堂', '', '/uploads/music/covers/d4b25fd1-32d3-4eac-b39e-8110f8157ac1.jpg', '/uploads/music/audio/8dbd5be0-867f-486c-958f-1ed9aae117b6.mp3', 126, 3, 1, '2025-11-29 14:05:35', '2025-12-01 06:12:30');
INSERT INTO `music` VALUES (4, '爱错', '王力宏', '', '/uploads/music/covers/745733b6-22a8-44f6-ae4a-49b2138c826a.jpg', '/uploads/music/audio/497edfe7-2c95-4e6a-885c-8535bf45d4a0.mp3', 238, 4, 1, '2025-11-29 14:05:35', '2025-12-01 06:12:53');
INSERT INTO `music` VALUES (6, '戒不掉', '欧阳耀莹', '', '/uploads/music/covers/6a140f85-b412-4926-b3c3-20db181d6c2f.jpg', '/uploads/music/audio/e36ec457-2d0c-4324-9487-ccbd2eec2ecb.mp3', 186, 5, 1, '2025-11-30 14:30:19', '2025-12-01 06:13:23');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '摘要',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容（富文本）',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面图URL',
  `category_id` bigint(0) NOT NULL COMMENT '分类ID（二级分类）',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '作者ID',
  `views` int(0) NULL DEFAULT 0 COMMENT '浏览量',
  `likes` int(0) NULL DEFAULT 0 COMMENT '点赞数',
  `status` tinyint(0) NULL DEFAULT 1 COMMENT '状态：0-草稿，1-已发布',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE,
  INDEX `idx_views`(`views`) USING BTREE,
  INDEX `idx_likes`(`likes`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (11, '分布式事务', '', '# 分布式事务\n\n## 本地事务回顾\n\n### 事务概念\n\n数据库事务(简称：事务，Transaction)是指数据库执行过程中的一个逻辑单位，由一个有限的数据库操作序列构成。\n\n### 事务的特性\n\n事务拥有以下四个特性，习惯上被称为ACID特性：\n\n**原子性(Atomicity)**：事务作为一个整体被执行，包含在其中的对数据库的操作要么全部被执行，要么都不执行。\n\n**一致性(Consistency)**：事务应确保数据库的状态从一个一致状态转变为另一个一致状态。一致状态是指数据库中的数据应满足完整性约束。除此之外，一致性还有另外一层语义，就是事务的中间状态不能被观察到(这层语义也有说应该属于原子性)。\n\n**隔离性(Isolation)**：多个事务并发执行时，一个事务的执行不应影响其他事务的执行，如同只有这一个操作在被数据库所执行一样。\n\n**持久性(Durability)**：已被提交的事务对数据库的修改应该永久保存在数据库中。在事务结束时，此操作将不可逆转。\n\n### 本地事务\n\n起初，事务仅限于对单一数据库资源的访问控制,架构服务化以后，事务的概念延伸到了服务中。倘若将一个单一的服务操作作为一个事务，那么整个服务操作只能涉及一个单一的数据库资源,这类基于单个服务单一数据库资源访问的事务，被称为本地事务(Local Transaction)。\n\n![图片](/uploads/records/images/d78c831a-fa7e-40bf-a966-ac2447407bdb.png)\n\n## 分布式事务\n\n### 分布式事务概念\n\n分布式事务指事务的参与者、支持事务的服务器、资源服务器以及事务管理器分别位于不同的分布式系统的不同节点之上,且属于不同的应用，分布式事务需要保证这些操作要么全部成功，要么全部失败。本质上来说，分布式事务就是为了保证不同数据库的数据一致性。\n\n最早的分布式事务应用架构很简单，不涉及服务间的访问调用，仅仅是服务内操作涉及到对多个数据库资源的访问。\n\n![图片](/uploads/records/images/ed005870-5268-43d0-b178-2acc57ff3244.png)\n\n当一个服务操作访问不同的数据库资源，又希望对它们的访问具有事务特性时，就需要采用分布式事务来协调所有的事务参与者。\n\n对于上面介绍的分布式事务应用架构，尽管一个服务操作会访问多个数据库资源，但是毕竟整个事务还是控制在单一服务的内部。如果一个服务操作需要调用另外一个服务，这时的事务就需要跨越多个服务了。在这种情况下，起始于某个服务的事务在调用另外一个服务的时候，需要以某种机制流转到另外一个服务，从而使被调用的服务访问的资源也自动加入到该事务当中来。下图反映了这样一个跨越多个服务的分布式事务：\n\n![图片](/uploads/records/images/f59cb57c-6b7d-4403-91c8-9bcb8c285c62.png)\n\n如果将上面这两种场景(一个服务可以调用多个数据库资源，也可以调用其他服务)结合在一起，对此进行延伸，整个分布式事务的参与者将会组成如下图所示的树形拓扑结构。在一个跨服务的分布式事务中，事务的发起者和提交均系同一个，它可以是整个调用的客户端，也可以是客户端最先调用的那个服务。\n\n![图片](/uploads/records/images/c728ae4e-eb26-4bde-9b29-f37597c0a519.png)\n\n较之基于单一数据库资源访问的本地事务，分布式事务的应用架构更为复杂。在不同的分布式应用架构下，实现一个分布式事务要考虑的问题并不完全一样，比如对多资源的协调、事务的跨服务传播等，实现机制也是复杂多变。\n\n**在多个项目、多个数据库进行联动操作的时候，进行统一的事务控制，就是分布式事务。**\n\n\n\n\n\n### 分布式事务相关理论\n\n#### 1.4.1.CAP定理 \n\n![图片](/uploads/records/images/b8464546-75c4-4d56-b6f2-2588a337c363.png)\n\nCAP定理是在 1998年加州大学的计算机科学家 Eric Brewer （埃里克.布鲁尔）提出，**分布式**系统有三个指标\n\n- Consistency：一致性\n- Availability：可用性\n- Partition tolerance：分区容错\n\n它们的第一个字母分别是 C、A、P。Eric Brewer 说，这三个指标不可能同时做到。这个结论就叫做 CAP 定理。\n\n##### P：分区容错-partition-tolerance\n\n代表分布式系统在遇到某节点或网络分区故障的时候，仍然能够对外提供满足一致性或可用性的服务。\n\n![图片](/uploads/records/images/22fbfd6f-c20e-42c7-9cbb-1d81d7cfbfdd.png)\n\n\n\n##### A：可用性-availability\n\n代表用户访问数据的时候，系统是否能在正常响应时间返回预期的结果，即只要收到用户的请求，服务器就必须给出回应。\n\n![图片](/uploads/records/images/b20f4e94-ec7a-4553-b499-f2e73394a0c7.png)\n\n\n\n##### C：一致性-consistency\n\n代表更新操作成功后，所有节点在同一时间的数据保持完全一致。\n\n一致性分类：\n\n- 强一致性，要求更新过的数据能被后续的访问都能看到\n- 弱一致性，能容忍后续的部分或者全部访问不到\n- 最终一致性，经过一段时间后要求能访问到更新后的数据\n\nCAP中说的一致性指的是强一致性\n\n![图片](/uploads/records/images/81928609-1963-490c-8a3b-9847d5f5541c.png)\n\n\n\n\n\n##### 一致性和可用性的矛盾\n\n一致性和可用性，为什么不可能同时成立？答案很简单，因为可能通信失败（即出现分区容错）。\n\n- **CP：**（一致性、分区容错性）如果保证 S2 的一致性，那么 S1 必须在写操作时，锁定 S2 的读操作和写操作。只有数据同步后，才能重新开放读写。锁定期间，S2 不能读写，没有可用性。一个保证了CP而一个舍弃了A的分布式系统，一旦发生网络故障或者消息丢失等情况，就要牺牲用户的体验，等待所有数据全部一致了之后再让用户访问系统。设计成CP的系统其实也不少，其中最典型的就是很多分布式数据库，他们都是设计成CP的。在发生极端情况时，优先保证数据的强一致性，代价就是舍弃系统的可用性。分布式系统中常用的Zookeeper也是在CAP三者之中选择优先保证CP的。\n- **AP：**（可用性、分区容错性）如果保证 S2 的可用性，那么势必不能锁定 S2，所以一致性不成立，则是可用性（高可用），要高可用并允许分区，则需放弃一致性。一旦网络问题发生，节点之间可能会失去联系。为了保证高可用，需要在用户访问时可以马上得到返回，则每个节点只能用本地数据提供服务，而这样会导致全局数据的不一致性。这种舍弃强一致性而保证系统的分区容错性和可用性的场景和案例非常多，12306买票等\n\n综上所述，S2 无法同时做到一致性和可用性。系统设计时只能选择一个目标。如果追求一致性，那么无法保证所有节点的可用性；如果追求所有节点的可用性，那就没法做到一致性。\n\n\n\n### BASE理论\n\nBASE：全称：Basically Available(基本可用)，Soft state（软状态）,和 Eventually consistent（最终一致性）三个短语的缩写，来自 ebay 的架构师提出。BASE 理论是对 CAP 中一致性和可用性权衡的结果，其来源于对大型互联网分布式实践的总结，是基于 CAP 定理逐步演化而来的。其核心思想是：\n\n```\n既是无法做到强一致性（Strong consistency），但每个应用都可以根据自身的业务特点，采用适当的方式来使系统达到最终一致性（Eventual consistency）。\n```\n\n##### Basically Available(基本可用)\n\n什么是基本可用呢？假设系统，出现了不可预知的故障，但还是能用，相比较正常的系统而言：\n\n1. 响应时间上的损失：正常情况下的搜索引擎 0.5 秒即返回给用户结果，而**基本可用**的搜索引擎可以在 1 秒作用返回结果。\n2. 功能上的损失：在一个电商网站上，正常情况下，用户可以顺利完成每一笔订单，但是到了大促期间，为了保护购物系统的稳定性，部分消费者可能会被引导到一个降级页面。\n\n##### soft-state-软状态\n\n什么是软状态呢？相对于原子性而言，要求多个节点的数据副本都是一致的，这是一种 “硬状态”。\n\n软状态指的是：允许系统中的数据存在中间状态，并认为该状态不影响系统的整体可用性，即允许系统在多个不同节点的数据副本存在数据延时。\n\n##### eventually-consistent-最终一致性\n\n系统能够保证在没有其他新的更新操作的情况下，数据最终一定能够达到一致的状态，因此所有客户端对系统的数据访问最终都能够获取到最新的值。\n\n## 分布式事务解决方案\n\n### 基于XA协议的两阶段提交\n\n首先我们来简要看下分布式事务处理的XA规范 ：\n\n![图片](/uploads/records/images/5ea69578-89bc-4a92-8091-a585577df3ff.png)\n\n可知XA规范中分布式事务有AP，RM，TM组成：\n\n其中应用程序(Application Program ，简称AP)：AP定义事务边界（定义事务开始和结束）并访问事务边界内的资源。\n\n资源管理器(Resource Manager，简称RM)：Rm管理计算机共享的资源，许多软件都可以去访问这些资源，资源包含比如数据库、文件系统、打印机服务器等。\n\n事务管理器(Transaction Manager ，简称TM)：负责管理全局事务，分配事务唯一标识，监控事务的执行进度，并负责事务的提交、回滚、失败恢复等。\n\n**二阶段协议:**\n\n**第一阶段**TM要求所有的RM准备提交对应的事务分支，询问RM是否有能力保证成功的提交事务分支，RM根据自己的情况，如果判断自己进行的工作可以被提交，那就就对工作内容进行持久化，并给TM回执OK；否者给TM的回执NO。RM在发送了否定答复并回滚了已经的工作后，就可以丢弃这个事务分支信息了。\n\n**第二阶段**TM根据阶段1各个RM prepare的结果，决定是提交还是回滚事务。如果所有的RM都prepare成功，那么TM通知所有的RM进行提交；如果有RM prepare回执NO的话，则TM通知所有RM回滚自己的事务分支。\n\n也就是TM与RM之间是通过两阶段提交协议进行交互的.\n\n**优点：** 尽量保证了数据的强一致，适合对数据强一致要求很高的关键领域。（其实也不能100%保证强一致）\n\n**缺点：** 实现复杂，牺牲了可用性，对性能影响较大，不适合高并发高性能场景。\n\n### TCC补偿机制\n\nTCC 其实就是采用的补偿机制，其核心思想是：针对每个操作，都要注册一个与其对应的确认和补偿（撤销）操作。它分为三个阶段：\n\n- Try 阶段主要是对业务系统做检测及资源预留\n- Confirm 阶段主要是对业务系统做确认提交，Try阶段执行成功并开始执行 Confirm阶段时，默认 Confirm阶段是不会出错的。即：只要Try成功，Confirm一定成功。\n- Cancel 阶段主要是在业务执行错误，需要回滚的状态下执行的业务取消，预留资源释放。\n\n![图片](/uploads/records/images/497b36a1-d6a5-4cc0-88c2-b7effee13a75.png)\n\n例如： A要向 B 转账，思路大概是：\n\n我们有一个本地方法，里面依次调用\n1、首先在 Try 阶段，要先调用远程接口把 B和 A的钱给冻结起来。\n2、在 Confirm 阶段，执行远程调用的转账的操作，转账成功进行解冻。\n3、如果第2步执行成功，那么转账成功，如果第二步执行失败，则调用远程冻结接口对应的解冻方法 (Cancel)。\n\n**优点：** 相比两阶段提交，可用性比较强\n\n**缺点：** 数据的一致性要差一些。TCC属于应用层的一种补偿方式，所以需要程序员在实现的时候多写很多补偿的代码，在一些场景中，一些业务流程可能用TCC不太好定义及处理。\n\n### 消息最终一致性\n\n消息最终一致性其核心思想是将分布式事务拆分成本地事务进行处理，这种思路是来源于ebay。我们可以从下面的流程图中看出其中的一些细节：\n\n![图片](/uploads/records/images/ee2cdfcb-bcca-4fdb-b2b7-30bbc6f20a9e.png)\n\n基本思路就是：\n\n消息生产方，需要额外建一个消息表，并记录消息发送状态。消息表和业务数据要在一个事务里提交，也就是说他们要在一个数据库里面。然后消息会经过MQ发送到消息的消费方。如果消息发送失败，会进行重试发送。\n\n消息消费方，需要处理这个消息，并完成自己的业务逻辑。此时如果本地事务处理成功，表明已经处理成功了，如果处理失败，那么就会重试执行。如果是业务上面的失败，可以给生产方发送一个业务补偿消息，通知生产方进行回滚等操作。\n\n生产方和消费方定时扫描本地消息表，把还没处理完成的消息或者失败的消息再发送一遍。如果有靠谱的自动对账补账逻辑，这种方案还是非常实用的。\n\n**优点：** 一种非常经典的实现，避免了分布式事务，实现了最终一致性。\n\n**缺点：** 消息表会耦合到业务系统中，如果没有封装好的解决方案，会有很多杂活需要处理。\n\n## seata\n\n### seata介绍\n\nSeata 是一款开源的分布式事务解决方案，致力于提供高性能和简单易用的分布式事务服务。Seata 将为用户提供了 AT、TCC、SAGA 和 XA 事务模式，为用户打造一站式的分布式解决方案。\n\n官网地址：http://seata.io/zh-cn/\n\n![图片](/uploads/records/images/5068a7f5-ca2a-4a25-8923-33957ef5ccf5.png)\n\n![图片](/uploads/records/images/866e9a96-fa1e-4ae7-849b-e39312798b98.png)\n\n- Seata用于解决分布式事务\n- Seata非常适合解决微服务分布式事务【dubbo、SpringCloud….】\n- Seata性能高\n- Seata使用简单\n\n### AT模式介绍\n\n![图片](/uploads/records/images/8b6f4feb-daf7-44bf-91b7-119ab5f74fac.png)\n\n**Transaction Coordinator (TC)：** 事务协调器，维护全局事务的运行状态，负责协调并驱动全局事务的提交或回滚。\n\n**Transaction Manager (TM)：** 控制全局事务的边界，负责开启一个全局事务，并最终发起全局提交或全局回滚的决议。\n\n**Resource Manager (RM)：** 控制分支事务，负责分支注册、状态汇报，并接收事务协调器的指令，驱动分支（本地）事务的提交和回滚。\n\n**一个典型的分布式事务过程：**\n\n1. TM 向 TC 申请开启一个全局事务，全局事务创建成功并生成一个全局唯一的 XID。\n2. XID 在微服务调用链路的上下文中传播。\n3. RM 向 TC 注册分支事务，将其纳入 XID 对应全局事务的管辖。\n4. TM 向 TC 发起针对 XID 的全局提交或回滚决议。\n5. TC 调度 XID 下管辖的全部分支事务完成提交或回滚请求。\n\nAT模式使用前提：\n\n- 基于支持本地 ACID 事务的关系型数据库。\n- Java 应用，通过 JDBC 访问数据库。\n\n**AT模式机制：**\n\n基于两阶段提交协议的演变。\n\n一阶段：\n\n 业务数据和回滚日志记录在同一个本地事务中提交，释放本地锁和连接资源。\n\n二阶段：\n\n 提交异步化，非常快速地完成。\n\n 回滚通过一阶段的回滚日志进行反向补偿。\n\n\n\n### seata_server安装 \n\n1.从官网上下载seata server端的程序包\n\nhttps://github.com/apache/incubator-seata/releases\n\n> 也可以使用资料中提供的\n\n2.修改配置\n\n打开seata安装目录中的conf目录下的application.example.yml，拷贝如下框选的内容：\n\n![图片](/uploads/records/images/c9791091-ce45-4225-bf44-627285a9da37.png)\n\n然后打开seata安装目录中的conf目录下的application.yml，将之前拷贝的内容复制到指定位置，并修改，具体如下：\n\n```yml\nseata:\n  config:\n    # support: nacos, consul, apollo, zk, etcd3\n    type: nacos\n    nacos:\n      server-addr: 127.0.0.1:8848\n      namespace: public\n      group: SEATA_GROUP\n      username: nacos\n      password: nacos\n      context-path:\n      ##if use MSE Nacos with auth, mutex with username/password attribute\n      #access-key:\n      #secret-key:\n      data-id: seataServer.properties\n  registry:\n    # support: nacos, eureka, redis, zk, consul, etcd3, sofa\n    type: nacos\n    nacos:\n      server-addr: 127.0.0.1:8848\n      namespace: public\n      group: SEATA_GROUP\n      username: nacos\n      password: nacos\n      context-path:\n      ##if use MSE Nacos with auth, mutex with username/password attribute\n      #access-key:\n      #secret-key:\n      data-id: seataServer.properties\n```\n\n3.nacos配置seata\n\n打开nacos，按照之前seata的application.yml的配置进行如下配置\n\n![图片](/uploads/records/images/7bbe4529-5a64-4eed-a354-0cae2fc5480d.png)\n\nnacos配置列表信息如下\n\n![图片](/uploads/records/images/a5ef4cdf-b6f9-49b4-8060-a931dc573e93.png)\n\n将seata安装目录中的script目录中config-center目录中的config.txt全部内容复制并拷贝到nacos的seataServer.properties中，并修改如下内容\n\n```properties\nstore.db.datasource=druid\nstore.db.dbType=mysql\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\nstore.db.url=jdbc:mysql://127.0.0.1:3306/ry-cloud?useUnicode=true&rewriteBatchedStatements=true\nstore.db.user=root\nstore.db.password=root\nstore.db.minConn=5\nstore.db.maxConn=30\nstore.db.globalTable=global_table\nstore.db.branchTable=branch_table\nstore.db.distributedLockTable=distributed_lock\nstore.db.queryLimit=100\nstore.db.lockTable=lock_table\nstore.db.maxWait=5000\n```\n\n4.创建seata数据库\n\n在ry-cloud数据库中执行以下sql语句生成seata对应的据库表。\n\n```sql\n-- -------------------------------- The script used when storeMode is \'db\' --------------------------------\n-- the table to store GlobalSession data\nCREATE TABLE IF NOT EXISTS `global_table`\n(\n    `xid`                       VARCHAR(128) NOT NULL,\n    `transaction_id`            BIGINT,\n    `status`                    TINYINT      NOT NULL,\n    `application_id`            VARCHAR(32),\n    `transaction_service_group` VARCHAR(32),\n    `transaction_name`          VARCHAR(128),\n    `timeout`                   INT,\n    `begin_time`                BIGINT,\n    `application_data`          VARCHAR(2000),\n    `gmt_create`                DATETIME,\n    `gmt_modified`              DATETIME,\n    PRIMARY KEY (`xid`),\n    KEY `idx_gmt_modified_status` (`gmt_modified`, `status`),\n    KEY `idx_transaction_id` (`transaction_id`)\n) ENGINE = InnoDB\n  DEFAULT CHARSET = utf8mb4;\n\n-- the table to store BranchSession data\nCREATE TABLE IF NOT EXISTS `branch_table`\n(\n    `branch_id`         BIGINT       NOT NULL,\n    `xid`               VARCHAR(128) NOT NULL,\n    `transaction_id`    BIGINT,\n    `resource_group_id` VARCHAR(32),\n    `resource_id`       VARCHAR(256),\n    `branch_type`       VARCHAR(8),\n    `status`            TINYINT,\n    `client_id`         VARCHAR(64),\n    `application_data`  VARCHAR(2000),\n    `gmt_create`        DATETIME(6),\n    `gmt_modified`      DATETIME(6),\n    PRIMARY KEY (`branch_id`),\n    KEY `idx_xid` (`xid`)\n) ENGINE = InnoDB\n  DEFAULT CHARSET = utf8mb4;\n\n-- the table to store lock data\nCREATE TABLE IF NOT EXISTS `lock_table`\n(\n    `row_key`        VARCHAR(128) NOT NULL,\n    `xid`            VARCHAR(96),\n    `transaction_id` BIGINT,\n    `branch_id`      BIGINT       NOT NULL,\n    `resource_id`    VARCHAR(256),\n    `table_name`     VARCHAR(32),\n    `pk`             VARCHAR(36),\n    `gmt_create`     DATETIME,\n    `gmt_modified`   DATETIME,\n    PRIMARY KEY (`row_key`),\n    KEY `idx_branch_id` (`branch_id`)\n) ENGINE = InnoDB\n  DEFAULT CHARSET = utf8mb4;\n\n-- for AT mode you must to init this sql for you business database. the seata server not need it.\nCREATE TABLE IF NOT EXISTS `undo_log`\n(\n    `branch_id`     BIGINT(20)   NOT NULL COMMENT \'branch transaction id\',\n    `xid`           VARCHAR(100) NOT NULL COMMENT \'global transaction id\',\n    `context`       VARCHAR(128) NOT NULL COMMENT \'undo_log context,such as serialization\',\n    `rollback_info` LONGBLOB     NOT NULL COMMENT \'rollback info\',\n    `log_status`    INT(11)      NOT NULL COMMENT \'0:normal status,1:defense status\',\n    `log_created`   DATETIME(6)  NOT NULL COMMENT \'create datetime\',\n    `log_modified`  DATETIME(6)  NOT NULL COMMENT \'modify datetime\',\n    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)\n) ENGINE = InnoDB\n  AUTO_INCREMENT = 1\n  DEFAULT CHARSET = utf8mb4 COMMENT =\'AT transaction mode undo table\';\n```\n\n5.启动seata\n\n到seata安装目录的bin目录中双击seata-server.bat，启动seata，然后到nacos服务列表中查看是否有seata服务\n\n![图片](/uploads/records/images/58caf46d-7b01-4feb-accf-8bbd8c438f52.png)\n\n\n\n### 项目集成seata\n\n1.在ruoyi-test项目的pom.xml文件中引入seata起步依赖\n\n```xml\n<dependency>\n    <groupId>com.alibaba.cloud</groupId>\n    <artifactId>spring-cloud-starter-alibaba-seata</artifactId>\n</dependency>\n```\n\n2.在ruoyi-test项目的bootstrap.yml中配置seata的配置\n\n```yaml\nseata:\n  registry:\n    type: nacos\n    nacos:\n      server-addr: 127.0.0.1:8848\n      namespace: public\n      group: SEATA_GROUP\n      application: seata-server\n```\n\n3.在ruoyi-system项目的pom.xml和bootstrap.yml文件中做一样的配置\n\n4.在ruoyi-test项目的SysStudentServiceImpl的insertSysStudent方法中添加注解\n\n@GlobalTransactional实现分布式事务控制。\n\n```java\n@Override\n@GlobalTransactional\npublic int insertSysStudent(SysStudent sysStudent){\n        int i = sysStudentMapper.insertSysStudent(sysStudent);\n        SysUser sysUser = new SysUser();\n        sysUser.setUserName(\"分布式事务测试1\");\n        sysUser.setNickName(\"分布式事务测试1\");\n        sysUser.setPassword(\"123456\");\n        AjaxResult add = remoteUserService.add(sysUser, SecurityConstants.INNER);\n        System.out.println(\"seata添加：\"+add.toString());\n        int a = 1/0;\n        return i;\n}\n```\n\n> 注意，ruoyi-system的RemoteUserService和RemoteUserFallbackFactory添加了关于add方法的处理。', '/uploads/records/covers/a6435cf6-b2f9-45e0-bf89-68b10d32c1db.jpg', 7, 1, 38, 10, 1, '2025-11-30 11:07:19', '2026-01-21 10:12:42');
INSERT INTO `record` VALUES (12, 'Java中的反射', '', '## Java 反射（Reflection）详解\n\n反射是 Java 的一种强大特性，允许程序在**运行时**检查类、接口、字段和方法，并且可以动态调用方法、创建对象、访问和修改字段等。\n\n### 1. **核心概念**\n\n反射 API 主要在 `java.lang.reflect` 包和 `java.lang.Class` 类中：\n\n```java\n// 获取 Class 对象的三种方式\nClass<?> clazz1 = String.class;           // 通过类字面量\nClass<?> clazz2 = \"hello\".getClass();     // 通过对象实例\nClass<?> clazz3 = Class.forName(\"java.lang.String\"); // 通过全限定类名\n```\n\n### 2. **主要功能**\n\n#### **A. 获取类信息**\n\n```java\nClass<?> clazz = Person.class;\n\n// 获取类名\nString className = clazz.getName();      // 全限定名\nString simpleName = clazz.getSimpleName(); // 简单名\n\n// 获取修饰符\nint modifiers = clazz.getModifiers();\nModifier.isPublic(modifiers);  // 判断是否为public\n\n// 获取父类\nClass<?> superClass = clazz.getSuperclass();\n\n// 获取实现的接口\nClass<?>[] interfaces = clazz.getInterfaces();\n\n// 获取包信息\nPackage pkg = clazz.getPackage();\n```\n\n#### **B. 操作字段（Field）**\n\n```java\npublic class Person {\n    private String name;\n    public int age;\n}\n\n// 获取所有字段（包括私有）\nField[] fields = clazz.getDeclaredFields();\n\n// 获取指定字段\nField nameField = clazz.getDeclaredField(\"name\");\n\n// 访问私有字段需要设置可访问性\nnameField.setAccessible(true);  // 关闭访问检查\n\n// 获取/设置字段值\nPerson person = new Person();\nObject value = nameField.get(person);     // 获取值\nnameField.set(person, \"张三\");           // 设置值\n```\n\n#### **C. 操作方法（Method）**\n\n```java\npublic class Calculator {\n    private int add(int a, int b) {\n        return a + b;\n    }\n    \n    public void print(String msg) {\n        System.out.println(msg);\n    }\n}\n\nClass<?> clazz = Calculator.class;\n\n// 获取所有方法\nMethod[] methods = clazz.getDeclaredMethods();\n\n// 获取指定方法\nMethod addMethod = clazz.getDeclaredMethod(\"add\", int.class, int.class);\naddMethod.setAccessible(true);  // 访问私有方法\n\n// 调用方法\nCalculator calc = new Calculator();\nObject result = addMethod.invoke(calc, 10, 20);  // 返回30\n\n// 调用公共方法\nMethod printMethod = clazz.getMethod(\"print\", String.class);\nprintMethod.invoke(calc, \"Hello Reflection\");\n```\n\n#### **D. 操作构造函数（Constructor）**\n\n```java\npublic class Person {\n    private Person() {}\n    public Person(String name) { this.name = name; }\n}\n\nClass<?> clazz = Person.class;\n\n// 获取所有构造方法\nConstructor<?>[] constructors = clazz.getDeclaredConstructors();\n\n// 获取指定构造方法\nConstructor<?> privateConstructor = clazz.getDeclaredConstructor();\nprivateConstructor.setAccessible(true);\n\n// 创建实例\nObject person1 = privateConstructor.newInstance();  // 使用私有构造\nObject person2 = clazz.getConstructor(String.class)\n                     .newInstance(\"张三\");  // 使用公共构造\n```\n\n### 3. **数组和泛型处理**\n\n```java\n// 创建数组\nObject array = Array.newInstance(String.class, 10);\nArray.set(array, 0, \"Element1\");\n\n// 泛型类型信息\nMethod method = MyClass.class.getMethod(\"getList\");\nType returnType = method.getGenericReturnType();  // 获取泛型信息\n\nif (returnType instanceof ParameterizedType) {\n    ParameterizedType type = (ParameterizedType) returnType;\n    Type[] typeArgs = type.getActualTypeArguments();  // 获取泛型参数\n}\n```\n\n### 4. **实际应用示例**\n\n#### **JSON 解析器示例**\n\n```java\npublic class JsonParser {\n    public static <T> T fromJson(String json, Class<T> clazz) \n            throws Exception {\n        // 解析 JSON（简化版）\n        Map<String, Object> map = parseJson(json);\n        T instance = clazz.getDeclaredConstructor().newInstance();\n        \n        // 设置字段值\n        for (Field field : clazz.getDeclaredFields()) {\n            field.setAccessible(true);\n            if (map.containsKey(field.getName())) {\n                field.set(instance, map.get(field.getName()));\n            }\n        }\n        return instance;\n    }\n}\n\n// 使用\nString json = \"{\\\"name\\\":\\\"张三\\\",\\\"age\\\":25}\";\nPerson person = JsonParser.fromJson(json, Person.class);\n```\n\n#### **方法调用器**\n\n```java\npublic class MethodInvoker {\n    public static Object invokeMethod(Object obj, String methodName, \n                                     Object... args) throws Exception {\n        Class<?>[] paramTypes = new Class[args.length];\n        for (int i = 0; i < args.length; i++) {\n            paramTypes[i] = args[i].getClass();\n        }\n        \n        Method method = obj.getClass()\n                .getDeclaredMethod(methodName, paramTypes);\n        method.setAccessible(true);\n        return method.invoke(obj, args);\n    }\n}\n```\n\n### 5. **性能考虑和最佳实践**\n\n#### **性能优化**\n\n```java\n// 1. 缓存反射对象\nprivate static final Map<String, Method> METHOD_CACHE = new HashMap<>();\n\npublic static Method getCachedMethod(Class<?> clazz, String name, \n                                    Class<?>... params) {\n    String key = clazz.getName() + \"#\" + name;\n    return METHOD_CACHE.computeIfAbsent(key, k -> {\n        try {\n            return clazz.getDeclaredMethod(name, params);\n        } catch (Exception e) {\n            throw new RuntimeException(e);\n        }\n    });\n}\n\n// 2. 使用 setAccessible(true) 减少安全检查\nField field = clazz.getDeclaredField(\"name\");\nfield.setAccessible(true);  // 只设置一次\n\n// 3. 考虑使用 MethodHandle（Java 7+）\nMethodHandles.Lookup lookup = MethodHandles.lookup();\nMethodHandle handle = lookup.findVirtual(\n        String.class, \"length\", MethodType.methodType(int.class));\nint length = (int) handle.invoke(\"hello\");\n```\n\n### 6. **反射的限制和安全问题**\n\n```java\n// 安全管理器检查\nSecurityManager sm = System.getSecurityManager();\nif (sm != null) {\n    sm.checkPermission(new ReflectPermission(\"suppressAccessChecks\"));\n}\n\n// 反射无法做的事情：\n// 1. 不能修改 final 字段的值（正常情况下）\n// 2. 不能访问不存在的方法或字段（会抛出异常）\n// 3. 性能开销较大\n```\n\n### 7. **替代方案**\n\n| 场景     | 推荐方案             |\n| -------- | -------------------- |\n| 依赖注入 | Spring、Guice        |\n| 序列化   | Jackson、Gson        |\n| 动态代理 | JDK Proxy、CGLIB     |\n| 配置映射 | MapStruct、BeanUtils |\n\n', '/uploads/records/covers/1c8fffda-f6e4-459a-a973-ff3dd4edd1fd.png', 7, 1, 9, 6, 1, '2025-11-28 07:54:56', '2026-01-07 09:53:24');
INSERT INTO `record` VALUES (13, 'Doker', '', '# Docker 使用指南\n\n## 一、Docker 核心概念\n\nDocker 是一个开源的应用容器引擎，允许开发者将应用及其依赖打包到标准化的容器中，实现**一次构建，到处运行**。\n\n**三大核心组件**：\n\n- **镜像（Image）**：只读模板，包含运行应用所需的所有内容\n- **容器（Container）**：镜像的运行实例\n- **仓库（Registry）**：存储镜像的地方（如 Docker Hub）\n\n## 二、基础命令大全\n\n### 1. **镜像管理**\n\n```bash\n# 拉取镜像\ndocker pull nginx:latest\n\n# 查看本地镜像\ndocker images\ndocker image ls\n\n# 删除镜像\ndocker rmi <image_id>\ndocker image rm <image_id>\n\n# 构建镜像\ndocker build -t myapp:v1 .\n```\n\n### 2. **容器操作**\n\n```bash\n# 运行容器\ndocker run -d --name my-nginx -p 80:80 nginx\n\n# 查看运行中的容器\ndocker ps\ndocker container ls\n\n# 查看所有容器（包括停止的）\ndocker ps -a\n\n# 停止容器\ndocker stop my-nginx\n\n# 启动已停止的容器\ndocker start my-nginx\n\n# 删除容器\ndocker rm my-nginx\n\n# 进入容器\ndocker exec -it my-nginx /bin/bash\n```\n\n### 3. **常用参数说明**\n\n- `-d`：后台运行（守护进程）\n- `-it`：交互式终端\n- `-p`：端口映射（主机端口:容器端口）\n- `-v`：数据卷挂载（主机目录:容器目录）\n- `--name`：指定容器名称\n- `-e`：设置环境变量\n\n## 三、实战示例\n\n### **1. 运行 Web 应用**\n\n```bash\n# 运行 Nginx\ndocker run -d \\\n  --name web-server \\\n  -p 8080:80 \\\n  -v /data/html:/usr/share/nginx/html \\\n  nginx:alpine\n\n# 访问：http://localhost:8080\n```\n\n### **2. 运行数据库**\n\n```bash\n# 运行 MySQL\ndocker run -d \\\n  --name mysql-db \\\n  -p 3306:3306 \\\n  -e MYSQL_ROOT_PASSWORD=123456 \\\n  -v /data/mysql:/var/lib/mysql \\\n  mysql:8.0\n\n# 连接数据库\ndocker exec -it mysql-db mysql -uroot -p\n```\n\n### **3. 构建自定义镜像**\n\n```dockerfile\n# Dockerfile 示例\nFROM openjdk:11-jre-slim\nWORKDIR /app\nCOPY target/myapp.jar app.jar\nEXPOSE 8080\nENTRYPOINT [\"java\", \"-jar\", \"app.jar\"]\n```\n\n```bash\n# 构建镜像\ndocker build -t my-java-app:v1 .\n\n# 运行\ndocker run -d -p 8080:8080 my-java-app:v1\n```\n\n## 四、高级功能\n\n### **1. Docker Compose（多容器编排）**\n\n```yaml\n# docker-compose.yml\nversion: \'3\'\nservices:\n  web:\n    image: nginx:alpine\n    ports:\n      - \"80:80\"\n    depends_on:\n      - app\n  \n  app:\n    build: ./app\n    ports:\n      - \"8080:8080\"\n  \n  db:\n    image: postgres:13\n    environment:\n      POSTGRES_PASSWORD: example\n```\n\n```bash\n# 启动所有服务\ndocker-compose up -d\n\n# 停止服务\ndocker-compose down\n```\n\n### **2. 数据持久化**\n\n```bash\n# 创建数据卷\ndocker volume create mydata\n\n# 使用数据卷\ndocker run -d \\\n  -v mydata:/var/lib/mysql \\\n  mysql:8.0\n\n# 查看数据卷\ndocker volume ls\n```\n\n### **3. 网络管理**\n\n```bash\n# 创建自定义网络\ndocker network create my-network\n\n# 使用自定义网络\ndocker run -d --network my-network --name app1 nginx\ndocker run -d --network my-network --name app2 nginx\n\n# 容器间可通过名称直接通信\ndocker exec app1 ping app2\n```\n\n## 五、最佳实践\n\n1. **镜像优化**\n\n   - 使用多阶段构建减小镜像体积\n   - 选择合适的基础镜像（如 alpine 版本）\n   - 合并 RUN 命令减少层数\n\n2. **安全建议**\n\n   - 避免在容器中以 root 用户运行\n   - 定期更新基础镜像\n   - 扫描镜像中的漏洞\n\n3. **日常维护**\n\n   ```bash\n   # 清理无用资源\n   docker system prune -a\n   \n   # 查看容器日志\n   docker logs -f <container_name>\n   \n   # 监控资源使用\n   docker stats\n   ```\n\nDocker 极大简化了应用的部署和运维，通过容器化技术实现了环境一致性。建议从基础命令开始，逐步掌握 Dockerfile 编写、Compose 编排等高级功能，最终形成完整的容器化开发部署流程。', '/uploads/records/covers/92156825-39d0-4ae9-aed5-a2e22f89064f.png', 9, 1, 10, 4, 1, '2025-11-27 08:34:29', '2025-12-01 09:59:30');
INSERT INTO `record` VALUES (14, 'Vue3和Vue2的区别', '', '# Vue3 与 Vue2 主要区别\n\n## 一、架构设计革新\n\n### **1. 响应式系统重写**\n\n```javascript\n// Vue2：Object.defineProperty\nconst obj = {}\nObject.defineProperty(obj, \'key\', {\n  get() { /* 依赖收集 */ },\n  set() { /* 触发更新 */ }\n})\n\n// Vue3：Proxy（原生支持，性能更优）\nconst proxy = new Proxy(obj, {\n  get(target, key) { /* 追踪 */ },\n  set(target, key, value) { /* 触发 */ }\n})\n```\n\n**优势**：\n\n- 支持数组索引/长度变化监听\n- 支持动态添加/删除属性\n- 性能提升约2倍\n\n### **2. Composition API**\n\n```vue\n<!-- Vue2 Options API -->\n<script>\nexport default {\n  data() { return { count: 0 } },\n  methods: { increment() { this.count++ } },\n  mounted() { console.log(\'mounted\') }\n}\n</script>\n\n<!-- Vue3 Composition API -->\n<script setup>\nimport { ref, onMounted } from \'vue\'\n\nconst count = ref(0)\nconst increment = () => count.value++\n\nonMounted(() => {\n  console.log(\'mounted\')\n})\n</script>\n```\n\n**优势**：\n\n- 更好的逻辑复用（自定义组合函数）\n- 更灵活的逻辑组织\n- TypeScript 支持更完善\n\n## 二、核心差异对比\n\n| 特性           | Vue2                  | Vue3                           |\n| -------------- | --------------------- | ------------------------------ |\n| **响应式系统** | Object.defineProperty | Proxy                          |\n| **API 风格**   | Options API 为主      | Composition API + Options API  |\n| **TypeScript** | 支持有限              | 原生支持完善                   |\n| **打包体积**   | 约 23KB（运行时）     | 约 13KB（运行时，-41%）        |\n| **性能**       | 较慢                  | 渲染快 1.3-2 倍，更新快 2-6 倍 |\n| **Fragment**   | 不支持                | 支持多根节点                   |\n| **Teleport**   | 无                    | 内置传送组件                   |\n| **Suspense**   | 无                    | 内置异步组件处理               |\n\n## 三、新特性详解\n\n### **1. Fragment（碎片）**\n\n```vue\n<!-- Vue2：必须单根节点 -->\n<template>\n  <div>\n    <h1>标题</h1>\n    <p>内容</p>\n  </div>\n</template>\n\n<!-- Vue3：支持多根节点 -->\n<template>\n  <h1>标题</h1>\n  <p>内容</p>\n  <!-- 无需额外包裹div -->\n</template>\n```\n\n### **2. Teleport（传送）**\n\n```vue\n<!-- 将内容渲染到body或其他位置 -->\n<template>\n  <teleport to=\"body\">\n    <div class=\"modal\">弹窗内容</div>\n  </teleport>\n</template>\n```\n\n### **3. Suspense（异步组件）**\n\n```vue\n<template>\n  <Suspense>\n    <template #default>\n      <AsyncComponent />\n    </template>\n    <template #fallback>\n      <div>加载中...</div>\n    </template>\n  </Suspense>\n</template>\n```\n\n## 四、开发体验改进\n\n### **1. 更好的 TypeScript 支持**\n\n- 所有 API 都提供完整类型定义\n- 组合函数自动类型推断\n- 模板表达式类型检查（实验性）\n\n### **2. 按需导入**\n\n```javascript\n// Vue2：全量导入\nimport Vue from \'vue\'\n\n// Vue3：可只导入需要的API\nimport { ref, computed, watchEffect } from \'vue\'\n```\n\n### **3. 全局 API 变更**\n\n```javascript\n// Vue2\nVue.component(\'MyComp\', MyComponent)\nVue.directive(\'focus\', focusDirective)\n\n// Vue3（Tree-shaking友好）\nconst app = createApp(App)\napp.component(\'MyComp\', MyComponent)\napp.directive(\'focus\', focusDirective)\n```\n\n## 五、迁移注意事项\n\n### **1. 破坏性变更**\n\n- `v-model` 语法变更\n- 事件 API 调整（`$on`、`$off` 移除）\n- 过滤器（filter）废弃\n- 生命周期钩子改名（`destroyed` → `unmounted`）\n\n### **2. 兼容性处理**\n\n```javascript\n// Vue3 提供兼容版本\nimport { createApp } from \'vue\'\nimport { plugin } from \'@vue/compat\'\n\nconst app = createApp(App)\napp.use(plugin) // 启用兼容模式\n```\n\n---\n\nVue3 在性能、开发体验和扩展性上都实现了质的飞跃。虽然存在一些破坏性变更，但官方提供了完善的迁移指南和兼容方案。建议新项目优先选择 Vue3，老项目可根据实际情况制定迁移计划。\n\n', '/uploads/records/covers/54eaaad3-b4f4-4fee-8972-b5cba02d99a6.jfif', 6, 1, 18, 9, 1, '2025-11-27 08:34:29', '2025-12-30 09:28:39');
INSERT INTO `record` VALUES (15, '阿里百炼 AI API 集成开发指南', '', '# 阿里百炼 AI API 集成开发指南\n\n> 本文档详细介绍如何使用阿里云百炼（Bailian）API 实现智能法律助手功能，适合初学者从零开始学习。\n\n---\n\n## 目录\n\n1. [前置准备](#1-前置准备)\n2. [获取 API Key 和 App ID](#2-获取-api-key-和-app-id)\n3. [后端实现](#3-后端实现)\n4. [前端实现](#4-前端实现)\n5. [核心功能详解](#5-核心功能详解)\n6. [常见问题与解决方案](#6-常见问题与解决方案)\n\n---\n\n## 1. 前置准备\n\n### 1.1 技术栈要求\n\n| 层级   | 技术                   | 版本要求                |\n| ------ | ---------------------- | ----------------------- |\n| 后端   | Java + Spring Boot     | JDK 8+, Spring Boot 2.x |\n| 前端   | Vue 3 + Ant Design Vue | Vue 3.x                 |\n| AI服务 | 阿里云百炼 DashScope   | -                       |\n\n### 1.2 所需依赖\n\n**后端 Maven 依赖 (pom.xml)**：\n\n```xml\n<!-- 阿里云 DashScope SDK -->\n<dependency>\n    <groupId>com.alibaba</groupId>\n    <artifactId>dashscope-sdk-java</artifactId>\n    <version>2.8.3</version>\n</dependency>\n```\n\n---\n\n## 2. 获取 API Key 和 App ID\n\n### 2.1 注册阿里云账号\n\n1. 访问 [阿里云官网](https://www.aliyun.com/)\n2. 注册并完成实名认证\n\n### 2.2 开通百炼服务\n\n1. 登录阿里云控制台\n2. 搜索 **\"百炼\"** 或访问 [百炼控制台](https://bailian.console.aliyun.com/)\n3. 点击 **\"开通服务\"**（新用户有免费额度）\n\n### 2.3 获取 API Key\n\n1. 进入百炼控制台\n2. 点击右上角头像 → **\"API-KEY 管理\"**\n3. 点击 **\"创建 API Key\"**\n4. 复制生成的 Key（格式：`sk-xxxxxxxxxxxxxxxx`）\n\n> ⚠️ **重要**：API Key 只显示一次，请妥善保存！\n\n### 2.4 获取 App ID（应用ID）\n\n1. 在百炼控制台左侧菜单选择 **\"我的应用\"**\n2. 点击 **\"创建应用\"**\n3. 选择应用类型（推荐：**对话应用**）\n4. 配置应用：\n   - 应用名称：如 \"法律助手\"\n   - 选择模型：推荐 **qwen-plus** 或 **qwen-turbo**\n   - 设置系统提示词（用于限制回答范围，见下文）\n5. 创建完成后，在应用详情页复制 **App ID**\n\n### 2.5 配置环境变量\n\n在后端项目根目录创建 `.env` 文件：\n\n```env\nDASHSCOPE_API_KEY=sk-你的API密钥\nBAILIAN_APP_ID=你的应用ID\n```\n\n---\n\n## 3. 后端实现\n\n### 3.1 配置文件 (application.yml)\n\n```yaml\nserver:\n  port: 8080\n\nspring:\n  # 百炼AI配置\n  bailian:\n    api-key: ${DASHSCOPE_API_KEY:}\n    app-id: ${BAILIAN_APP_ID:}\n```\n\n### 3.2 百炼服务类 (BailianService.java)\n\n```java\npackage com.example.demo.service;\n\nimport com.alibaba.dashscope.aigc.generation.Generation;\nimport com.alibaba.dashscope.aigc.generation.GenerationParam;\nimport com.alibaba.dashscope.aigc.generation.GenerationResult;\nimport com.alibaba.dashscope.common.Message;\nimport com.alibaba.dashscope.common.Role;\nimport io.reactivex.Flowable;\nimport org.springframework.beans.factory.annotation.Value;\nimport org.springframework.stereotype.Service;\n\nimport javax.annotation.PostConstruct;\nimport java.util.ArrayList;\nimport java.util.List;\n\n@Service\npublic class BailianService {\n\n    @Value(\"${spring.bailian.api-key:}\")\n    private String apiKey;\n\n    @Value(\"${spring.bailian.app-id:}\")\n    private String appId;\n\n    private Generation generation;\n\n    // 系统提示词 - 限制AI只回答法律问题\n    private static final String SYSTEM_PROMPT = \"\"\"\n        你是一位专业的法律AI助手，专门帮助律师进行法律研究和咨询工作。\n\n        你的职责范围：\n        1. 法律法规检索和解读\n        2. 案例分析和研究\n        3. 法律文书起草建议\n        4. 合同条款分析\n        5. 法律风险评估\n\n        重要限制：\n        - 只回答与法律相关的问题\n        - 对于非法律问题，礼貌地引导用户回到法律话题\n        - 不提供医疗、投资等其他专业领域的建议\n        - 回答要专业、准确，引用具体法条时注明出处\n        \"\"\";\n\n    @PostConstruct\n    public void init() {\n        if (apiKey != null && !apiKey.isEmpty()) {\n            generation = new Generation();\n        }\n    }\n\n    /**\n     * 检查服务是否可用\n     */\n    public boolean isHealthy() {\n        return generation != null \n            && apiKey != null && !apiKey.isEmpty()\n            && appId != null && !appId.isEmpty();\n    }\n\n    /**\n     * 流式对话（核心方法）\n     */\n    public Flowable<GenerationResult> streamChat(String question, List<Message> history) {\n        // 构建消息列表\n        List<Message> messages = new ArrayList<>();\n        \n        // 添加系统提示（限制AI行为）\n        messages.add(Message.builder()\n            .role(Role.SYSTEM.getValue())\n            .content(SYSTEM_PROMPT)\n            .build());\n        \n        // 添加历史对话\n        if (history != null) {\n            messages.addAll(history);\n        }\n        \n        // 添加当前问题\n        messages.add(Message.builder()\n            .role(Role.USER.getValue())\n            .content(question)\n            .build());\n\n        // 构建请求参数\n        GenerationParam param = GenerationParam.builder()\n            .apiKey(apiKey)\n            .model(\"qwen-plus\")  // 或 qwen-turbo\n            .messages(messages)\n            .resultFormat(GenerationParam.ResultFormat.MESSAGE)\n            .incrementalOutput(true)  // 开启增量输出（流式）\n            .build();\n\n        // 返回流式结果\n        return generation.streamCall(param);\n    }\n\n    /**\n     * 普通对话（非流式）\n     */\n    public String chat(String question) throws Exception {\n        List<Message> messages = new ArrayList<>();\n        \n        messages.add(Message.builder()\n            .role(Role.SYSTEM.getValue())\n            .content(SYSTEM_PROMPT)\n            .build());\n            \n        messages.add(Message.builder()\n            .role(Role.USER.getValue())\n            .content(question)\n            .build());\n\n        GenerationParam param = GenerationParam.builder()\n            .apiKey(apiKey)\n            .model(\"qwen-plus\")\n            .messages(messages)\n            .resultFormat(GenerationParam.ResultFormat.MESSAGE)\n            .build();\n\n        GenerationResult result = generation.call(param);\n        return result.getOutput().getChoices().get(0)\n            .getMessage().getContent();\n    }\n}\n```\n\n### 3.3 控制器 (BailianController.java)\n\n```java\npackage com.example.demo.controller;\n\nimport com.alibaba.dashscope.aigc.generation.GenerationResult;\nimport com.alibaba.dashscope.common.Message;\nimport com.alibaba.dashscope.common.Role;\nimport com.example.demo.service.BailianService;\nimport io.reactivex.Flowable;\nimport org.springframework.beans.factory.annotation.Autowired;\nimport org.springframework.http.MediaType;\nimport org.springframework.http.ResponseEntity;\nimport org.springframework.web.bind.annotation.*;\nimport org.springframework.web.servlet.mvc.method.annotation.SseEmitter;\n\nimport java.util.*;\n\n@RestController\n@RequestMapping(\"/api/bailian\")\n@CrossOrigin(origins = \"*\")  // 允许跨域\npublic class BailianController {\n\n    @Autowired\n    private BailianService bailianService;\n\n    /**\n     * 健康检查接口\n     * GET /api/bailian/health\n     */\n    @GetMapping(\"/health\")\n    public ResponseEntity<Map<String, Object>> healthCheck() {\n        Map<String, Object> result = new HashMap<>();\n        \n        boolean healthy = bailianService.isHealthy();\n        result.put(\"success\", true);\n        result.put(\"healthy\", healthy);\n        result.put(\"message\", healthy ? \"服务正常\" : \"服务异常\");\n        result.put(\"timestamp\", new Date());\n        \n        return ResponseEntity.ok(result);\n    }\n\n    /**\n     * 流式对话接口（带历史记录）\n     * POST /api/bailian/chat/stream-with-history\n     * \n     * 请求体格式：\n     * {\n     *   \"question\": \"用户问题\",\n     *   \"history\": [\n     *     { \"type\": \"user\", \"text\": \"之前的问题\" },\n     *     { \"type\": \"ai\", \"text\": \"之前的回答\" }\n     *   ]\n     * }\n     */\n    @PostMapping(value = \"/chat/stream-with-history\", \n                 produces = MediaType.TEXT_EVENT_STREAM_VALUE)\n    public SseEmitter streamChatWithHistory(@RequestBody Map<String, Object> request) {\n        \n        // 创建SSE发射器，设置超时时间\n        SseEmitter emitter = new SseEmitter(300000L);  // 5分钟超时\n        \n        String question = (String) request.get(\"question\");\n        List<Map<String, String>> historyList = \n            (List<Map<String, String>>) request.get(\"history\");\n        \n        // 转换历史消息格式\n        List<Message> history = new ArrayList<>();\n        if (historyList != null) {\n            for (Map<String, String> msg : historyList) {\n                String type = msg.get(\"type\");\n                String text = msg.get(\"text\");\n                \n                history.add(Message.builder()\n                    .role(\"user\".equals(type) ? Role.USER.getValue() : Role.ASSISTANT.getValue())\n                    .content(text)\n                    .build());\n            }\n        }\n        \n        // 异步处理流式响应\n        new Thread(() -> {\n            try {\n                Flowable<GenerationResult> flowable = \n                    bailianService.streamChat(question, history);\n                \n                flowable.blockingForEach(result -> {\n                    String content = result.getOutput().getChoices()\n                        .get(0).getMessage().getContent();\n                    \n                    if (content != null && !content.isEmpty()) {\n                        // 发送SSE事件\n                        emitter.send(SseEmitter.event()\n                            .data(content));\n                    }\n                });\n                \n                // 发送完成信号\n                emitter.send(SseEmitter.event().data(\"[DONE]\"));\n                emitter.complete();\n                \n            } catch (Exception e) {\n                emitter.completeWithError(e);\n            }\n        }).start();\n        \n        return emitter;\n    }\n\n    /**\n     * 带文件的流式对话\n     * POST /api/bailian/chat/stream-with-files\n     */\n    @PostMapping(value = \"/chat/stream-with-files\",\n                 produces = MediaType.TEXT_EVENT_STREAM_VALUE)\n    public SseEmitter streamChatWithFiles(\n            @RequestParam(\"question\") String question,\n            @RequestParam(\"files\") MultipartFile[] files) {\n        \n        SseEmitter emitter = new SseEmitter(300000L);\n        \n        new Thread(() -> {\n            try {\n                // 1. 处理上传的文件\n                StringBuilder fileContent = new StringBuilder();\n                for (MultipartFile file : files) {\n                    String content = extractFileContent(file);\n                    fileContent.append(\"文件: \").append(file.getOriginalFilename())\n                        .append(\"\\n内容:\\n\").append(content).append(\"\\n\\n\");\n                }\n                \n                // 通知前端文件处理完成\n                emitter.send(SseEmitter.event()\n                    .data(\"文件处理完成，共处理 \" + files.length + \" 个文件\"));\n                \n                // 2. 结合文件内容进行AI对话\n                String fullQuestion = question + \"\\n\\n以下是相关文件内容：\\n\" + fileContent;\n                \n                Flowable<GenerationResult> flowable = \n                    bailianService.streamChat(fullQuestion, null);\n                \n                flowable.blockingForEach(result -> {\n                    String content = result.getOutput().getChoices()\n                        .get(0).getMessage().getContent();\n                    \n                    if (content != null && !content.isEmpty()) {\n                        emitter.send(SseEmitter.event().data(content));\n                    }\n                });\n                \n                emitter.send(SseEmitter.event().data(\"[DONE]\"));\n                emitter.complete();\n                \n            } catch (Exception e) {\n                emitter.completeWithError(e);\n            }\n        }).start();\n        \n        return emitter;\n    }\n\n    /**\n     * 提取文件内容\n     */\n    private String extractFileContent(MultipartFile file) {\n        // 根据文件类型提取内容\n        String filename = file.getOriginalFilename().toLowerCase();\n        \n        try {\n            if (filename.endsWith(\".txt\")) {\n                return new String(file.getBytes(), \"UTF-8\");\n            }\n            // PDF、Word等需要额外的库来解析\n            // 这里简化处理\n            return \"[文件内容]\";\n        } catch (Exception e) {\n            return \"[无法读取文件内容]\";\n        }\n    }\n}\n```\n\n---\n\n## 4. 前端实现\n\n### 4.1 API封装 (src/api/bailian.js)\n\n```javascript\n// 百炼AI服务API\nconst BAILIAN_BASE_URL = \'http://localhost:8080/api/bailian\'\n\n/**\n * 健康检查 - 检测AI服务是否可用\n */\nexport const checkHealth = async () => {\n    try {\n        const response = await fetch(`${BAILIAN_BASE_URL}/health`, {\n            method: \'GET\',\n            signal: AbortSignal.timeout(5000)  // 5秒超时\n        })\n        \n        if (!response.ok) {\n            return { success: false, healthy: false }\n        }\n        \n        return await response.json()\n    } catch (error) {\n        console.error(\'健康检查失败:\', error)\n        return { success: false, healthy: false }\n    }\n}\n\n/**\n * 流式对话（核心功能）\n * \n * @param {string} question - 用户问题\n * @param {Array} history - 历史对话\n * @param {Function} onToken - 每收到一个token时的回调\n * @param {Function} onComplete - 完成时的回调\n * @param {Function} onError - 错误时的回调\n */\nexport const streamChatWithHistory = async (\n    question, \n    history, \n    onToken, \n    onComplete, \n    onError\n) => {\n    const url = `${BAILIAN_BASE_URL}/chat/stream-with-history`\n    \n    try {\n        // 发送POST请求\n        const response = await fetch(url, {\n            method: \'POST\',\n            headers: {\n                \'Content-Type\': \'application/json\'\n            },\n            body: JSON.stringify({\n                question: question,\n                history: history || []\n            })\n        })\n        \n        if (!response.ok) {\n            throw new Error(`服务器错误: ${response.status}`)\n        }\n        \n        // 获取响应流的读取器\n        const reader = response.body.getReader()\n        const decoder = new TextDecoder()\n        let buffer = \'\'\n        \n        // 循环读取流数据\n        while (true) {\n            const { done, value } = await reader.read()\n            \n            if (done) break\n            \n            // 解码二进制数据\n            buffer += decoder.decode(value, { stream: true })\n            \n            // 解析SSE事件（格式：data: xxx\\n\\n）\n            const lines = buffer.split(\'\\n\')\n            buffer = lines.pop() || \'\'\n            \n            for (const line of lines) {\n                if (line.startsWith(\'data:\')) {\n                    const data = line.substring(5).trim()\n                    \n                    // 检查是否完成\n                    if (data === \'[DONE]\') {\n                        if (onComplete) onComplete()\n                        return\n                    }\n                    \n                    // 调用token回调，实现打字机效果\n                    if (data && onToken) {\n                        onToken(data)\n                    }\n                }\n            }\n        }\n        \n        if (onComplete) onComplete()\n        \n    } catch (error) {\n        console.error(\'流式对话失败:\', error)\n        if (onError) onError(error)\n    }\n}\n\n/**\n * 带文件的流式对话\n */\nexport const streamChatWithFiles = async (\n    question,\n    files,\n    onToken,\n    onComplete,\n    onError,\n    onFilesProcessed\n) => {\n    const url = `${BAILIAN_BASE_URL}/chat/stream-with-files`\n    \n    try {\n        // 使用FormData上传文件\n        const formData = new FormData()\n        formData.append(\'question\', question)\n        \n        files.forEach(file => {\n            formData.append(\'files\', file)\n        })\n        \n        const response = await fetch(url, {\n            method: \'POST\',\n            body: formData  // 不设置Content-Type，让浏览器自动处理\n        })\n        \n        if (!response.ok) {\n            throw new Error(`服务器错误: ${response.status}`)\n        }\n        \n        // 处理流式响应...（同上）\n        \n    } catch (error) {\n        if (onError) onError(error)\n    }\n}\n```\n\n### 4.2 Vue组件核心代码\n\n```vue\n<script setup>\nimport { ref, onMounted } from \'vue\'\nimport { \n    checkHealth, \n    streamChatWithHistory \n} from \'@/api/bailian\'\n\n// 状态\nconst isServiceHealthy = ref(false)\nconst chatHistory = ref([])\nconst userInput = ref(\'\')\nconst isLoading = ref(false)\n\n// 页面加载时检查服务状态\nonMounted(async () => {\n    const result = await checkHealth()\n    isServiceHealthy.value = result.success && result.healthy\n})\n\n// 发送消息\nconst sendMessage = async () => {\n    const question = userInput.value.trim()\n    if (!question || isLoading.value) return\n    \n    // 添加用户消息到历史\n    chatHistory.value.push({\n        type: \'user\',\n        text: question,\n        time: new Date()\n    })\n    \n    userInput.value = \'\'\n    isLoading.value = true\n    \n    // 添加AI消息占位\n    const aiIndex = chatHistory.value.length\n    chatHistory.value.push({\n        type: \'ai\',\n        text: \'\',\n        time: new Date()\n    })\n    \n    // 调用流式API\n    await streamChatWithHistory(\n        question,\n        chatHistory.value.slice(0, -2),  // 不包含当前对话\n        \n        // onToken - 每收到一个字就追加显示\n        (token) => {\n            chatHistory.value[aiIndex].text += token\n        },\n        \n        // onComplete\n        () => {\n            isLoading.value = false\n        },\n        \n        // onError\n        (error) => {\n            chatHistory.value[aiIndex].text = \'抱歉，服务暂时不可用\'\n            isLoading.value = false\n        }\n    )\n}\n</script>\n```\n\n---\n\n## 5. 核心功能详解\n\n### 5.1 如何限制AI只回答法律问题\n\n通过 **System Prompt（系统提示词）** 来限制AI的回答范围：\n\n```java\nprivate static final String SYSTEM_PROMPT = \"\"\"\n    你是一位专业的法律AI助手。\n    \n    你的职责范围：\n    1. 法律法规检索和解读\n    2. 案例分析和研究\n    3. 法律文书起草建议\n    \n    重要限制：\n    - 只回答与法律相关的问题\n    - 对于非法律问题，礼貌地说\"抱歉，我只能回答法律相关的问题\"\n    - 不提供医疗、投资等其他专业领域的建议\n    \"\"\";\n```\n\n**工作原理**：\n\n- System Prompt 在每次对话时作为第一条消息发送\n- AI会根据这个提示词来约束自己的回答范围\n- 用户无法看到或修改这个提示词\n\n### 5.2 流式输出实现原理\n\n```\n┌──────────┐     SSE连接      ┌──────────┐\n│  前端    │ ◄──────────────► │  后端    │\n└──────────┘                  └──────────┘\n     │                              │\n     │  POST /chat/stream           │\n     │ ───────────────────────────► │\n     │                              │ 调用AI API\n     │                              │\n     │  data: 你                    │\n     │ ◄─────────────────────────── │\n     │  data: 好                    │\n     │ ◄─────────────────────────── │\n     │  data: ，                    │\n     │ ◄─────────────────────────── │\n     │  data: 我是AI助手            │\n     │ ◄─────────────────────────── │\n     │  data: [DONE]               │\n     │ ◄─────────────────────────── │\n```\n\n**SSE (Server-Sent Events) 格式**：\n\n```\ndata: 内容1\n\ndata: 内容2\n\ndata: [DONE]\n\n```\n\n### 5.3 服务健康检查\n\n```javascript\n// 前端：页面加载时检查\nonMounted(async () => {\n    const result = await checkHealth()\n    if (result.healthy) {\n        // 显示绿色状态：🟢 服务正常\n    } else {\n        // 显示红色状态：🔴 服务异常\n    }\n})\n```\n\n```java\n// 后端：检查配置是否完整\npublic boolean isHealthy() {\n    return apiKey != null && !apiKey.isEmpty()\n        && appId != null && !appId.isEmpty();\n}\n```\n\n### 5.4 历史对话上下文\n\nAI需要知道之前聊了什么才能理解当前问题：\n\n```javascript\n// 发送请求时带上历史对话\nbody: JSON.stringify({\n    question: \"那这个条款有什么风险？\",\n    history: [\n        { type: \"user\", text: \"请帮我看看这份合同\" },\n        { type: \"ai\", text: \"好的，这份合同主要涉及...\" }\n    ]\n})\n```\n\n---\n\n## 6. 常见问题与解决方案\n\n### 6.1 ERR_CONNECTION_REFUSED\n\n**问题**：前端无法连接后端\n\n**解决**：\n\n1. 确保后端服务已启动（端口8080）\n2. 检查防火墙设置\n3. 确保前端API地址正确\n\n### 6.2 服务显示异常（healthy: false）\n\n**问题**：健康检查返回异常\n\n**解决**：\n\n1. 检查 `.env` 文件中的 API Key 和 App ID\n2. **关闭VPN**（阿里云服务在国内）\n3. 检查阿里云账户是否有余额/额度\n\n### 6.3 ERR_INCOMPLETE_CHUNKED_ENCODING\n\n**问题**：流式响应不完整\n\n**解决**：\n\n1. 关闭VPN\n2. 检查网络连接\n3. 增加后端超时时间\n\n### 6.4 跨域错误 (CORS)\n\n**问题**：浏览器报跨域错误\n\n**解决**：确保后端有正确的CORS配置\n\n```java\n@CrossOrigin(origins = \"*\")\n@RestController\npublic class BailianController {\n    // ...\n}\n```\n\n---\n\n## 7. 完整项目结构\n\n```\nproject/\n├── backend/\n│   ├── src/main/java/com/example/demo/\n│   │   ├── controller/\n│   │   │   └── BailianController.java    # API接口\n│   │   ├── service/\n│   │   │   └── BailianService.java       # 业务逻辑\n│   │   └── config/\n│   │       └── CorsConfig.java           # 跨域配置\n│   ├── src/main/resources/\n│   │   └── application.yml               # 配置文件\n│   ├── .env                               # 环境变量\n│   └── pom.xml                           # Maven依赖\n│\n└── frontend/\n    └── src/\n        ├── api/\n        │   └── bailian.js                # API封装\n        └── views/\n            └── aiAssistant/\n                └── index.vue             # AI助手页面\n```\n\n---\n\n## 8. 费用说明\n\n| 模型       | 免费额度    | 超出后价格      |\n| ---------- | ----------- | --------------- |\n| qwen-turbo | 100万tokens | ¥0.008/千tokens |\n| qwen-plus  | 100万tokens | ¥0.02/千tokens  |\n| qwen-max   | 100万tokens | ¥0.04/千tokens  |\n\n> 💡 **提示**：新用户通常有免费额度，足够开发测试使用。\n\n---\n\n## 9. 最佳实践\n\n1. **保护API Key**：不要在前端代码中暴露API Key\n2. **错误处理**：始终处理网络错误和API错误\n3. **超时设置**：为API请求设置合理的超时时间\n4. **日志记录**：记录关键操作便于调试\n5. **用户体验**：使用流式输出提升交互体验\n\n---\n\n## 10. 参考资料\n\n- [阿里云百炼官方文档](https://help.aliyun.com/product/610206.html)\n- [DashScope SDK GitHub](https://github.com/aliyun/dashscope-sdk-java)\n- [Server-Sent Events MDN](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events)', '', 23, 1, 1, 0, 1, '2026-01-28 18:05:38', '2026-01-28 10:06:00');

-- ----------------------------
-- Table structure for record_category
-- ----------------------------
DROP TABLE IF EXISTS `record_category`;
CREATE TABLE `record_category`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `category_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类标识（如 tech, life, study）',
  `icon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类图标（emoji）',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '父分类ID，NULL表示一级分类',
  `sort_order` int(0) NULL DEFAULT 0 COMMENT '排序顺序',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE,
  INDEX `idx_category_key`(`category_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record_category
-- ----------------------------
INSERT INTO `record_category` VALUES (1, '技术', 'tech', '💻', NULL, 1, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (2, '生活', 'life', '🌸', NULL, 2, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (3, '学习', 'study', '📖', NULL, 3, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (4, '旅行', 'travel', '✈️', NULL, 4, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (5, '美食', 'food', '🍜', NULL, 5, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (6, '前端开发', 'frontend', NULL, 1, 1, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (7, '后端开发', 'backend', NULL, 1, 2, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (8, '数据库', 'database', NULL, 1, 3, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (9, '运维部署', 'devops', NULL, 1, 4, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (10, '人工智能', 'ai', NULL, 1, 5, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (11, '日常', 'daily', NULL, 2, 1, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (12, '心情', 'mood', NULL, 2, 2, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (13, '爱好', 'hobby', NULL, 2, 3, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (14, '笔记', 'notes', NULL, 3, 1, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (15, '读书', 'reading', NULL, 3, 2, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (16, '课程', 'course', NULL, 3, 3, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (17, '国内', 'domestic', NULL, 4, 1, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (18, '国外', 'abroad', NULL, 4, 2, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (19, '城市漫步', 'cityWalk', NULL, 4, 3, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (20, '餐厅', 'restaurant', NULL, 5, 1, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (21, '自制', 'homemade', NULL, 5, 2, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (22, '甜品', 'dessert', NULL, 5, 3, '2025-11-27 12:04:11', '2025-11-27 12:04:11');
INSERT INTO `record_category` VALUES (23, 'AI', 'cat_1547', '', 1, 1, '2026-01-28 18:04:02', '2026-01-28 18:04:02');

-- ----------------------------
-- Table structure for record_like
-- ----------------------------
DROP TABLE IF EXISTS `record_like`;
CREATE TABLE `record_like`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '点赞ID',
  `record_id` bigint(0) NOT NULL COMMENT '记录ID',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户ID（登录用户）',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址（游客）',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '点赞时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_record_user`(`record_id`, `user_id`) USING BTREE,
  UNIQUE INDEX `uk_record_ip`(`record_id`, `ip_address`) USING BTREE,
  INDEX `idx_record_id`(`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录点赞表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record_like
-- ----------------------------
INSERT INTO `record_like` VALUES (9, 12, NULL, '192.168.29.1', NULL);
INSERT INTO `record_like` VALUES (10, 13, NULL, '192.168.11.1', NULL);
INSERT INTO `record_like` VALUES (15, 11, NULL, '192.168.37.1', NULL);
INSERT INTO `record_like` VALUES (16, 11, NULL, '192.168.77.1', NULL);

-- ----------------------------
-- Table structure for record_tag
-- ----------------------------
DROP TABLE IF EXISTS `record_tag`;
CREATE TABLE `record_tag`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名称',
  `use_count` int(0) NULL DEFAULT 0 COMMENT '使用次数（热门排序用）',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#409EFF',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `idx_use_count`(`use_count`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '标签表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record_tag
-- ----------------------------
INSERT INTO `record_tag` VALUES (1, 'Vue', 17, '2025-11-27 12:04:11', '#E6A23C');
INSERT INTO `record_tag` VALUES (2, 'Spring Boot', 14, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (3, 'MySQL', 6, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (4, '旅行攻略', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (5, '读书笔记', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (6, '美食探店', 7, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (7, 'Docker', 6, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (8, '生活随想', 3, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (9, 'JavaScript', 10, '2025-11-27 12:04:11', '#67C23A');
INSERT INTO `record_tag` VALUES (10, 'Java', 8, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (11, '前端', 9, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (12, '后端', 6, '2025-11-27 12:19:11', '#409EFF');
INSERT INTO `record_tag` VALUES (13, 'AI', 1, '2026-01-28 18:04:40', '#409EFF');

-- ----------------------------
-- Table structure for record_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `record_tag_relation`;
CREATE TABLE `record_tag_relation`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `record_id` bigint(0) NOT NULL COMMENT '记录ID',
  `tag_id` bigint(0) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_record_tag`(`record_id`, `tag_id`) USING BTREE,
  INDEX `idx_record_id`(`record_id`) USING BTREE,
  INDEX `idx_tag_id`(`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录-标签关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record_tag_relation
-- ----------------------------
INSERT INTO `record_tag_relation` VALUES (9, 5, 6);
INSERT INTO `record_tag_relation` VALUES (35, 11, 2);
INSERT INTO `record_tag_relation` VALUES (26, 12, 10);
INSERT INTO `record_tag_relation` VALUES (33, 13, 7);
INSERT INTO `record_tag_relation` VALUES (34, 14, 1);
INSERT INTO `record_tag_relation` VALUES (36, 15, 1);
INSERT INTO `record_tag_relation` VALUES (37, 15, 2);
INSERT INTO `record_tag_relation` VALUES (38, 15, 13);

-- ----------------------------
-- Table structure for sensitive_word
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_word`;
CREATE TABLE `sensitive_word`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `word` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '敏感词',
  `replacement` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '***' COMMENT '替换文本',
  `enabled` tinyint(0) NULL DEFAULT 1 COMMENT '是否启用：0-禁用 1-启用',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 888 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensitive_word
-- ----------------------------
INSERT INTO `sensitive_word` VALUES (584, '爱液', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (585, '按摩棒', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (586, '拔出来', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:27:54');
INSERT INTO `sensitive_word` VALUES (587, '爆草', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (588, '包二奶', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (589, '暴干', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (590, '暴奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (591, '暴乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (592, '爆乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (593, '暴淫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (594, '被操', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (595, '被插', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (596, '被干', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (597, '逼奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (598, '仓井空', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (599, '插暴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (600, '操逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (601, '操黑', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (602, '操烂', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (603, '肏你', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (604, '肏死', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (605, '操死', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (606, '操我', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (607, '厕奴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (608, '插比', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (609, '插b', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (610, '插逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (611, '插进', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (612, '插你', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (613, '插我', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (614, '插阴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (615, '潮吹', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (616, '潮喷', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (617, '成人电影', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (618, '成人论坛', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (619, '成人色情', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (620, '成人网站', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (621, '成人文学', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (622, '成人小说', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (623, '艳情小说', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (624, '成人游戏', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (625, '吃精', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (626, '抽插', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (627, '春药', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (628, '大波', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (629, '大力抽送', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (630, '大乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (631, '荡妇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (632, '荡女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (633, '盗撮', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (634, '发浪', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (635, '放尿', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (636, '肥逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (637, '粉穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (638, '风月大陆', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (639, '干死你', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (640, '干穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (641, '肛交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (642, '肛门', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (643, '龟头', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (644, '裹本', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (645, '国产av', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (646, '好嫩', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (647, '豪乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (648, '黑逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (649, '后庭', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (650, '后穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (651, '虎骑', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (652, '换妻俱乐部', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (653, '黄片', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (654, '几吧', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (655, '鸡吧', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (656, '鸡巴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (657, '鸡奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (658, '妓女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (659, '奸情', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (660, '叫床', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (661, '脚交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (662, '精液', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (663, '就去日', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (664, '巨屌', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (665, '菊花洞', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (666, '菊门', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (667, '巨奶', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (668, '巨乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (669, '菊穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (670, '开苞', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (671, '口爆', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (672, '口活', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (673, '口交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (674, '口射', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (675, '口淫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (676, '裤袜', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (677, '狂操', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (678, '狂插', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (679, '浪逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (680, '浪妇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (681, '浪叫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (682, '浪女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (683, '狼友', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (684, '聊性', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (685, '凌辱', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (686, '漏乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (687, '露b', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (688, '乱交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (689, '乱伦', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (690, '轮暴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (691, '轮操', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (692, '轮奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (693, '裸陪', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (694, '买春', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (695, '美逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (696, '美少妇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (697, '美乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (698, '美腿', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (699, '美穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (700, '美幼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (701, '秘唇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (702, '迷奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (703, '密穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (704, '蜜穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (705, '蜜液', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (706, '摸奶', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (707, '摸胸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (708, '母奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (709, '奈美', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (710, '奶子', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (711, '男奴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (712, '内射', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (713, '嫩逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (714, '嫩女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (715, '嫩穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (716, '捏弄', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (717, '女优', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (718, '炮友', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (719, '砲友', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (720, '喷精', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (721, '屁眼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (722, '前凸后翘', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (723, '强jian', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (724, '强暴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (725, '强奸处女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (726, '情趣用品', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (727, '情色', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (728, '拳交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (729, '全裸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (730, '群交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (731, '人妻', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (732, '人兽', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (733, '日逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (734, '日烂', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (735, '肉棒', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (736, '肉逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (737, '肉唇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (738, '肉洞', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (739, '肉缝', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (740, '肉棍', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (741, '肉茎', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (742, '肉具', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (743, '揉乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (744, '肉穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (745, '肉欲', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (746, '乳爆', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (747, '乳房', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (748, '乳沟', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (749, '乳交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (750, '乳头', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (751, '骚逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (752, '骚比', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (753, '骚女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (754, '骚水', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (755, '骚穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (756, '色逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (757, '色界', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (758, '色猫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (759, '色盟', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (760, '色情网站', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (761, '色区', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (762, '色色', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (763, '色诱', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (764, '色欲', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (765, '色b', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (766, '少年阿宾', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (767, '射爽', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (768, '射颜', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (769, '食精', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (770, '释欲', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (771, '兽奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (772, '兽交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (773, '手淫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (774, '兽欲', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (775, '熟妇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (776, '熟母', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (777, '熟女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (778, '爽片', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (779, '双臀', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (780, '死逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (781, '丝袜', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (782, '丝诱', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (783, '松岛枫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (784, '酥痒', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (785, '汤加丽', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (786, '套弄', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (787, '体奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (788, '体位', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (789, '舔脚', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (790, '舔阴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (791, '调教', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (792, '偷欢', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (793, '推油', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (794, '脱内裤', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (795, '文做', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (796, '舞女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (797, '无修正', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (798, '吸精', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (799, '夏川纯', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (800, '相奸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (801, '小逼', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (802, '校鸡', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (803, '小穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (804, '小xue', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (805, '性感妖娆', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (806, '性感诱惑', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (807, '性虎', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (808, '性饥渴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (809, '性技巧', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (810, '性交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (811, '性奴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (812, '性虐', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (813, '性息', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (814, '性欲', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (815, '胸推', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (816, '穴口', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (817, '穴图', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (818, '亚情', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (819, '颜射', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (820, '阳具', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (821, '杨思敏', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (822, '要射了', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (823, '夜勤病栋', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (824, '一本道', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (825, '一夜欢', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (826, '一夜情', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (827, '一ye情', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (828, '阴部', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (829, '淫虫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (830, '阴唇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (831, '淫荡', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (832, '阴道', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (833, '淫电影', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (834, '阴阜', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (835, '淫妇', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (836, '淫河', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (837, '阴核', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (838, '阴户', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (839, '淫贱', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (840, '淫叫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (841, '淫教师', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (842, '阴茎', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (843, '阴精', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (844, '淫浪', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (845, '淫媚', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (846, '淫糜', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (847, '淫魔', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (848, '淫母', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (849, '淫女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (850, '淫虐', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (851, '淫妻', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (852, '淫情', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (853, '淫色', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (854, '淫声浪语', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (855, '淫兽学园', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (856, '淫书', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (857, '淫术炼金士', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (858, '淫水', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (859, '淫娃', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (860, '淫威', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (861, '淫亵', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (862, '淫样', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (863, '淫液', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (864, '淫照', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (865, '阴b', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (866, '应召', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (867, '幼交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (868, '欲火', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (869, '欲女', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (870, '玉乳', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (871, '玉穴', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (872, '援交', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (873, '原味内衣', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (874, '援助交际', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (875, '招鸡', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (876, '招妓', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (877, '抓胸', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (878, '自慰', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (879, '作爱', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (880, 'a片', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (881, 'fuck', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (882, 'gay片', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (883, 'g点', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (884, 'h动画', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (885, 'h动漫', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (886, '失身粉', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');
INSERT INTO `sensitive_word` VALUES (887, '淫荡自慰器', '***', 1, '2025-12-30 18:21:31', '2025-12-30 18:21:31');

-- ----------------------------
-- Table structure for site_visit
-- ----------------------------
DROP TABLE IF EXISTS `site_visit`;
CREATE TABLE `site_visit`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `visit_date` date NOT NULL COMMENT '访问日期',
  `visit_count` int(0) NOT NULL DEFAULT 0 COMMENT '当日访问次数',
  `created_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_visit_date`(`visit_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '网站访问统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of site_visit
-- ----------------------------
INSERT INTO `site_visit` VALUES (1, '2025-11-29', 3, '2025-11-29 13:06:39', '2025-11-29 13:55:18');
INSERT INTO `site_visit` VALUES (2, '2025-11-30', 1, '2025-11-30 10:14:03', '2025-11-30 10:14:03');
INSERT INTO `site_visit` VALUES (3, '2025-12-01', 28, '2025-12-01 02:24:57', '2025-12-01 11:47:04');
INSERT INTO `site_visit` VALUES (4, '2025-12-02', 13, '2025-12-02 01:23:44', '2025-12-02 14:36:15');
INSERT INTO `site_visit` VALUES (5, '2025-12-03', 2, '2025-12-03 02:19:05', '2025-12-03 06:12:16');
INSERT INTO `site_visit` VALUES (6, '2025-12-04', 10, '2025-12-04 01:43:18', '2025-12-04 10:20:17');
INSERT INTO `site_visit` VALUES (7, '2025-12-05', 3, '2025-12-04 18:02:36', '2025-12-05 03:46:33');
INSERT INTO `site_visit` VALUES (8, '2025-12-06', 3, '2025-12-06 10:19:58', '2025-12-06 11:42:04');
INSERT INTO `site_visit` VALUES (9, '2025-12-07', 1, '2025-12-07 02:16:54', '2025-12-07 02:16:54');
INSERT INTO `site_visit` VALUES (10, '2025-12-08', 2, '2025-12-08 02:06:37', '2025-12-08 05:47:15');
INSERT INTO `site_visit` VALUES (11, '2025-12-12', 1, '2025-12-12 02:27:09', '2025-12-12 02:27:09');
INSERT INTO `site_visit` VALUES (12, '2025-12-15', 1, '2025-12-15 07:32:37', '2025-12-15 07:32:37');
INSERT INTO `site_visit` VALUES (13, '2025-12-27', 1, '2025-12-27 10:13:07', '2025-12-27 10:13:07');
INSERT INTO `site_visit` VALUES (14, '2025-12-29', 3, '2025-12-29 06:51:06', '2025-12-29 09:10:39');
INSERT INTO `site_visit` VALUES (15, '2025-12-30', 3, '2025-12-30 05:00:56', '2025-12-30 09:27:24');
INSERT INTO `site_visit` VALUES (16, '2025-12-31', 1, '2025-12-31 08:20:55', '2025-12-31 08:20:55');
INSERT INTO `site_visit` VALUES (17, '2026-01-03', 1, '2026-01-03 08:53:26', '2026-01-03 08:53:26');
INSERT INTO `site_visit` VALUES (18, '2026-01-07', 4, '2026-01-07 09:51:43', '2026-01-07 09:58:25');
INSERT INTO `site_visit` VALUES (19, '2026-01-08', 1, '2026-01-08 05:58:17', '2026-01-08 05:58:17');
INSERT INTO `site_visit` VALUES (20, '2026-01-15', 1, '2026-01-15 03:12:58', '2026-01-15 03:12:58');
INSERT INTO `site_visit` VALUES (21, '2026-01-16', 1, '2026-01-16 05:06:11', '2026-01-16 05:06:11');
INSERT INTO `site_visit` VALUES (22, '2026-01-21', 2, '2026-01-21 09:17:31', '2026-01-21 10:12:29');
INSERT INTO `site_visit` VALUES (23, '2026-01-28', 1, '2026-01-28 10:05:55', '2026-01-28 10:05:55');

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置键',
  `config_value` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置值',
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `updated_at` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `config_key`(`config_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'sensitive_word_strategy', 'replace', '敏感词策略：replace-替换 block-禁止', '2025-12-30 18:08:50');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码（MD5加密）',
  `gender` tinyint(0) NULL DEFAULT 0 COMMENT '性别：0-未知，1-男，2-女',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像URL',
  `bio` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人简介',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `exp` int(0) NULL DEFAULT 0 COMMENT '经验值',
  `level_id` int(0) NOT NULL DEFAULT 1 COMMENT '等级ID，关联level表',
  `role` tinyint(0) NOT NULL DEFAULT 0 COMMENT '角色：0-普通用户，1-管理员',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE,
  UNIQUE INDEX `uk_email`(`email`) USING BTREE,
  INDEX `fk_user_level`(`level_id`) USING BTREE,
  CONSTRAINT `fk_user_level` FOREIGN KEY (`level_id`) REFERENCES `level` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Dawn', '3095882640@qq.com', '4b4baedff8691e5b9a01275beab4de0e', 1, '/uploads/avatars/425f6341-9113-48ab-adda-770722dc2f08.webp', '时光不语，却回答了所有问题', '2025-11-26 14:54:01', '2026-01-21 17:18:04', 1050, 5, 1);
INSERT INTO `user` VALUES (8, '用户582039', '19839433499@163.com', '4b4baedff8691e5b9a01275beab4de0e', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=用户582039', '', '2025-11-27 14:23:02', '2025-12-01 09:57:02', 10, 1, 0);
INSERT INTO `user` VALUES (9, '123', '19839433499A@2925.com', '4b4baedff8691e5b9a01275beab4de0e', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=123', '', '2025-12-02 07:20:03', '2025-12-02 07:20:03', 0, 1, 0);
INSERT INTO `user` VALUES (10, '用户756683', '865583553@qq.com', 'fba293904842f525f261dbd0a556cdc4', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=用户756683', '', '2025-12-04 03:42:37', '2025-12-04 03:42:37', 0, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
