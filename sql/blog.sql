/*
 Navicat Premium Data Transfer

 Source Server         : work
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 04/12/2025 11:03:40
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '浏览记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of browse_log
-- ----------------------------
INSERT INTO `browse_log` VALUES (9, '127.0.0.1', 'http://localhost:8888/', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'http://localhost:8888', '2025-12-04 11:02:15');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '签到记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in
-- ----------------------------
INSERT INTO `check_in` VALUES (2, 1, '2025-11-29', 10, 1, '2025-11-29 12:03:39');
INSERT INTO `check_in` VALUES (3, 2, '2025-11-29', 10, 1, '2025-11-29 12:09:22');
INSERT INTO `check_in` VALUES (4, 2, '2025-11-30', 15, 2, '2025-11-30 10:14:18');
INSERT INTO `check_in` VALUES (5, 1, '2025-11-30', 15, 2, '2025-11-30 13:27:41');
INSERT INTO `check_in` VALUES (6, 1, '2025-12-01', 20, 3, '2025-12-01 14:56:31');
INSERT INTO `check_in` VALUES (7, 1, '2025-12-04', 10, 1, '2025-12-04 10:53:16');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '随笔表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of essay
-- ----------------------------
INSERT INTO `essay` VALUES (1, 1, '🌟送大家一片星空🌟\n\n☀️ ☁️ 🌍 • 🌈 🌙 • ⬛⬛⬛ 🚀 ☆☆ ★\n\n✨ · · · · · ★ · ▁▂▃▄▅▆▇██▇▆▅▄▃▂▁ · ★', NULL, NULL, 6, '2025-10-17 10:30:00', '2025-11-29 11:18:18');
INSERT INTO `essay` VALUES (2, 1, '有点过于无敌了...', 'https://picsum.photos/400/200?random=1', NULL, 4, '2025-04-20 15:20:00', '2025-11-29 11:18:19');
INSERT INTO `essay` VALUES (3, 1, '杀神，回来了。', 'https://picsum.photos/400/250?random=2', NULL, 5, '2025-04-13 09:00:00', '2025-11-29 11:18:19');
INSERT INTO `essay` VALUES (5, 1, '这是一条测试内容', '/uploads/essays/86ce1be4-63bc-40ed-a7ed-6a76f3d595db.png', '/uploads/essays/videos/5d193428-caf3-44b9-806a-4c55cd2815bd.mp4', 0, '2025-11-30 11:25:23', '2025-11-30 11:25:23');
INSERT INTO `essay` VALUES (6, 1, '123', '/uploads/essays/5b9ca3c8-b1da-4b0b-ac00-b9c92ae7a549.jpg', NULL, 0, '2025-11-30 11:25:52', '2025-11-30 11:25:52');

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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '随笔评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of essay_comment
-- ----------------------------
INSERT INTO `essay_comment` VALUES (2, 3, 7, 0, NULL, '好漂亮的博客', NULL, '2025-06-07 10:05:00');
INSERT INTO `essay_comment` VALUES (3, 3, 3, 0, NULL, '大佬带带我', NULL, '2025-05-14 16:30:00');
INSERT INTO `essay_comment` VALUES (4, 3, 4, 3, NULL, '带带弟弟', NULL, '2025-05-26 11:00:00');
INSERT INTO `essay_comment` VALUES (5, 3, 4, 3, 4, '想学习啊', NULL, '2025-05-26 11:05:00');
INSERT INTO `essay_comment` VALUES (10, 1, 1, 0, NULL, '😂', NULL, '2025-11-26 16:14:45');
INSERT INTO `essay_comment` VALUES (12, 2, 1, 0, NULL, NULL, 'http://localhost:9999/uploads/essays/568ab33e-51e0-4707-8dfe-eecd9c0b6f11.jpg', '2025-11-26 16:20:59');
INSERT INTO `essay_comment` VALUES (13, 2, 1, 0, NULL, '', 'http://localhost:9999/uploads/essays/3bbfe830-a9de-4bb1-abe2-841720e51049.png', '2025-11-26 16:21:46');
INSERT INTO `essay_comment` VALUES (14, 1, 1, 0, NULL, NULL, 'http://localhost:9999/uploads/essays/20ba1d5e-d56c-41c6-b0f8-9c0a9d773cdf.jpg', '2025-11-26 16:25:27');
INSERT INTO `essay_comment` VALUES (15, 2, 1, 0, NULL, '123', NULL, '2025-11-26 16:25:38');
INSERT INTO `essay_comment` VALUES (16, 3, 1, 0, NULL, '666', NULL, '2025-11-26 16:25:52');
INSERT INTO `essay_comment` VALUES (19, 1, 1, 0, NULL, '1', NULL, '2025-11-26 17:34:03');
INSERT INTO `essay_comment` VALUES (21, 1, 1, 0, NULL, '1111', NULL, '2025-11-27 10:33:24');
INSERT INTO `essay_comment` VALUES (22, 1, 1, 0, NULL, '1111', NULL, '2025-11-27 10:33:26');
INSERT INTO `essay_comment` VALUES (23, 1, 1, 0, NULL, '99987', NULL, '2025-11-27 10:34:13');
INSERT INTO `essay_comment` VALUES (25, 2, 1, 0, NULL, '沙发上打撒发上发啊发', NULL, '2025-11-28 12:20:10');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '等级配置表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 206 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 0, '13', NULL, 0, '2025-11-26 18:20:38');
INSERT INTO `message` VALUES (2, 1, 0, '66666', NULL, 0, '2025-11-26 18:22:01');
INSERT INTO `message` VALUES (3, 1, 1, '123', NULL, 0, '2025-11-26 18:24:05');
INSERT INTO `message` VALUES (4, 1, 1, '😁😂', NULL, 0, '2025-11-26 18:24:08');
INSERT INTO `message` VALUES (5, 1, 0, '5555', NULL, 0, '2025-11-26 18:24:34');
INSERT INTO `message` VALUES (6, 1, 0, '4444', NULL, 1, '2025-11-26 18:24:39');
INSERT INTO `message` VALUES (7, 1, 1, '', 'http://localhost:9999/uploads/essays/618743ac-1e35-4a07-aea5-41205d9341eb.jpg', 0, '2025-11-26 18:26:06');
INSERT INTO `message` VALUES (8, 1, 0, '好看！', NULL, 12, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (9, 2, 0, '大佬太厉害了', NULL, 8, '2025-11-12 18:26:28');
INSERT INTO `message` VALUES (10, 1, 0, '学习了', NULL, 5, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (11, 3, 0, '666666', NULL, 66, '2025-11-01 18:26:28');
INSERT INTO `message` VALUES (12, 2, 0, '太帅了', NULL, 15, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (13, 1, 0, '牛逼！', NULL, 31, '2025-10-28 18:26:28');
INSERT INTO `message` VALUES (14, 3, 0, '加油！奥力给！', NULL, 19, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (15, 2, 0, '前排围观', NULL, 23, '2025-11-03 18:26:28');
INSERT INTO `message` VALUES (16, 1, 0, '打卡', NULL, 7, '2025-11-23 18:26:28');
INSERT INTO `message` VALUES (17, 3, 0, '支持一下', NULL, 14, '2025-11-22 18:26:28');
INSERT INTO `message` VALUES (18, 2, 0, '写得真好', NULL, 28, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (19, 1, 0, '收藏了', NULL, 9, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (20, 3, 0, '感谢分享', NULL, 17, '2025-11-24 18:26:28');
INSERT INTO `message` VALUES (21, 2, 0, '涨知识了', NULL, 21, '2025-11-15 18:26:28');
INSERT INTO `message` VALUES (22, 1, 0, '厉害厉害', NULL, 11, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (23, 3, 0, '博主加油', NULL, 33, '2025-11-15 18:26:28');
INSERT INTO `message` VALUES (24, 2, 0, '优秀！', NULL, 25, '2025-11-02 18:26:28');
INSERT INTO `message` VALUES (25, 1, 0, '每日打卡', NULL, 6, '2025-10-31 18:26:28');
INSERT INTO `message` VALUES (26, 3, 0, '太强了吧', NULL, 42, '2025-11-25 18:26:28');
INSERT INTO `message` VALUES (27, 2, 0, '真不错', NULL, 18, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (28, 1, 0, '路过留名', NULL, 4, '2025-11-04 18:26:28');
INSERT INTO `message` VALUES (29, 3, 0, '干货满满', NULL, 37, '2025-10-28 18:26:28');
INSERT INTO `message` VALUES (30, 2, 0, '顶顶顶', NULL, 16, '2025-11-07 18:26:28');
INSERT INTO `message` VALUES (31, 1, 0, '学到了', NULL, 22, '2025-11-18 18:26:28');
INSERT INTO `message` VALUES (32, 3, 0, '太棒了！', NULL, 29, '2025-11-10 18:26:28');
INSERT INTO `message` VALUES (33, 2, 0, '马克一下', NULL, 8, '2025-11-01 18:26:28');
INSERT INTO `message` VALUES (34, 1, 0, '受益匪浅', NULL, 35, '2025-11-10 18:26:28');
INSERT INTO `message` VALUES (35, 3, 0, '赞赞赞', NULL, 44, '2025-11-19 18:26:28');
INSERT INTO `message` VALUES (36, 2, 0, '期待更新', NULL, 13, '2025-11-07 18:26:28');
INSERT INTO `message` VALUES (37, 1, 0, '追更中', NULL, 7, '2025-11-13 18:26:28');
INSERT INTO `message` VALUES (38, 3, 0, '催更催更', NULL, 26, '2025-11-19 18:26:28');
INSERT INTO `message` VALUES (39, 2, 0, '好文章', NULL, 31, '2025-10-31 18:26:28');
INSERT INTO `message` VALUES (40, 1, 0, '点赞收藏', NULL, 19, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (41, 3, 0, '已关注', NULL, 24, '2025-11-02 18:26:28');
INSERT INTO `message` VALUES (42, 2, 0, '真心不错', NULL, 15, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (43, 1, 0, '佩服佩服', NULL, 38, '2025-11-18 18:26:28');
INSERT INTO `message` VALUES (44, 3, 0, '技术大牛', NULL, 47, '2025-11-07 18:26:28');
INSERT INTO `message` VALUES (45, 2, 0, '膜拜大佬', NULL, 52, '2025-11-15 18:26:28');
INSERT INTO `message` VALUES (46, 1, 0, '向大佬学习', NULL, 28, '2025-10-28 18:26:28');
INSERT INTO `message` VALUES (47, 3, 0, '太有用了', NULL, 33, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (48, 2, 0, '必须点赞', NULL, 41, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (49, 1, 0, '爱了爱了', NULL, 17, '2025-11-20 18:26:28');
INSERT INTO `message` VALUES (50, 3, 0, '神仙博客', NULL, 59, '2025-11-25 18:26:28');
INSERT INTO `message` VALUES (51, 2, 0, '冲冲冲', NULL, 12, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (52, 1, 0, '每天进步', NULL, 9, '2025-11-04 18:26:28');
INSERT INTO `message` VALUES (53, 3, 0, '坚持学习', NULL, 21, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (54, 2, 0, '持续关注', NULL, 14, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (55, 1, 0, '写得太好了', NULL, 36, '2025-11-24 18:26:28');
INSERT INTO `message` VALUES (56, 3, 0, '干货！', NULL, 27, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (57, 2, 0, '精品文章', NULL, 45, '2025-11-21 18:26:28');
INSERT INTO `message` VALUES (58, 1, 0, '通俗易懂', NULL, 32, '2025-11-02 18:26:28');
INSERT INTO `message` VALUES (59, 3, 0, '终于搞懂了', NULL, 23, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (60, 2, 0, '豁然开朗', NULL, 18, '2025-11-15 18:26:28');
INSERT INTO `message` VALUES (61, 1, 0, '一看就会', NULL, 11, '2025-11-22 18:26:28');
INSERT INTO `message` VALUES (62, 3, 0, '简单明了', NULL, 29, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (63, 2, 0, '条理清晰', NULL, 34, '2025-10-28 18:26:28');
INSERT INTO `message` VALUES (64, 1, 0, '逻辑清楚', NULL, 16, '2025-11-03 18:26:28');
INSERT INTO `message` VALUES (65, 3, 0, '讲得真好', NULL, 43, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (66, 2, 0, '受教了', NULL, 22, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (67, 1, 0, '感谢博主', NULL, 37, '2025-11-20 18:26:28');
INSERT INTO `message` VALUES (68, 3, 0, '辛苦了', NULL, 19, '2025-11-02 18:26:28');
INSERT INTO `message` VALUES (69, 2, 0, '好人一生平安', NULL, 48, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (70, 1, 0, '祝博主发财', NULL, 25, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (71, 3, 0, '越来越好', NULL, 31, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (72, 2, 0, '继续加油', NULL, 20, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (73, 1, 0, '一起努力', NULL, 13, '2025-11-22 18:26:28');
INSERT INTO `message` VALUES (74, 3, 0, '共同进步', NULL, 26, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (75, 2, 0, '相互学习', NULL, 15, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (76, 1, 0, '互相鼓励', NULL, 8, '2025-11-18 18:26:28');
INSERT INTO `message` VALUES (77, 3, 0, '一路同行', NULL, 34, '2025-11-19 18:26:28');
INSERT INTO `message` VALUES (78, 2, 0, '感同身受', NULL, 27, '2025-11-15 18:26:28');
INSERT INTO `message` VALUES (79, 1, 0, '深有体会', NULL, 19, '2025-11-20 18:26:28');
INSERT INTO `message` VALUES (80, 3, 0, '说得对', NULL, 41, '2025-11-01 18:26:28');
INSERT INTO `message` VALUES (81, 2, 0, '有道理', NULL, 23, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (82, 1, 0, '同感同感', NULL, 11, '2025-11-01 18:26:28');
INSERT INTO `message` VALUES (83, 3, 0, '我也这么想', NULL, 16, '2025-11-21 18:26:28');
INSERT INTO `message` VALUES (84, 2, 0, '英雄所见', NULL, 38, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (85, 1, 0, '不谋而合', NULL, 21, '2025-11-11 18:26:28');
INSERT INTO `message` VALUES (86, 3, 0, '心有灵犀', NULL, 29, '2025-11-18 18:26:28');
INSERT INTO `message` VALUES (87, 2, 0, '志同道合', NULL, 33, '2025-11-01 18:26:28');
INSERT INTO `message` VALUES (88, 1, 0, '妙啊', NULL, 47, '2025-11-12 18:26:28');
INSERT INTO `message` VALUES (89, 3, 0, '绝绝子', NULL, 54, '2025-10-30 18:26:28');
INSERT INTO `message` VALUES (90, 2, 0, 'yyds', NULL, 62, '2025-11-26 18:26:28');
INSERT INTO `message` VALUES (91, 1, 0, '无敌了', NULL, 35, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (92, 3, 0, '超神了', NULL, 28, '2025-11-10 18:26:28');
INSERT INTO `message` VALUES (93, 2, 0, '起飞！', NULL, 22, '2025-11-02 18:26:28');
INSERT INTO `message` VALUES (94, 1, 0, '芜湖～', NULL, 17, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (95, 3, 0, '冲就完了', NULL, 39, '2025-11-07 18:26:28');
INSERT INTO `message` VALUES (96, 2, 0, '奥利给', NULL, 44, '2025-10-28 18:26:28');
INSERT INTO `message` VALUES (97, 1, 0, '加油鸭', NULL, 14, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (98, 3, 0, '冲鸭！', NULL, 31, '2025-11-04 18:26:28');
INSERT INTO `message` VALUES (99, 2, 0, '嘎嘎强', NULL, 26, '2025-10-28 18:26:28');
INSERT INTO `message` VALUES (100, 1, 0, '真滴强', NULL, 18, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (101, 3, 0, '太顶了', NULL, 51, '2025-11-12 18:26:28');
INSERT INTO `message` VALUES (102, 2, 0, '绷不住了', NULL, 12, '2025-11-18 18:26:28');
INSERT INTO `message` VALUES (103, 1, 0, '笑死我了', NULL, 9, '2025-11-25 18:26:28');
INSERT INTO `message` VALUES (104, 3, 0, '有被笑到', NULL, 24, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (105, 2, 0, '欢乐多多', NULL, 16, '2025-11-11 18:26:28');
INSERT INTO `message` VALUES (106, 1, 0, '开心每一天', NULL, 21, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (107, 3, 0, '好运连连', NULL, 37, '2025-11-13 18:26:28');
INSERT INTO `message` VALUES (108, 1, 1, '博主的文章写得太好了，学到了很多东西，感谢分享！', NULL, 0, '2025-11-01 18:26:28');
INSERT INTO `message` VALUES (109, 2, 1, '终于找到一个讲得这么清楚的博客了，收藏了！', NULL, 0, '2025-10-11 18:26:28');
INSERT INTO `message` VALUES (110, 3, 1, '请问博主，这个功能怎么实现的呀？能详细讲讲吗？', NULL, 0, '2025-10-20 18:26:28');
INSERT INTO `message` VALUES (111, 1, 1, '我也遇到了同样的问题，看了这篇文章终于解决了', NULL, 0, '2025-10-09 18:26:28');
INSERT INTO `message` VALUES (112, 2, 1, '干货满满，建议博主多更新一些这样的内容', NULL, 0, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (113, 3, 1, '博主能出个视频教程吗？文字版有些地方不太理解', NULL, 0, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (114, 1, 1, '太棒了！已经按照教程做出来了，感谢！', NULL, 0, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (115, 2, 1, '这个博客的UI做得真漂亮，博主自己设计的吗？', NULL, 0, '2025-10-18 18:26:28');
INSERT INTO `message` VALUES (116, 3, 1, '请问用的什么技术栈？想学习一下', NULL, 0, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (117, 1, 1, '每天都来看看有没有更新，博主加油！', NULL, 0, '2025-11-21 18:26:28');
INSERT INTO `message` VALUES (118, 2, 1, '从这个博客学到了很多，希望博主能坚持写下去', NULL, 0, '2025-10-09 18:26:28');
INSERT INTO `message` VALUES (119, 3, 1, '有个小建议，能不能加个夜间模式？', NULL, 0, '2025-10-11 18:26:28');
INSERT INTO `message` VALUES (120, 1, 1, '博主写得太详细了，连小白都能看懂', NULL, 0, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (121, 2, 1, '这种分享精神值得学习，向博主致敬！', NULL, 0, '2025-11-24 18:26:28');
INSERT INTO `message` VALUES (122, 3, 1, '请问博主是做什么工作的？技术这么厉害', NULL, 0, '2025-10-12 18:26:28');
INSERT INTO `message` VALUES (123, 1, 1, '终于等到更新了，开心！', NULL, 0, '2025-10-16 18:26:28');
INSERT INTO `message` VALUES (124, 2, 1, '这个弹幕功能太有意思了，第一次见', NULL, 0, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (125, 3, 1, '我来打卡啦～每天坚持学习', NULL, 0, '2025-10-14 18:26:28');
INSERT INTO `message` VALUES (126, 1, 1, '博主可以考虑开个公众号，方便追更', NULL, 0, '2025-11-16 18:26:28');
INSERT INTO `message` VALUES (127, 2, 1, '有没有交流群呀？想和大家一起讨论', NULL, 0, '2025-10-15 18:26:28');
INSERT INTO `message` VALUES (128, 3, 1, '这个字体选得真好看，是什么字体？', NULL, 0, '2025-11-26 18:26:28');
INSERT INTO `message` VALUES (129, 1, 1, '霞鹜文楷！我也去用这个字体了', NULL, 0, '2025-10-02 18:26:28');
INSERT INTO `message` VALUES (130, 2, 1, '博主的审美真的在线，页面很舒服', NULL, 0, '2025-10-22 18:26:28');
INSERT INTO `message` VALUES (131, 3, 1, '能开源吗？想学习一下代码', NULL, 0, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (132, 1, 1, '支持开源！+1', NULL, 0, '2025-11-23 18:26:28');
INSERT INTO `message` VALUES (133, 2, 1, '我也想学着做一个自己的博客', NULL, 0, '2025-10-12 18:26:28');
INSERT INTO `message` VALUES (134, 3, 1, '入门指南有吗？想从零开始学', NULL, 0, '2025-10-17 18:26:28');
INSERT INTO `message` VALUES (135, 1, 1, '前端用的Vue吗？感觉很流畅', NULL, 0, '2025-11-23 18:26:28');
INSERT INTO `message` VALUES (136, 2, 1, '后端是Spring Boot吧？猜对了吗', NULL, 0, '2025-11-08 18:26:28');
INSERT INTO `message` VALUES (137, 3, 1, '数据库用的MySQL还是PostgreSQL？', NULL, 0, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (138, 1, 1, '这个动画效果怎么做的？好丝滑', NULL, 0, '2025-10-07 18:26:28');
INSERT INTO `message` VALUES (139, 2, 1, '背景图好好看，是在哪里找的？', NULL, 0, '2025-11-16 18:26:28');
INSERT INTO `message` VALUES (140, 3, 1, 'wallhaven上面有很多好看的壁纸', NULL, 0, '2025-11-06 18:26:28');
INSERT INTO `message` VALUES (141, 1, 1, '原来如此，谢谢分享！', NULL, 0, '2025-11-16 18:26:28');
INSERT INTO `message` VALUES (142, 2, 1, '我也收藏了好多壁纸网站', NULL, 0, '2025-10-05 18:26:28');
INSERT INTO `message` VALUES (143, 3, 1, '博主下次能分享一下常用的网站吗', NULL, 0, '2025-10-09 18:26:28');
INSERT INTO `message` VALUES (144, 1, 1, '好的建议，我也想知道', NULL, 0, '2025-10-30 18:26:28');
INSERT INTO `message` VALUES (145, 2, 1, '评论区也是人才济济啊', NULL, 0, '2025-10-07 18:26:28');
INSERT INTO `message` VALUES (146, 3, 1, '哈哈哈，大家都很热情', NULL, 0, '2025-10-07 18:26:28');
INSERT INTO `message` VALUES (147, 1, 1, '这个社区氛围真好', NULL, 0, '2025-10-17 18:26:28');
INSERT INTO `message` VALUES (148, 2, 1, '继续保持！一起进步', NULL, 0, '2025-10-07 18:26:28');
INSERT INTO `message` VALUES (149, 3, 1, '今天也是元气满满的一天', NULL, 0, '2025-11-14 18:26:28');
INSERT INTO `message` VALUES (150, 1, 1, '加油！我们都是追梦人', NULL, 0, '2025-10-26 18:26:28');
INSERT INTO `message` VALUES (151, 2, 1, '正能量满满！', NULL, 0, '2025-11-26 18:26:28');
INSERT INTO `message` VALUES (152, 3, 1, '新的一天，新的开始', NULL, 0, '2025-10-31 18:26:28');
INSERT INTO `message` VALUES (153, 1, 1, '博主更新频率怎么样？', NULL, 0, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (154, 2, 1, '坐等更新中...', NULL, 0, '2025-10-29 18:26:28');
INSERT INTO `message` VALUES (155, 3, 1, '催更！催更！催更！', NULL, 0, '2025-10-04 18:26:28');
INSERT INTO `message` VALUES (156, 1, 1, '不要催啦，博主也要休息的', NULL, 0, '2025-11-23 18:26:28');
INSERT INTO `message` VALUES (157, 2, 1, '理解理解，质量比数量重要', NULL, 0, '2025-10-20 18:26:28');
INSERT INTO `message` VALUES (158, 3, 1, '是的，慢工出细活', NULL, 0, '2025-09-30 18:26:28');
INSERT INTO `message` VALUES (159, 1, 1, '我宁愿等一篇好文章', NULL, 0, '2025-10-05 18:26:28');
INSERT INTO `message` VALUES (160, 2, 1, '同意楼上的观点', NULL, 0, '2025-10-25 18:26:28');
INSERT INTO `message` VALUES (161, 3, 1, '+1 +1 +1', NULL, 0, '2025-11-21 18:26:28');
INSERT INTO `message` VALUES (162, 1, 1, '这个留言板功能挺有趣的', NULL, 0, '2025-10-09 18:26:28');
INSERT INTO `message` VALUES (163, 2, 1, '可以发弹幕真的太酷了', NULL, 0, '2025-10-12 18:26:28');
INSERT INTO `message` VALUES (164, 3, 1, '第一次见到这种设计', NULL, 0, '2025-11-05 18:26:28');
INSERT INTO `message` VALUES (165, 1, 1, '创意满分！', NULL, 0, '2025-10-25 18:26:28');
INSERT INTO `message` VALUES (166, 2, 1, '博主真有想法', NULL, 0, '2025-10-20 18:26:28');
INSERT INTO `message` VALUES (167, 3, 1, '这个交互设计很棒', NULL, 0, '2025-10-26 18:26:28');
INSERT INTO `message` VALUES (168, 1, 1, 'UX做得很好，体验很流畅', NULL, 0, '2025-10-12 18:26:28');
INSERT INTO `message` VALUES (169, 2, 1, '移动端适配也很完美', NULL, 0, '2025-11-15 18:26:28');
INSERT INTO `message` VALUES (170, 3, 1, '手机上看也很舒服', NULL, 0, '2025-10-17 18:26:28');
INSERT INTO `message` VALUES (171, 1, 1, '响应式做得不错', NULL, 0, '2025-10-09 18:26:28');
INSERT INTO `message` VALUES (172, 2, 1, '我在iPad上看的，完美', NULL, 0, '2025-11-25 18:26:28');
INSERT INTO `message` VALUES (173, 3, 1, '各种设备都测试过了吧', NULL, 0, '2025-10-15 18:26:28');
INSERT INTO `message` VALUES (174, 1, 1, '博主真用心', NULL, 0, '2025-10-30 18:26:28');
INSERT INTO `message` VALUES (175, 2, 1, '细节决定成败', NULL, 0, '2025-11-17 18:26:28');
INSERT INTO `message` VALUES (176, 3, 1, '从细节看得出来很用心', NULL, 0, '2025-10-31 18:26:28');
INSERT INTO `message` VALUES (177, 1, 1, '优秀的人都是这样的', NULL, 0, '2025-10-15 18:26:28');
INSERT INTO `message` VALUES (178, 2, 1, '向优秀的人学习', NULL, 0, '2025-11-13 18:26:28');
INSERT INTO `message` VALUES (179, 3, 1, '一起变得更优秀', NULL, 0, '2025-11-26 18:26:28');
INSERT INTO `message` VALUES (180, 1, 1, '共同成长！', NULL, 0, '2025-11-04 18:26:28');
INSERT INTO `message` VALUES (181, 2, 1, '这就是学习的力量', NULL, 0, '2025-10-06 18:26:28');
INSERT INTO `message` VALUES (182, 3, 1, '知识改变命运', NULL, 0, '2025-11-16 18:26:28');
INSERT INTO `message` VALUES (183, 1, 1, '技术改变生活', NULL, 0, '2025-11-10 18:26:28');
INSERT INTO `message` VALUES (184, 2, 1, '编程使我快乐', NULL, 0, '2025-10-06 18:26:28');
INSERT INTO `message` VALUES (185, 3, 1, '代码就是诗', NULL, 0, '2025-10-31 18:26:28');
INSERT INTO `message` VALUES (186, 1, 1, '程序员的浪漫', NULL, 0, '2025-10-18 18:26:28');
INSERT INTO `message` VALUES (187, 2, 1, '用代码创造世界', NULL, 0, '2025-10-02 18:26:28');
INSERT INTO `message` VALUES (188, 3, 1, '每一行代码都是艺术', NULL, 0, '2025-10-16 18:26:28');
INSERT INTO `message` VALUES (189, 1, 1, '享受编程的乐趣', NULL, 0, '2025-10-18 18:26:28');
INSERT INTO `message` VALUES (190, 2, 1, '热爱可抵岁月漫长', NULL, 0, '2025-11-11 18:26:28');
INSERT INTO `message` VALUES (191, 3, 1, '做自己喜欢的事最幸福', NULL, 0, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (192, 1, 1, '博主一定很热爱编程', NULL, 0, '2025-10-15 18:26:28');
INSERT INTO `message` VALUES (193, 2, 1, '从字里行间都能感受到', NULL, 0, '2025-10-19 18:26:28');
INSERT INTO `message` VALUES (194, 3, 1, '热情是最好的老师', NULL, 0, '2025-11-20 18:26:28');
INSERT INTO `message` VALUES (195, 1, 1, '保持这份热情！', NULL, 0, '2025-10-19 18:26:28');
INSERT INTO `message` VALUES (196, 2, 1, '永远年轻，永远热泪盈眶', NULL, 0, '2025-10-07 18:26:28');
INSERT INTO `message` VALUES (197, 3, 1, '初心不改，方得始终', NULL, 0, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (198, 1, 1, '不忘初心', NULL, 0, '2025-10-02 18:26:28');
INSERT INTO `message` VALUES (199, 2, 1, '牢记使命', NULL, 0, '2025-10-12 18:26:28');
INSERT INTO `message` VALUES (200, 3, 1, '砥砺前行', NULL, 0, '2025-11-23 18:26:28');
INSERT INTO `message` VALUES (201, 1, 1, '祝博主越来越好', NULL, 0, '2025-09-30 18:26:28');
INSERT INTO `message` VALUES (202, 2, 1, '祝博客越办越好', NULL, 0, '2025-10-20 18:26:28');
INSERT INTO `message` VALUES (203, 3, 1, '期待更多精彩内容', NULL, 0, '2025-11-09 18:26:28');
INSERT INTO `message` VALUES (204, 1, 1, '我们一直都在', NULL, 0, '2025-10-24 18:26:28');
INSERT INTO `message` VALUES (205, 2, 1, '永远支持你！', NULL, 0, '2025-10-03 18:26:28');
INSERT INTO `message` VALUES (206, 3, 1, '加油加油加油！', NULL, 0, '2025-10-05 18:26:28');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '弹幕点赞记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message_like
-- ----------------------------
INSERT INTO `message_like` VALUES (1, 6, 1, '2025-12-01 18:23:11');

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
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言回复表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '音乐表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of music
-- ----------------------------
INSERT INTO `music` VALUES (1, '多远都要在一起', '邓紫棋', '新的心跳', '/uploads/music/covers/636e687f-15a9-4526-bd53-87abfd0691bd.jpg', '/uploads/music/audio/686a6f42-40d7-46f4-bbbd-f5c9f59a9b16.mp3', 217, 1, 1, '2025-11-29 14:05:35', '2025-11-30 12:03:47');
INSERT INTO `music` VALUES (2, '尽头', '赵方婧', '', '/uploads/music/covers/912cc8fd-342e-44b9-89fc-12a851d87929.jfif', '/uploads/music/audio/9b1b92d2-07c1-4415-b8cf-83990ecd316f.mp3', 256, 2, 1, '2025-11-29 14:05:35', '2025-11-30 12:08:05');
INSERT INTO `music` VALUES (3, '知我', '国风堂', '', '/uploads/music/covers/665fd2d7-fbce-4d27-987c-42d68e71f9b1.jpg', '/uploads/music/audio/5c2b8bb7-baee-4fb2-9b85-33b16810fde8.mp3', 126, 3, 1, '2025-11-29 14:05:35', '2025-11-30 12:16:48');
INSERT INTO `music` VALUES (4, '爱错', '王力宏', '', '/uploads/music/covers/9596312f-1459-4973-82e4-12a495e6bbce.jpg', '/uploads/music/audio/f8566fd3-ff39-4aa5-936b-230eb205e87f.mp3', 238, 4, 1, '2025-11-29 14:05:35', '2025-11-30 14:27:38');
INSERT INTO `music` VALUES (6, '戒不掉', '欧阳耀莹', '', '/uploads/music/covers/98a186b9-aa49-4f20-8822-badee6608437.jpg', '/uploads/music/audio/28ff66c5-c769-4319-be14-2d0d118b6ec1.mp3', 186, 5, 1, '2025-11-30 14:30:19', '2025-11-30 14:30:28');

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 'Vue3 组合式 API 深度解析', '详细介绍 Vue3 Composition API 的使用方法，包括 setup、ref、reactive、computed 等核心概念...', '# \n\n## 1、Java多态，子类父类中类的加载顺序\n\n(1) 父类静态代码块(包括静态初始化块，静态属性，但不包括静态方法) \n\n(2) 子类静态代码块(包括静态初始化块，静态属性，但不包括静态方法  )\n\n(3) 父类非静态代码块(  包括非静态初始化块，非静态属性  )\n\n(4) 父类构造函数\n\n(5) 子类非静态代码块  (  包括非静态初始化块，非静态属性  )\n\n(6) 子类构造函数\n\n例：下面代码的输出是什么？\n\n```java\n public class Base\n    {\n        private String baseName = \"base\";\n        public Base()\n        {\n            callName();\n        }\n\n        public void callName()\n        {\n            System. out. println(baseName);\n        }\n\n        static class Sub extends Base\n        {\n            private String baseName = \"sub\";\n            public void callName()\n            {\n                System. out. println (baseName) ;\n            }\n        }\n        public static void main(String[] args)\n        {\n            Base b = new Sub();\n        }\n    }\n```\n\n答案：null\n\n## 2、JVM操作指令\n\n- **jinfo**：查看或修改JVM运行时参数（如系统属性、启动参数），不涉及内存映像。\n- **jhat**：分析已生成的堆转储文件（如.hprof），提供HTTP服务展示内存分析结果，但本身不生成内存映像。\n- **jstat**：监控JVM运行时统计信息（如GC次数、堆内存使用率），仅提供动态数据，不生成完整内存映像。\n- **jmap**：生成JVM堆转储快照（heap dump），并提供堆内存的详细信息，包括对象分布、内存使用率、垃圾收集器配置等。**适用场景**：分析内存泄漏、查看对象内存占用、诊断内存溢出问题。\n\n## 3、Map\n\nHashMap，是map的默认实现类，每个元素由 `key` 和 `value` 组成，`key` 唯一（不可重复），`value` 可重复。是无序的。允许 1 个 `null` 键和多个 `null` 值。\n\nLinkedHashMap，可保证插入 / 访问顺序。不允许 `null` 键和 `null` 值。\n\nTreeMap，有序，不允许 `null` 键（会抛 `NullPointerException`），但允许 `null` 值。\n\nHashtable，允许 `null` 键和 `null` 值。\n\n|      实现类       |        底层结构         |                           特点                           | 线程安全 |\n| :---------------: | :---------------------: | :------------------------------------------------------: | :------: |\n|      HashMap      |    数组+链表+红黑树     | 查找效率高（平均O（1）），无序，jdk1.8优化了哈希冲突处理 |    否    |\n|   LinkedHashMap   |     哈希表+双向链表     |   继承HashMap，保留插入顺序或访问顺序（可用于LRU缓存）   |    否    |\n|      TreeMap      |         红黑树          |   键按自然顺序或自定义比较器排序，查找/插入O（log n）    |    否    |\n|     Hashtable     |        数组+链表        |            古老实现，性能较差，不允许null键值            | 是(低效) |\n| ConcurrentHashMap | 分段锁 / CAS（JDK 1.8） |            线程安全，高效并发，支持多线程操作            |    是    |\n\n## 4、“先进先出”的容器是\n\n**例：“先进先出”的容器是：( )**\n\n**A、堆栈(Stack)**\n\n**B、队列（Queue）**\n\n**C、字符串(String)**\n\n**D、迭代器(Iterator)**\n\n堆栈(Stack)错误：堆栈是\"后进先出\"（LIFO）的数据结构，最后压入栈的元素会最先被弹出，这与\"先进先出\"的特性相反。\n\n字符串(String)错误：字符串是用于存储字符序列的数据类型，它并不具有\"先进先出\"的特性。字符串的访问可以是随机的，不遵循任何进出顺序。\n\n 迭代器(Iterator)错误：迭代器是一种用于遍历集合的工具，它提供了按特定顺序访问集合元素的方法，但本身并不是一个存储容器，也不具备\"先进先出\"的特性。\n\n\"先进先出\"是队列（Queue）这种数据结构的核心特征，所以B是正确答案。队列的工作原理是：第一个进入队列的元素会第一个被处理和移出，就像排队买票一样，先到的人先买票离开。\n\n## 5、Java与C++对比\n\nJava完全取消了指针的概念,这是Java相对C++的一个重要区别。Java中的引用可以理解为受限的指针,但它不允许直接进行指针运算和操作。\n\nJava的垃圾回收机制(Garbage Collection)是自动进行的,不是程序结束时才回收。当JVM发现某些对象不再被引用时,就会将其标记并在合适的时机进行回收,这个过程是动态的、持续的。\n\nJava和C++都有三个特征：封装、继承和多态。\n\n## 6、i++与++i\n\n**i++执行逻辑：**先使用变量 `i` 当前的值参与表达式运算，然后再将 `i` 的值加 1。\n\n**++i执行逻辑：**先将变量 `i` 的值加 1，然后再使用更新后的值参与表达式运算。\n\n例：下方代码的输出结果是： 			结束是：0\n\n```java\npackage algorithms.com.guan.javajicu;\npublic class Inc { \n  public static void main(String[] args) { \n    Inc inc = new Inc(); \n    int i = 0; \n    inc.fermin(i); \n    i= i ++; \n    System.out.println(i);\n  \n  } \n  void fermin(int i){ \n    i++; \n  }\n}\n```\n\n## 7、Java面向对象\n\nJava是纯面向对象语言，所有代码必须定义在类中，不存在独立的“过程”或“函数”。\n\n方法必须隶属于类或对象，不能单独存在。\n\n非静态方法属于实例成员（对象），而静态方法才属于类成员。\n\n虽然Java方法必须属于类或对象，但调用方式与C/C++不同：\n\n​	Java需通过类名（静态方法）或对象（实例方法）调用。\n\n​	C/C++允许独立调用函数或过程。\n\n## 8、\n\n\n\n', 'https://picsum.photos/400/200?random=1', 6, 1, 1322, 157, 1, '2025-11-25 10:00:00', '2025-12-01 18:24:05');
INSERT INTO `record` VALUES (2, 'Spring Boot 3.0 新特性总结', 'Spring Boot 3.0 带来了许多激动人心的新特性，包括对 Java 17 的原生支持、GraalVM 原生镜像...', '## 引言\r\n\r\nSpring Boot 3.0 是一个里程碑式的版本，带来了众多令人兴奋的新特性和改进。本文将详细介绍这些变化。\r\n\r\n![Spring Boot](https://spring.io/img/projects/spring-boot.svg)\r\n\r\n## 一、Java 17 基线\r\n\r\nSpring Boot 3.0 要求最低 **Java 17**，这意味着我们可以使用许多新特性：\r\n\r\n- **Records** - 简洁的数据类\r\n- **Pattern Matching** - 模式匹配\r\n- **Sealed Classes** - 密封类\r\n- **Text Blocks** - 文本块\r\n\r\n> 💡 **提示**：升级到 Java 17 不仅能使用新特性，还能获得更好的性能和安全性。\r\n\r\n### 1.1 Records 示例\r\n\r\n```java\r\npublic record User(String name, int age, String email) {\r\n    // 自动生成 getter、equals、hashCode、toString\r\n}\r\n\r\n// 使用\r\nUser user = new User(\"张三\", 25, \"zhangsan@example.com\");\r\nSystem.out.println(user.name()); // 张三\r\n1.2 Pattern Matching\r\n二、Jakarta EE 9+\r\n从 javax.* 迁移到 jakarta.* 命名空间，这是最大的破坏性变更：\r\n\r\n旧包名	新包名\r\njavax.servlet	jakarta.servlet\r\njavax.persistence	jakarta.persistence\r\njavax.validation	jakarta.validation\r\njavax.annotation	jakarta.annotation\r\n三、GraalVM 原生镜像支持\r\nSpring Boot 3.0 提供了一流的 GraalVM 原生镜像支持：\r\n\r\n优势对比\r\n指标	JVM 模式	Native 模式\r\n启动时间	~2秒	~0.05秒\r\n内存占用	~200MB	~50MB\r\n打包大小	~20MB	~70MB\r\n⚡ 性能提升：原生镜像启动时间可以从秒级降到毫秒级，非常适合 Serverless 场景！\r\n\r\n四、可观测性增强\r\n新增 Micrometer 和 Micrometer Tracing 支持：\r\n\r\n支持的追踪系统\r\nZipkin\r\nWavefront\r\nOpenTelemetry\r\nJaeger\r\n五、HTTP 接口客户端\r\n声明式 HTTP 客户端，类似 Feign：\r\n\r\n总结\r\nSpring Boot 3.0 是现代 Java 开发的重要升级，主要改进包括：\r\n\r\nJava 17 基线\r\nJakarta EE 9+ 迁移\r\nGraalVM 原生镜像支持\r\n可观测性增强\r\n声明式 HTTP 客户端\r\n建议尽快升级体验新特性！ 🚀\r\n\r\n参考文档：Spring Boot 3.0 Release Notes', 'https://picsum.photos/400/200?random=2', 7, 1, 932, 98, 1, '2025-11-20 14:30:00', '2025-11-30 10:55:11');
INSERT INTO `record` VALUES (3, '周末京都赏枫之旅', '趁着深秋时节，来了一场说走就走的京都之旅。清水寺的红叶美得让人窒息，仿佛置身于画中...', NULL, 'https://picsum.photos/400/200?random=3', 18, 1, 2103, 345, 1, '2025-11-18 09:00:00', '2025-11-29 14:41:05');
INSERT INTO `record` VALUES (4, '《代码整洁之道》读书笔记', 'Robert C. Martin 的经典著作，教会我们如何写出优雅、可维护的代码。以下是我的读书心得...', NULL, 'https://picsum.photos/400/200?random=4', 15, 1, 564, 78, 1, '2025-11-15 16:00:00', '2025-11-30 10:56:38');
INSERT INTO `record` VALUES (5, '自制提拉米苏蛋糕', '第一次尝试在家做提拉米苏，没想到效果出奇的好！分享一下详细的制作步骤和一些小技巧...', NULL, 'https://picsum.photos/400/200?random=5', 23, 1, 1560, 234, 1, '2025-11-12 11:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (6, '今日份的好心情', '阳光正好，微风不燥。在咖啡馆坐了一下午，看着窗外的人来人往，突然觉得生活也挺美好的...', NULL, NULL, 12, 1, 423, 89, 1, '2025-11-10 15:00:00', '2025-11-29 18:20:57');
INSERT INTO `record` VALUES (7, 'MySQL 索引优化实战', '记录一次线上数据库慢查询优化的完整过程，从分析执行计划到创建合适的索引...', NULL, 'https://picsum.photos/400/200?random=7', 8, 1, 781, 113, 1, '2025-11-08 10:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (8, '上海城市漫步：武康路一日游', '漫步在梧桐树下的武康路，感受老上海的优雅与浪漫。这里的每一栋老洋房都有自己的故事...', NULL, 'https://picsum.photos/400/200?random=8', 19, 1, 1892, 267, 1, '2025-11-05 09:30:00', '2025-11-29 15:48:20');
INSERT INTO `record` VALUES (9, 'Docker 容器化部署指南', '从零开始学习 Docker，包括镜像构建、容器管理、Docker Compose 编排等核心内容...', NULL, 'https://picsum.photos/400/200?random=9', 9, 1, 921, 134, 1, '2025-11-01 14:00:00', '2025-11-30 10:32:09');
INSERT INTO `record` VALUES (11, '前端开发进阶：Vue 与 JavaScript 的奇妙联动', '', '# 分布式事务\n\n## 本地事务回顾\n\n### 事务概念\n\n数据库事务(简称：事务，Transaction)是指数据库执行过程中的一个逻辑单位，由一个有限的数据库操作序列构成。\n\n### 事务的特性\n\n事务拥有以下四个特性，习惯上被称为ACID特性：\n\n**原子性(Atomicity)**：事务作为一个整体被执行，包含在其中的对数据库的操作要么全部被执行，要么都不执行。\n\n**一致性(Consistency)**：事务应确保数据库的状态从一个一致状态转变为另一个一致状态。一致状态是指数据库中的数据应满足完整性约束。除此之外，一致性还有另外一层语义，就是事务的中间状态不能被观察到(这层语义也有说应该属于原子性)。\n\n**隔离性(Isolation)**：多个事务并发执行时，一个事务的执行不应影响其他事务的执行，如同只有这一个操作在被数据库所执行一样。\n\n**持久性(Durability)**：已被提交的事务对数据库的修改应该永久保存在数据库中。在事务结束时，此操作将不可逆转。\n\n### 本地事务\n\n起初，事务仅限于对单一数据库资源的访问控制,架构服务化以后，事务的概念延伸到了服务中。倘若将一个单一的服务操作作为一个事务，那么整个服务操作只能涉及一个单一的数据库资源,这类基于单个服务单一数据库资源访问的事务，被称为本地事务(Local Transaction)。\n![图片](http://localhost:9999/uploads/records/images/ce7eab79-6ebc-4a71-8f17-36aa8d3c7bca.png)\n\n\n## 分布式事务\n\n### 分布式事务概念\n\n分布式事务指事务的参与者、支持事务的服务器、资源服务器以及事务管理器分别位于不同的分布式系统的不同节点之上,且属于不同的应用，分布式事务需要保证这些操作要么全部成功，要么全部失败。本质上来说，分布式事务就是为了保证不同数据库的数据一致性。\n\n最早的分布式事务应用架构很简单，不涉及服务间的访问调用，仅仅是服务内操作涉及到对多个数据库资源的访问。\n\n![1603953799527](assets/1603953799527.png)\n\n当一个服务操作访问不同的数据库资源，又希望对它们的访问具有事务特性时，就需要采用分布式事务来协调所有的事务参与者。\n\n对于上面介绍的分布式事务应用架构，尽管一个服务操作会访问多个数据库资源，但是毕竟整个事务还是控制在单一服务的内部。如果一个服务操作需要调用另外一个服务，这时的事务就需要跨越多个服务了。在这种情况下，起始于某个服务的事务在调用另外一个服务的时候，需要以某种机制流转到另外一个服务，从而使被调用的服务访问的资源也自动加入到该事务当中来。下图反映了这样一个跨越多个服务的分布式事务：\n\n![1603953818270](assets/1603953818270.png)\n\n如果将上面这两种场景(一个服务可以调用多个数据库资源，也可以调用其他服务)结合在一起，对此进行延伸，整个分布式事务的参与者将会组成如下图所示的树形拓扑结构。在一个跨服务的分布式事务中，事务的发起者和提交均系同一个，它可以是整个调用的客户端，也可以是客户端最先调用的那个服务。\n\n![1603953842478](assets/1603953842478.png)\n\n较之基于单一数据库资源访问的本地事务，分布式事务的应用架构更为复杂。在不同的分布式应用架构下，实现一个分布式事务要考虑的问题并不完全一样，比如对多资源的协调、事务的跨服务传播等，实现机制也是复杂多变。\n\n**在多个项目、多个数据库进行联动操作的时候，进行统一的事务控制，就是分布式事务。**\n\n\n\n\n\n### 分布式事务相关理论\n\n#### 1.4.1.CAP定理 \n\n![1603954171938](assets/1603954171938.png)\n\nCAP定理是在 1998年加州大学的计算机科学家 Eric Brewer （埃里克.布鲁尔）提出，**分布式**系统有三个指标\n\n- Consistency：一致性\n- Availability：可用性\n- Partition tolerance：分区容错\n\n它们的第一个字母分别是 C、A、P。Eric Brewer 说，这三个指标不可能同时做到。这个结论就叫做 CAP 定理。\n\n##### P：分区容错-partition-tolerance\n\n代表分布式系统在遇到某节点或网络分区故障的时候，仍然能够对外提供满足一致性或可用性的服务。\n\n![image-20230714111032996](img/image-20230714111032996.png)\n\n\n\n##### A：可用性-availability\n\n代表用户访问数据的时候，系统是否能在正常响应时间返回预期的结果，即只要收到用户的请求，服务器就必须给出回应。\n\n![image-20230714111453625](img/image-20230714111453625.png)\n\n\n\n##### C：一致性-consistency\n\n代表更新操作成功后，所有节点在同一时间的数据保持完全一致。\n\n一致性分类：\n\n- 强一致性，要求更新过的数据能被后续的访问都能看到\n- 弱一致性，能容忍后续的部分或者全部访问不到\n- 最终一致性，经过一段时间后要求能访问到更新后的数据\n\nCAP中说的一致性指的是强一致性\n\n![image-20230714113349604](img/image-20230714113349604.png)\n\n\n\n\n\n##### 一致性和可用性的矛盾\n\n一致性和可用性，为什么不可能同时成立？答案很简单，因为可能通信失败（即出现分区容错）。\n\n- **CP：**（一致性、分区容错性）如果保证 S2 的一致性，那么 S1 必须在写操作时，锁定 S2 的读操作和写操作。只有数据同步后，才能重新开放读写。锁定期间，S2 不能读写，没有可用性。一个保证了CP而一个舍弃了A的分布式系统，一旦发生网络故障或者消息丢失等情况，就要牺牲用户的体验，等待所有数据全部一致了之后再让用户访问系统。设计成CP的系统其实也不少，其中最典型的就是很多分布式数据库，他们都是设计成CP的。在发生极端情况时，优先保证数据的强一致性，代价就是舍弃系统的可用性。分布式系统中常用的Zookeeper也是在CAP三者之中选择优先保证CP的。\n- **AP：**（可用性、分区容错性）如果保证 S2 的可用性，那么势必不能锁定 S2，所以一致性不成立，则是可用性（高可用），要高可用并允许分区，则需放弃一致性。一旦网络问题发生，节点之间可能会失去联系。为了保证高可用，需要在用户访问时可以马上得到返回，则每个节点只能用本地数据提供服务，而这样会导致全局数据的不一致性。这种舍弃强一致性而保证系统的分区容错性和可用性的场景和案例非常多，12306买票等\n\n综上所述，S2 无法同时做到一致性和可用性。系统设计时只能选择一个目标。如果追求一致性，那么无法保证所有节点的可用性；如果追求所有节点的可用性，那就没法做到一致性。\n\n\n\n### BASE理论\n\nBASE：全称：Basically Available(基本可用)，Soft state（软状态）,和 Eventually consistent（最终一致性）三个短语的缩写，来自 ebay 的架构师提出。BASE 理论是对 CAP 中一致性和可用性权衡的结果，其来源于对大型互联网分布式实践的总结，是基于 CAP 定理逐步演化而来的。其核心思想是：\n\n```\n既是无法做到强一致性（Strong consistency），但每个应用都可以根据自身的业务特点，采用适当的方式来使系统达到最终一致性（Eventual consistency）。\n```\n\n##### Basically Available(基本可用)\n\n什么是基本可用呢？假设系统，出现了不可预知的故障，但还是能用，相比较正常的系统而言：\n\n1. 响应时间上的损失：正常情况下的搜索引擎 0.5 秒即返回给用户结果，而**基本可用**的搜索引擎可以在 1 秒作用返回结果。\n2. 功能上的损失：在一个电商网站上，正常情况下，用户可以顺利完成每一笔订单，但是到了大促期间，为了保护购物系统的稳定性，部分消费者可能会被引导到一个降级页面。\n\n##### soft-state-软状态\n\n什么是软状态呢？相对于原子性而言，要求多个节点的数据副本都是一致的，这是一种 “硬状态”。\n\n软状态指的是：允许系统中的数据存在中间状态，并认为该状态不影响系统的整体可用性，即允许系统在多个不同节点的数据副本存在数据延时。\n\n##### eventually-consistent-最终一致性\n\n系统能够保证在没有其他新的更新操作的情况下，数据最终一定能够达到一致的状态，因此所有客户端对系统的数据访问最终都能够获取到最新的值。\n\n## 分布式事务解决方案\n\n### 基于XA协议的两阶段提交\n\n首先我们来简要看下分布式事务处理的XA规范 ：\n\n![1603956904242](assets/1603956904242.png)\n\n可知XA规范中分布式事务有AP，RM，TM组成：\n\n其中应用程序(Application Program ，简称AP)：AP定义事务边界（定义事务开始和结束）并访问事务边界内的资源。\n\n资源管理器(Resource Manager，简称RM)：Rm管理计算机共享的资源，许多软件都可以去访问这些资源，资源包含比如数据库、文件系统、打印机服务器等。\n\n事务管理器(Transaction Manager ，简称TM)：负责管理全局事务，分配事务唯一标识，监控事务的执行进度，并负责事务的提交、回滚、失败恢复等。\n\n**二阶段协议:**\n\n**第一阶段**TM要求所有的RM准备提交对应的事务分支，询问RM是否有能力保证成功的提交事务分支，RM根据自己的情况，如果判断自己进行的工作可以被提交，那就就对工作内容进行持久化，并给TM回执OK；否者给TM的回执NO。RM在发送了否定答复并回滚了已经的工作后，就可以丢弃这个事务分支信息了。\n\n**第二阶段**TM根据阶段1各个RM prepare的结果，决定是提交还是回滚事务。如果所有的RM都prepare成功，那么TM通知所有的RM进行提交；如果有RM prepare回执NO的话，则TM通知所有RM回滚自己的事务分支。\n\n也就是TM与RM之间是通过两阶段提交协议进行交互的.\n\n**优点：** 尽量保证了数据的强一致，适合对数据强一致要求很高的关键领域。（其实也不能100%保证强一致）\n\n**缺点：** 实现复杂，牺牲了可用性，对性能影响较大，不适合高并发高性能场景。\n\n### TCC补偿机制\n\nTCC 其实就是采用的补偿机制，其核心思想是：针对每个操作，都要注册一个与其对应的确认和补偿（撤销）操作。它分为三个阶段：\n\n- Try 阶段主要是对业务系统做检测及资源预留\n- Confirm 阶段主要是对业务系统做确认提交，Try阶段执行成功并开始执行 Confirm阶段时，默认 Confirm阶段是不会出错的。即：只要Try成功，Confirm一定成功。\n- Cancel 阶段主要是在业务执行错误，需要回滚的状态下执行的业务取消，预留资源释放。\n\n![1603957375227](assets/1603957375227.png)\n\n例如： A要向 B 转账，思路大概是：\n\n我们有一个本地方法，里面依次调用\n1、首先在 Try 阶段，要先调用远程接口把 B和 A的钱给冻结起来。\n2、在 Confirm 阶段，执行远程调用的转账的操作，转账成功进行解冻。\n3、如果第2步执行成功，那么转账成功，如果第二步执行失败，则调用远程冻结接口对应的解冻方法 (Cancel)。\n\n**优点：** 相比两阶段提交，可用性比较强\n\n**缺点：** 数据的一致性要差一些。TCC属于应用层的一种补偿方式，所以需要程序员在实现的时候多写很多补偿的代码，在一些场景中，一些业务流程可能用TCC不太好定义及处理。\n\n### 消息最终一致性\n\n消息最终一致性其核心思想是将分布式事务拆分成本地事务进行处理，这种思路是来源于ebay。我们可以从下面的流程图中看出其中的一些细节：\n\n![1603957413371](assets/1603957413371.png)\n\n基本思路就是：\n\n消息生产方，需要额外建一个消息表，并记录消息发送状态。消息表和业务数据要在一个事务里提交，也就是说他们要在一个数据库里面。然后消息会经过MQ发送到消息的消费方。如果消息发送失败，会进行重试发送。\n\n消息消费方，需要处理这个消息，并完成自己的业务逻辑。此时如果本地事务处理成功，表明已经处理成功了，如果处理失败，那么就会重试执行。如果是业务上面的失败，可以给生产方发送一个业务补偿消息，通知生产方进行回滚等操作。\n\n生产方和消费方定时扫描本地消息表，把还没处理完成的消息或者失败的消息再发送一遍。如果有靠谱的自动对账补账逻辑，这种方案还是非常实用的。\n\n**优点：** 一种非常经典的实现，避免了分布式事务，实现了最终一致性。\n\n**缺点：** 消息表会耦合到业务系统中，如果没有封装好的解决方案，会有很多杂活需要处理。\n\n## seata\n\n### seata介绍\n\nSeata 是一款开源的分布式事务解决方案，致力于提供高性能和简单易用的分布式事务服务。Seata 将为用户提供了 AT、TCC、SAGA 和 XA 事务模式，为用户打造一站式的分布式解决方案。\n\n官网地址：http://seata.io/zh-cn/\n\n![1603957717215](assets/1603957717215.png)\n\n![1603957782368](assets/1603957782368.png)\n\n- Seata用于解决分布式事务\n- Seata非常适合解决微服务分布式事务【dubbo、SpringCloud….】\n- Seata性能高\n- Seata使用简单\n\n### AT模式介绍\n\n![1603957853127](assets/1603957853127.png)\n\n**Transaction Coordinator (TC)：** 事务协调器，维护全局事务的运行状态，负责协调并驱动全局事务的提交或回滚。\n\n**Transaction Manager (TM)：** 控制全局事务的边界，负责开启一个全局事务，并最终发起全局提交或全局回滚的决议。\n\n**Resource Manager (RM)：** 控制分支事务，负责分支注册、状态汇报，并接收事务协调器的指令，驱动分支（本地）事务的提交和回滚。\n\n**一个典型的分布式事务过程：**\n\n1. TM 向 TC 申请开启一个全局事务，全局事务创建成功并生成一个全局唯一的 XID。\n2. XID 在微服务调用链路的上下文中传播。\n3. RM 向 TC 注册分支事务，将其纳入 XID 对应全局事务的管辖。\n4. TM 向 TC 发起针对 XID 的全局提交或回滚决议。\n5. TC 调度 XID 下管辖的全部分支事务完成提交或回滚请求。\n\nAT模式使用前提：\n\n- 基于支持本地 ACID 事务的关系型数据库。\n- Java 应用，通过 JDBC 访问数据库。\n\n**AT模式机制：**\n\n基于两阶段提交协议的演变。\n\n一阶段：\n\n 业务数据和回滚日志记录在同一个本地事务中提交，释放本地锁和连接资源。\n\n二阶段：\n\n 提交异步化，非常快速地完成。\n\n 回滚通过一阶段的回滚日志进行反向补偿。\n\n\n\n### seata_server安装 \n\n1.从官网上下载seata server端的程序包\n\nhttps://github.com/apache/incubator-seata/releases\n\n> 也可以使用资料中提供的\n\n2.修改配置\n\n打开seata安装目录中的conf目录下的application.example.yml，拷贝如下框选的内容：\n\n![image-20240711171942143](img/image-20240711171942143.png)\n\n然后打开seata安装目录中的conf目录下的application.yml，将之前拷贝的内容复制到指定位置，并修改，具体如下：\n\n```yml\nseata:\n  config:\n    # support: nacos, consul, apollo, zk, etcd3\n    type: nacos\n    nacos:\n      server-addr: 127.0.0.1:8848\n      namespace: public\n      group: SEATA_GROUP\n      username: nacos\n      password: nacos\n      context-path:\n      ##if use MSE Nacos with auth, mutex with username/password attribute\n      #access-key:\n      #secret-key:\n      data-id: seataServer.properties\n  registry:\n    # support: nacos, eureka, redis, zk, consul, etcd3, sofa\n    type: nacos\n    nacos:\n      server-addr: 127.0.0.1:8848\n      namespace: public\n      group: SEATA_GROUP\n      username: nacos\n      password: nacos\n      context-path:\n      ##if use MSE Nacos with auth, mutex with username/password attribute\n      #access-key:\n      #secret-key:\n      data-id: seataServer.properties\n```\n\n3.nacos配置seata\n\n打开nacos，按照之前seata的application.yml的配置进行如下配置\n\n![image-20240711172331213](img/image-20240711172331213.png)\n\nnacos配置列表信息如下\n\n![image-20240711172403324](img/image-20240711172403324.png)\n\n将seata安装目录中的script目录中config-center目录中的config.txt全部内容复制并拷贝到nacos的seataServer.properties中，并修改如下内容\n\n```properties\nstore.db.datasource=druid\nstore.db.dbType=mysql\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\nstore.db.url=jdbc:mysql://127.0.0.1:3306/ry-cloud?useUnicode=true&rewriteBatchedStatements=true\nstore.db.user=root\nstore.db.password=root\nstore.db.minConn=5\nstore.db.maxConn=30\nstore.db.globalTable=global_table\nstore.db.branchTable=branch_table\nstore.db.distributedLockTable=distributed_lock\nstore.db.queryLimit=100\nstore.db.lockTable=lock_table\nstore.db.maxWait=5000\n```\n\n4.创建seata数据库\n\n在ry-cloud数据库中执行以下sql语句生成seata对应的据库表。\n\n```sql\n-- -------------------------------- The script used when storeMode is \'db\' --------------------------------\n-- the table to store GlobalSession data\nCREATE TABLE IF NOT EXISTS `global_table`\n(\n    `xid`                       VARCHAR(128) NOT NULL,\n    `transaction_id`            BIGINT,\n    `status`                    TINYINT      NOT NULL,\n    `application_id`            VARCHAR(32),\n    `transaction_service_group` VARCHAR(32),\n    `transaction_name`          VARCHAR(128),\n    `timeout`                   INT,\n    `begin_time`                BIGINT,\n    `application_data`          VARCHAR(2000),\n    `gmt_create`                DATETIME,\n    `gmt_modified`              DATETIME,\n    PRIMARY KEY (`xid`),\n    KEY `idx_gmt_modified_status` (`gmt_modified`, `status`),\n    KEY `idx_transaction_id` (`transaction_id`)\n) ENGINE = InnoDB\n  DEFAULT CHARSET = utf8mb4;\n\n-- the table to store BranchSession data\nCREATE TABLE IF NOT EXISTS `branch_table`\n(\n    `branch_id`         BIGINT       NOT NULL,\n    `xid`               VARCHAR(128) NOT NULL,\n    `transaction_id`    BIGINT,\n    `resource_group_id` VARCHAR(32),\n    `resource_id`       VARCHAR(256),\n    `branch_type`       VARCHAR(8),\n    `status`            TINYINT,\n    `client_id`         VARCHAR(64),\n    `application_data`  VARCHAR(2000),\n    `gmt_create`        DATETIME(6),\n    `gmt_modified`      DATETIME(6),\n    PRIMARY KEY (`branch_id`),\n    KEY `idx_xid` (`xid`)\n) ENGINE = InnoDB\n  DEFAULT CHARSET = utf8mb4;\n\n-- the table to store lock data\nCREATE TABLE IF NOT EXISTS `lock_table`\n(\n    `row_key`        VARCHAR(128) NOT NULL,\n    `xid`            VARCHAR(96),\n    `transaction_id` BIGINT,\n    `branch_id`      BIGINT       NOT NULL,\n    `resource_id`    VARCHAR(256),\n    `table_name`     VARCHAR(32),\n    `pk`             VARCHAR(36),\n    `gmt_create`     DATETIME,\n    `gmt_modified`   DATETIME,\n    PRIMARY KEY (`row_key`),\n    KEY `idx_branch_id` (`branch_id`)\n) ENGINE = InnoDB\n  DEFAULT CHARSET = utf8mb4;\n\n-- for AT mode you must to init this sql for you business database. the seata server not need it.\nCREATE TABLE IF NOT EXISTS `undo_log`\n(\n    `branch_id`     BIGINT(20)   NOT NULL COMMENT \'branch transaction id\',\n    `xid`           VARCHAR(100) NOT NULL COMMENT \'global transaction id\',\n    `context`       VARCHAR(128) NOT NULL COMMENT \'undo_log context,such as serialization\',\n    `rollback_info` LONGBLOB     NOT NULL COMMENT \'rollback info\',\n    `log_status`    INT(11)      NOT NULL COMMENT \'0:normal status,1:defense status\',\n    `log_created`   DATETIME(6)  NOT NULL COMMENT \'create datetime\',\n    `log_modified`  DATETIME(6)  NOT NULL COMMENT \'modify datetime\',\n    UNIQUE KEY `ux_undo_log` (`xid`, `branch_id`)\n) ENGINE = InnoDB\n  AUTO_INCREMENT = 1\n  DEFAULT CHARSET = utf8mb4 COMMENT =\'AT transaction mode undo table\';\n```\n\n5.启动seata\n\n到seata安装目录的bin目录中双击seata-server.bat，启动seata，然后到nacos服务列表中查看是否有seata服务\n\n![image-20240711173136555](img/image-20240711173136555.png)\n\n\n\n### 项目集成seata\n\n1.在ruoyi-test项目的pom.xml文件中引入seata起步依赖\n\n```xml\n<dependency>\n    <groupId>com.alibaba.cloud</groupId>\n    <artifactId>spring-cloud-starter-alibaba-seata</artifactId>\n</dependency>\n```\n\n2.在ruoyi-test项目的bootstrap.yml中配置seata的配置\n\n```yaml\nseata:\n  registry:\n    type: nacos\n    nacos:\n      server-addr: 127.0.0.1:8848\n      namespace: public\n      group: SEATA_GROUP\n      application: seata-server\n```\n\n3.在ruoyi-system项目的pom.xml和bootstrap.yml文件中做一样的配置\n\n4.在ruoyi-test项目的SysStudentServiceImpl的insertSysStudent方法中添加注解\n\n@GlobalTransactional实现分布式事务控制。\n\n```java\n@Override\n@GlobalTransactional\npublic int insertSysStudent(SysStudent sysStudent){\n        int i = sysStudentMapper.insertSysStudent(sysStudent);\n        SysUser sysUser = new SysUser();\n        sysUser.setUserName(\"分布式事务测试1\");\n        sysUser.setNickName(\"分布式事务测试1\");\n        sysUser.setPassword(\"123456\");\n        AjaxResult add = remoteUserService.add(sysUser, SecurityConstants.INNER);\n        System.out.println(\"seata添加：\"+add.toString());\n        int a = 1/0;\n        return i;\n}\n```\n\n> 注意，ruoyi-system的RemoteUserService和RemoteUserFallbackFactory添加了关于add方法的处理。\n\n', '/uploads/records/covers/b22d45bd-21fb-48d3-8cf1-7f8d21d28b7b.jpg', 6, 1, 26, 1, 1, '2025-11-30 11:07:19', '2025-12-01 18:24:29');

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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录分类表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_like
-- ----------------------------
INSERT INTO `record_like` VALUES (2, 7, NULL, '0:0:0:0:0:0:0:1', NULL);
INSERT INTO `record_like` VALUES (9, 1, NULL, '0:0:0:0:0:0:0:1', NULL);
INSERT INTO `record_like` VALUES (10, 11, NULL, '0:0:0:0:0:0:0:1', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_tag
-- ----------------------------
INSERT INTO `record_tag` VALUES (1, 'Vue', 17, '2025-11-27 12:04:11', '#E6A23C');
INSERT INTO `record_tag` VALUES (2, 'Spring Boot', 8, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (3, 'MySQL', 6, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (4, '旅行攻略', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (5, '读书笔记', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (6, '美食探店', 7, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (7, 'Docker', 4, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (8, '生活随想', 3, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (9, 'JavaScript', 13, '2025-11-27 12:04:11', '#67C23A');
INSERT INTO `record_tag` VALUES (10, 'Java', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (11, '前端', 9, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (12, '后端', 6, '2025-11-27 12:19:11', '#409EFF');

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
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录-标签关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_tag_relation
-- ----------------------------
INSERT INTO `record_tag_relation` VALUES (18, 1, 1);
INSERT INTO `record_tag_relation` VALUES (19, 1, 9);
INSERT INTO `record_tag_relation` VALUES (4, 2, 2);
INSERT INTO `record_tag_relation` VALUES (5, 2, 10);
INSERT INTO `record_tag_relation` VALUES (6, 2, 12);
INSERT INTO `record_tag_relation` VALUES (7, 3, 4);
INSERT INTO `record_tag_relation` VALUES (8, 4, 5);
INSERT INTO `record_tag_relation` VALUES (9, 5, 6);
INSERT INTO `record_tag_relation` VALUES (10, 6, 8);
INSERT INTO `record_tag_relation` VALUES (11, 7, 3);
INSERT INTO `record_tag_relation` VALUES (12, 8, 4);
INSERT INTO `record_tag_relation` VALUES (13, 9, 7);
INSERT INTO `record_tag_relation` VALUES (28, 11, 1);
INSERT INTO `record_tag_relation` VALUES (29, 11, 9);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '网站访问统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of site_visit
-- ----------------------------
INSERT INTO `site_visit` VALUES (1, '2025-11-29', 3, '2025-11-29 13:06:39', '2025-11-29 13:55:18');
INSERT INTO `site_visit` VALUES (2, '2025-11-30', 1, '2025-11-30 10:14:03', '2025-11-30 10:14:03');
INSERT INTO `site_visit` VALUES (3, '2025-12-01', 3, '2025-12-01 14:53:48', '2025-12-01 16:11:46');
INSERT INTO `site_visit` VALUES (4, '2025-12-04', 2, '2025-12-04 10:52:52', '2025-12-04 10:54:34');

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Dawn', '3095882640@qq.com', '4b4baedff8691e5b9a01275beab4de0e', 1, 'http://localhost:9999/uploads/avatars/5715695f-4d1e-4ccb-be2d-722f62eae8e9.jpg', '时光不语，却回答了所有问题', '2025-11-26 14:54:01', '2025-12-04 10:53:16', 145, 2, 1);
INSERT INTO `user` VALUES (2, '测试用户', 'sara@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sara', '简介测试', '2025-11-26 16:08:14', '2025-11-30 10:14:18', 25, 1, 0);
INSERT INTO `user` VALUES (3, '江硕', 'jiangshuo@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=jiangshuo', '前端开发者', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (4, '经年未远', 'jingnianyuan@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=jingnianyuan', '学习中', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (5, '代码小王子', 'coder@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=coder', 'Vue开发者', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (6, '前端小白', 'xiaobai@test.com', 'e10adc3949ba59abbe56e057f20f883e', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=xiaobai', '正在学习前端', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (7, 'ex', 'ex@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=ex', '路人甲', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (8, '用户582039', '19839433499@163.com', 'e517bb455e88ffaa1a1dc47a8bad3b35', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=用户582039', '', '2025-11-27 14:23:02', '2025-11-27 14:23:02', 0, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
