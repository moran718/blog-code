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

 Date: 01/12/2025 10:21:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '签到记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in
-- ----------------------------
INSERT INTO `check_in` VALUES (2, 1, '2025-11-29', 10, 1, '2025-11-29 12:03:39');
INSERT INTO `check_in` VALUES (3, 2, '2025-11-29', 10, 1, '2025-11-29 12:09:22');
INSERT INTO `check_in` VALUES (4, 2, '2025-11-30', 15, 2, '2025-11-30 10:14:18');
INSERT INTO `check_in` VALUES (5, 1, '2025-11-30', 15, 2, '2025-11-30 13:27:41');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '随笔表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '随笔评论表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (1, 1, 0, '13', NULL, 0, '2025-11-26 18:20:38');
INSERT INTO `message` VALUES (2, 1, 0, '66666', NULL, 0, '2025-11-26 18:22:01');
INSERT INTO `message` VALUES (3, 1, 1, '123', NULL, 0, '2025-11-26 18:24:05');
INSERT INTO `message` VALUES (4, 1, 1, '😁😂', NULL, 0, '2025-11-26 18:24:08');
INSERT INTO `message` VALUES (5, 1, 0, '5555', NULL, 0, '2025-11-26 18:24:34');
INSERT INTO `message` VALUES (6, 1, 0, '4444', NULL, 0, '2025-11-26 18:24:39');
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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '留言回复表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 'Vue3 组合式 API 深度解析', '详细介绍 Vue3 Composition API 的使用方法，包括 setup、ref、reactive、computed 等核心概念...', '# \n\n## 1、Java多态，子类父类中类的加载顺序\n\n(1) 父类静态代码块(包括静态初始化块，静态属性，但不包括静态方法) \n\n(2) 子类静态代码块(包括静态初始化块，静态属性，但不包括静态方法  )\n\n(3) 父类非静态代码块(  包括非静态初始化块，非静态属性  )\n\n(4) 父类构造函数\n\n(5) 子类非静态代码块  (  包括非静态初始化块，非静态属性  )\n\n(6) 子类构造函数\n\n例：下面代码的输出是什么？\n\n```java\n public class Base\n    {\n        private String baseName = \"base\";\n        public Base()\n        {\n            callName();\n        }\n\n        public void callName()\n        {\n            System. out. println(baseName);\n        }\n\n        static class Sub extends Base\n        {\n            private String baseName = \"sub\";\n            public void callName()\n            {\n                System. out. println (baseName) ;\n            }\n        }\n        public static void main(String[] args)\n        {\n            Base b = new Sub();\n        }\n    }\n```\n\n答案：null\n\n## 2、JVM操作指令\n\n- **jinfo**：查看或修改JVM运行时参数（如系统属性、启动参数），不涉及内存映像。\n- **jhat**：分析已生成的堆转储文件（如.hprof），提供HTTP服务展示内存分析结果，但本身不生成内存映像。\n- **jstat**：监控JVM运行时统计信息（如GC次数、堆内存使用率），仅提供动态数据，不生成完整内存映像。\n- **jmap**：生成JVM堆转储快照（heap dump），并提供堆内存的详细信息，包括对象分布、内存使用率、垃圾收集器配置等。**适用场景**：分析内存泄漏、查看对象内存占用、诊断内存溢出问题。\n\n## 3、Map\n\nHashMap，是map的默认实现类，每个元素由 `key` 和 `value` 组成，`key` 唯一（不可重复），`value` 可重复。是无序的。允许 1 个 `null` 键和多个 `null` 值。\n\nLinkedHashMap，可保证插入 / 访问顺序。不允许 `null` 键和 `null` 值。\n\nTreeMap，有序，不允许 `null` 键（会抛 `NullPointerException`），但允许 `null` 值。\n\nHashtable，允许 `null` 键和 `null` 值。\n\n|      实现类       |        底层结构         |                           特点                           | 线程安全 |\n| :---------------: | :---------------------: | :------------------------------------------------------: | :------: |\n|      HashMap      |    数组+链表+红黑树     | 查找效率高（平均O（1）），无序，jdk1.8优化了哈希冲突处理 |    否    |\n|   LinkedHashMap   |     哈希表+双向链表     |   继承HashMap，保留插入顺序或访问顺序（可用于LRU缓存）   |    否    |\n|      TreeMap      |         红黑树          |   键按自然顺序或自定义比较器排序，查找/插入O（log n）    |    否    |\n|     Hashtable     |        数组+链表        |            古老实现，性能较差，不允许null键值            | 是(低效) |\n| ConcurrentHashMap | 分段锁 / CAS（JDK 1.8） |            线程安全，高效并发，支持多线程操作            |    是    |\n\n## 4、“先进先出”的容器是\n\n**例：“先进先出”的容器是：( )**\n\n**A、堆栈(Stack)**\n\n**B、队列（Queue）**\n\n**C、字符串(String)**\n\n**D、迭代器(Iterator)**\n\n堆栈(Stack)错误：堆栈是\"后进先出\"（LIFO）的数据结构，最后压入栈的元素会最先被弹出，这与\"先进先出\"的特性相反。\n\n字符串(String)错误：字符串是用于存储字符序列的数据类型，它并不具有\"先进先出\"的特性。字符串的访问可以是随机的，不遵循任何进出顺序。\n\n 迭代器(Iterator)错误：迭代器是一种用于遍历集合的工具，它提供了按特定顺序访问集合元素的方法，但本身并不是一个存储容器，也不具备\"先进先出\"的特性。\n\n\"先进先出\"是队列（Queue）这种数据结构的核心特征，所以B是正确答案。队列的工作原理是：第一个进入队列的元素会第一个被处理和移出，就像排队买票一样，先到的人先买票离开。\n\n## 5、Java与C++对比\n\nJava完全取消了指针的概念,这是Java相对C++的一个重要区别。Java中的引用可以理解为受限的指针,但它不允许直接进行指针运算和操作。\n\nJava的垃圾回收机制(Garbage Collection)是自动进行的,不是程序结束时才回收。当JVM发现某些对象不再被引用时,就会将其标记并在合适的时机进行回收,这个过程是动态的、持续的。\n\nJava和C++都有三个特征：封装、继承和多态。\n\n## 6、i++与++i\n\n**i++执行逻辑：**先使用变量 `i` 当前的值参与表达式运算，然后再将 `i` 的值加 1。\n\n**++i执行逻辑：**先将变量 `i` 的值加 1，然后再使用更新后的值参与表达式运算。\n\n例：下方代码的输出结果是： 			结束是：0\n\n```java\npackage algorithms.com.guan.javajicu;\npublic class Inc { \n  public static void main(String[] args) { \n    Inc inc = new Inc(); \n    int i = 0; \n    inc.fermin(i); \n    i= i ++; \n    System.out.println(i);\n  \n  } \n  void fermin(int i){ \n    i++; \n  }\n}\n```\n\n## 7、Java面向对象\n\nJava是纯面向对象语言，所有代码必须定义在类中，不存在独立的“过程”或“函数”。\n\n方法必须隶属于类或对象，不能单独存在。\n\n非静态方法属于实例成员（对象），而静态方法才属于类成员。\n\n虽然Java方法必须属于类或对象，但调用方式与C/C++不同：\n\n​	Java需通过类名（静态方法）或对象（实例方法）调用。\n\n​	C/C++允许独立调用函数或过程。\n\n## 8、\n\n\n\n', 'https://picsum.photos/400/200?random=1', 6, 1, 1321, 157, 1, '2025-11-25 10:00:00', '2025-11-29 15:48:44');
INSERT INTO `record` VALUES (2, 'Spring Boot 3.0 新特性总结', 'Spring Boot 3.0 带来了许多激动人心的新特性，包括对 Java 17 的原生支持、GraalVM 原生镜像...', '## 引言\r\n\r\nSpring Boot 3.0 是一个里程碑式的版本，带来了众多令人兴奋的新特性和改进。本文将详细介绍这些变化。\r\n\r\n![Spring Boot](https://spring.io/img/projects/spring-boot.svg)\r\n\r\n## 一、Java 17 基线\r\n\r\nSpring Boot 3.0 要求最低 **Java 17**，这意味着我们可以使用许多新特性：\r\n\r\n- **Records** - 简洁的数据类\r\n- **Pattern Matching** - 模式匹配\r\n- **Sealed Classes** - 密封类\r\n- **Text Blocks** - 文本块\r\n\r\n> 💡 **提示**：升级到 Java 17 不仅能使用新特性，还能获得更好的性能和安全性。\r\n\r\n### 1.1 Records 示例\r\n\r\n```java\r\npublic record User(String name, int age, String email) {\r\n    // 自动生成 getter、equals、hashCode、toString\r\n}\r\n\r\n// 使用\r\nUser user = new User(\"张三\", 25, \"zhangsan@example.com\");\r\nSystem.out.println(user.name()); // 张三\r\n1.2 Pattern Matching\r\n二、Jakarta EE 9+\r\n从 javax.* 迁移到 jakarta.* 命名空间，这是最大的破坏性变更：\r\n\r\n旧包名	新包名\r\njavax.servlet	jakarta.servlet\r\njavax.persistence	jakarta.persistence\r\njavax.validation	jakarta.validation\r\njavax.annotation	jakarta.annotation\r\n三、GraalVM 原生镜像支持\r\nSpring Boot 3.0 提供了一流的 GraalVM 原生镜像支持：\r\n\r\n优势对比\r\n指标	JVM 模式	Native 模式\r\n启动时间	~2秒	~0.05秒\r\n内存占用	~200MB	~50MB\r\n打包大小	~20MB	~70MB\r\n⚡ 性能提升：原生镜像启动时间可以从秒级降到毫秒级，非常适合 Serverless 场景！\r\n\r\n四、可观测性增强\r\n新增 Micrometer 和 Micrometer Tracing 支持：\r\n\r\n支持的追踪系统\r\nZipkin\r\nWavefront\r\nOpenTelemetry\r\nJaeger\r\n五、HTTP 接口客户端\r\n声明式 HTTP 客户端，类似 Feign：\r\n\r\n总结\r\nSpring Boot 3.0 是现代 Java 开发的重要升级，主要改进包括：\r\n\r\nJava 17 基线\r\nJakarta EE 9+ 迁移\r\nGraalVM 原生镜像支持\r\n可观测性增强\r\n声明式 HTTP 客户端\r\n建议尽快升级体验新特性！ 🚀\r\n\r\n参考文档：Spring Boot 3.0 Release Notes', 'https://picsum.photos/400/200?random=2', 7, 1, 932, 98, 1, '2025-11-20 14:30:00', '2025-11-30 10:55:11');
INSERT INTO `record` VALUES (3, '周末京都赏枫之旅', '趁着深秋时节，来了一场说走就走的京都之旅。清水寺的红叶美得让人窒息，仿佛置身于画中...', NULL, 'https://picsum.photos/400/200?random=3', 18, 1, 2103, 345, 1, '2025-11-18 09:00:00', '2025-11-29 14:41:05');
INSERT INTO `record` VALUES (4, '《代码整洁之道》读书笔记', 'Robert C. Martin 的经典著作，教会我们如何写出优雅、可维护的代码。以下是我的读书心得...', NULL, 'https://picsum.photos/400/200?random=4', 15, 1, 564, 78, 1, '2025-11-15 16:00:00', '2025-11-30 10:56:38');
INSERT INTO `record` VALUES (5, '自制提拉米苏蛋糕', '第一次尝试在家做提拉米苏，没想到效果出奇的好！分享一下详细的制作步骤和一些小技巧...', NULL, 'https://picsum.photos/400/200?random=5', 23, 1, 1560, 234, 1, '2025-11-12 11:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (6, '今日份的好心情', '阳光正好，微风不燥。在咖啡馆坐了一下午，看着窗外的人来人往，突然觉得生活也挺美好的...', NULL, NULL, 12, 1, 423, 89, 1, '2025-11-10 15:00:00', '2025-11-29 18:20:57');
INSERT INTO `record` VALUES (7, 'MySQL 索引优化实战', '记录一次线上数据库慢查询优化的完整过程，从分析执行计划到创建合适的索引...', NULL, 'https://picsum.photos/400/200?random=7', 8, 1, 781, 113, 1, '2025-11-08 10:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (8, '上海城市漫步：武康路一日游', '漫步在梧桐树下的武康路，感受老上海的优雅与浪漫。这里的每一栋老洋房都有自己的故事...', NULL, 'https://picsum.photos/400/200?random=8', 19, 1, 1892, 267, 1, '2025-11-05 09:30:00', '2025-11-29 15:48:20');
INSERT INTO `record` VALUES (9, 'Docker 容器化部署指南', '从零开始学习 Docker，包括镜像构建、容器管理、Docker Compose 编排等核心内容...', NULL, 'https://picsum.photos/400/200?random=9', 9, 1, 921, 134, 1, '2025-11-01 14:00:00', '2025-11-30 10:32:09');
INSERT INTO `record` VALUES (11, '前端开发进阶：Vue 与 JavaScript 的奇妙联动', '', '# 前端开发进阶：Vue 与 JavaScript 的奇妙联动\n\n## 前端开发的演变\n\n在互联网发展的早期，前端开发主要聚焦于简单的静态页面展示。那时，网页基本由 HTML 构建，内容较为单一，仅仅能满足信息的基本呈现需求，交互性几乎为零。用户与网页的互动局限于点击链接、填写简单表单等基础操作，页面的视觉效果也较为单调。\n\n随着 CSS 的出现，网页的美观性迎来了重大变革。开发者可以通过 CSS 控制页面元素的外观和布局，如调整颜色、字体、大小和间距等，让网页变得更加丰富多彩。这一阶段，网页在视觉呈现上有了显著提升，但交互性方面仍存在较大局限。\n\n真正为前端开发带来质的飞跃的是 JavaScript 的发展。从最初简单的脚本语言，到如今功能强大的前端框架和库，JavaScript 使得网页能够实现复杂的动态交互功能。例如，当用户点击按钮时，页面可以实时响应，显示或隐藏特定内容；在表单输入时，能够即时进行数据验证等。这些交互功能极大地提升了用户体验，让网页从单纯的信息展示平台转变为与用户互动的重要媒介。\n\n在这个演变过程中，Vue 和 JavaScript 发挥了关键作用。Vue 作为一款流行的 JavaScript 框架，凭借其简洁易用、高效灵活等特性，成为众多开发者构建现代前端应用的首选框架之一。而 JavaScript 作为前端开发的核心语言，不断发展演进，为 Vue 等框架的诞生和发展提供了坚实的基础。\n\n## JavaScript：前端开发的基石\n\n### JavaScript 基础语法\n\nJavaScript 作为一种灵活且强大的脚本语言，拥有一系列基础语法，构成了前端开发的基础。\n\n变量用于存储数据，在 JavaScript 中，可以使用`var`、`let`和`const`来声明变量 。其中，`var`是 ES5 中的变量声明方式，作用域为函数级别；`let`和`const`是 ES6 新增的声明方式，作用域为块级别，例如：\n\n\n\n```\nvar message1 = \"Hello\";\n\nlet message2 = \"World\";\n\nconst PI = 3.14159;\n```\n\n函数是封装可重复使用代码块的重要工具，通过函数，可以将复杂的逻辑封装起来，提高代码的可维护性和复用性，如：\n\n\n\n```\nfunction addNumbers(a, b) {\n\n&#x20;   return a + b;\n\n}\n\nlet sum = addNumbers(3, 5);&#x20;\n```\n\n对象是一种复杂的数据结构，用于存储键值对，它可以包含多个属性和方法，方便组织和管理相关数据，示例如下：\n\n\n\n```\nlet person = {\n\n&#x20;   name: \"Alice\",\n\n&#x20;   age: 30,\n\n&#x20;   greet: function() {\n\n&#x20;       console.log(\"Hello, my name is \" + this.name);\n\n&#x20;   }\n\n};\n\nperson.greet();&#x20;\n```\n\n数组是用于存储一组有序数据的结构，通过索引可以访问数组中的元素，在前端开发中，常用于存储列表数据等，例如：\n\n\n\n```\nlet numbers = \\[1, 2, 3, 4, 5];\n\nlet firstNumber = numbers\\[0];&#x20;\n```\n\n### JavaScript 在前端开发中的作用\n\nJavaScript 在前端开发中扮演着至关重要的角色，它赋予了网页强大的交互性和动态性。\n\n在实现页面交互效果方面，JavaScript 可以监听各种用户事件，如点击、鼠标移动、键盘输入等，并根据事件触发相应的操作。比如，当用户点击一个按钮时，可以通过 JavaScript 改变页面元素的显示状态，或弹出一个提示框，像这样：\n\n\n\n```\n\\<!DOCTYPE html>\n\n\\<html>\n\n\\<head>\n\n&#x20;   \\<meta charset=\"UTF-8\">\n\n\\</head>\n\n\\<body>\n\n&#x20;   \\<button id=\"myButton\">点击我\\</button>\n\n&#x20;   \\<script>\n\n&#x20;       document.getElementById(\'myButton\').addEventListener(\'click\', function() {\n\n&#x20;           alert(\'按钮被点击了！\');\n\n&#x20;       });\n\n&#x20;   \\</script>\n\n\\</body>\n\n\\</html>\n```\n\n操作 DOM 元素是 JavaScript 的核心功能之一。DOM（文档对象模型）将网页中的各个元素视为对象，JavaScript 可以通过 DOM 提供的方法和属性，轻松地获取、修改、添加或删除网页中的元素。例如，获取一个特定的`<div>`元素，并修改其文本内容：\n\n\n\n```\n\\<!DOCTYPE html>\n\n\\<html>\n\n\\<head>\n\n&#x20;   \\<meta charset=\"UTF-8\">\n\n\\</head>\n\n\\<body>\n\n&#x20;   \\<div id=\"myDiv\">原始文本\\</div>\n\n&#x20;   \\<script>\n\n&#x20;       let divElement = document.getElementById(\'myDiv\');\n\n&#x20;       divElement.textContent = \'新的文本内容\';\n\n&#x20;   \\</script>\n\n\\</body>\n\n\\</html>\n```\n\n在处理表单提交时，JavaScript 能够对用户输入的数据进行验证和处理，确保数据的合法性和完整性。比如，验证用户输入的邮箱格式是否正确，若不正确则提示用户重新输入，示例代码如下：\n\n\n\n```\n\\<!DOCTYPE html>\n\n\\<html>\n\n\\<head>\n\n&#x20;   \\<meta charset=\"UTF-8\">\n\n\\</head>\n\n\\<body>\n\n&#x20;   \\<form id=\"myForm\">\n\n&#x20;       \\<label for=\"email\">邮箱：\\</label>\n\n&#x20;       \\<input type=\"email\" id=\"email\" />\n\n&#x20;       \\<input type=\"submit\" value=\"提交\" />\n\n&#x20;   \\</form>\n\n&#x20;   \\<script>\n\n&#x20;       document.getElementById(\'myForm\').addEventListener(\'submit\', function(event) {\n\n&#x20;           let emailInput = document.getElementById(\'email\');\n\n&#x20;           let email = emailInput.value;\n\n&#x20;           let emailRegex = /^\\[^\\s@]+@\\[^\\s@]+\\\\.\\[^\\s@]+\\$/;\n\n&#x20;           if (!emailRegex.test(email)) {\n\n&#x20;               alert(\'请输入有效的邮箱地址\');\n\n&#x20;               event.preventDefault();&#x20;\n\n&#x20;           }\n\n&#x20;       });\n\n&#x20;   \\</script>\n\n\\</body>\n\n\\</html>\n```\n\n### JavaScript 的挑战\n\n尽管 JavaScript 在前端开发中应用广泛且功能强大，但在大型项目中，原生 JavaScript 也面临一些挑战。\n\n在代码结构方面，随着项目规模的不断扩大，原生 JavaScript 代码容易变得混乱无序。由于缺乏严格的模块化机制（在 ES6 模块之前），不同功能的代码可能相互交织，难以清晰地划分模块和职责，这给代码的理解、维护和扩展带来了极大的困难。例如，在一个复杂的页面中，可能存在多个相互关联的功能模块，如用户登录、数据展示、表单提交等，如果使用原生 JavaScript 编写，各个模块的代码可能分散在不同的文件或代码块中，难以形成清晰的结构。\n\n维护困难也是一个突出问题。原生 JavaScript 没有内置的类型系统，属于弱类型语言，变量的类型在运行时才确定，这使得代码在运行过程中容易出现类型相关的错误，而且这些错误往往难以调试。比如，一个函数期望接收一个数字类型的参数，但在实际调用时，可能传入了一个字符串，由于 JavaScript 不会在编译阶段进行类型检查，这种错误只有在运行时才会暴露出来，增加了调试的难度。同时，在多人协作开发的大型项目中，由于缺乏统一的类型规范，不同开发者编写的代码风格和习惯可能差异较大，进一步加剧了代码维护的复杂性。\n\n## Vue：前端开发的利器\n\n### Vue 框架简介\n\nVue 是一款用于构建用户界面的渐进式 JavaScript 框架，由尤雨溪于 2014 年创建并发布。它的设计目标是通过简单易用的 API 和灵活的功能，提供良好的开发体验。Vue 的核心库专注于视图层，易于上手，并且能够与其他库或已有项目进行整合 。\n\nVue 采用了响应式数据绑定和组件化开发的核心概念。响应式数据绑定使得当数据发生变化时，视图会自动更新，确保了数据和视图的一致性。例如，在一个计数器应用中，当数据中的计数值发生改变时，页面上显示的计数值会实时同步更新，无需手动操作 DOM 来更新显示。\n\n组件化开发则鼓励开发者将应用程序拆分成独立、可复用的组件，每个组件都有自己的模板、数据、逻辑和样式。以一个电商页面为例，商品列表、购物车、导航栏等都可以作为独立的组件进行开发。在不同页面中，可以根据具体需求方便地复用这些组件，不仅提高了开发效率，还能确保代码的一致性和可维护性。例如，商品列表组件可以接收不同的商品数据进行展示，购物车组件可以在多个页面中复用，实现购物车功能的统一管理。\n\n### Vue 的优势\n\nVue 具有诸多优势，使其在前端开发中备受青睐。\n\n在简化 DOM 操作方面，Vue 通过数据驱动视图的方式，让开发者无需手动频繁操作 DOM。当数据发生变化时，Vue 会自动更新相应的 DOM 元素，大大减少了直接操作 DOM 的繁琐工作，降低了出错的概率。比如在一个待办事项列表应用中，添加或删除待办事项时，只需要修改数据，Vue 会自动更新列表的 DOM 展示，而不需要手动去添加或删除列表项的 DOM 元素。\n\nVue 还能提高开发效率，其简洁的语法和丰富的指令系统，使得开发者可以快速构建用户界面。例如，使用 v-if 指令可以方便地根据条件显示或隐藏元素，v-for 指令可以快速遍历数组并生成相应的 DOM 结构。同时，Vue 的单文件组件（SFC）将模板、脚本和样式集中在一个文件中，简化了文件管理，使得组件逻辑更加清晰，便于开发和维护。在开发一个表单组件时，可以在一个.vue 文件中同时编写表单的 HTML 结构（模板）、处理表单提交的 JavaScript 逻辑（脚本）以及表单的样式（style），一目了然。\n\n代码的可维护性在 Vue 中也得到了显著增强。组件化开发使得代码的结构更加清晰，每个组件只负责自己的功能，易于理解和修改。当项目规模扩大时，通过合理划分组件，可以降低代码的复杂度，方便团队协作开发。例如，在一个大型的企业级应用中，不同的开发人员可以分别负责不同的组件开发，互不干扰，而且在后续维护时，也能快速定位到需要修改的组件。\n\n### Vue 的应用场景\n\nVue 在多种场景中都有广泛应用。\n\n在单页面应用（SPA）开发中，Vue 结合 Vue Router 和 Vuex，可以轻松实现复杂的前端路由和状态管理。Vue Router 用于定义不同的 URL 路径与组件之间的映射关系，支持动态路由、嵌套路由等功能，使得页面的切换更加流畅和高效。Vuex 则用于集中管理应用的全局状态，确保状态以一种可预测的方式发生变化，避免了组件间状态传递混乱的问题。以一个在线商城的单页面应用为例，用户在浏览商品、添加商品到购物车、结算等过程中，通过 Vue Router 实现页面的切换，Vuex 管理用户的登录状态、购物车中的商品列表等全局状态，为用户提供了良好的交互体验。\n\n在复杂交互界面的构建上，Vue 的响应式数据绑定和组件化开发优势明显。例如，在一个数据可视化项目中，需要根据用户的操作实时更新图表展示，Vue 可以通过响应式数据绑定，快速将数据变化反映到图表上，同时利用组件化开发，将不同类型的图表（如柱状图、折线图、饼图等）封装成独立的组件，方便复用和维护。\n\nVue 在移动端开发中也表现出色，通过与 Weex 或 NativeScript 集成，Vue 可以用于开发跨平台的移动应用。这使得开发者可以使用熟悉的 Vue 技术栈，同时开发出能够在多个移动平台（如 iOS 和 Android）上运行的应用，大大提高了开发效率和代码的复用性。例如，一些知名的移动应用，如阿里巴巴的闲鱼，就使用了 Vue 进行开发，为用户提供了流畅的移动端交互体验。\n\n## Vue 与 JavaScript 的关系\n\n### Vue 基于 JavaScript 构建\n\nVue 是基于 JavaScript 构建的前端框架，其核心代码完全使用 JavaScript 编写。这意味着 Vue 的运行依赖于 JavaScript 的语法和特性，它在 JavaScript 的基础上进行了封装和扩展，为开发者提供了更高效、更便捷的开发体验。\n\n在创建 Vue 实例时，需要使用 JavaScript 的语法来定义数据、方法和生命周期钩子等。例如：\n\n\n\n```\n\\<!DOCTYPE html>\n\n\\<html>\n\n\\<head>\n\n&#x20;   \\<meta charset=\"UTF-8\">\n\n\\</head>\n\n\\<body>\n\n&#x20;   \\<div id=\"app\">\n\n&#x20;       {{ message }}\n\n&#x20;       \\<button @click=\"reverseMessage\">反转消息\\</button>\n\n&#x20;   \\</div>\n\n&#x20;   \\<script src=\"https://cdn.jsdelivr.net/npm/vue/dist/vue.js\">\\</script>\n\n&#x20;   \\<script>\n\n&#x20;       new Vue({\n\n&#x20;           el: \'#app\',\n\n&#x20;           data: {\n\n&#x20;               message: \'Hello Vue!\'\n\n&#x20;           },\n\n&#x20;           methods: {\n\n&#x20;               reverseMessage: function () {\n\n&#x20;                   this.message = this.message.split(\'\').reverse().join(\'\');\n\n&#x20;               }\n\n&#x20;           }\n\n&#x20;       });\n\n&#x20;   \\</script>\n\n\\</body>\n\n\\</html>\n```\n\n在上述代码中，通过`new Vue()`创建 Vue 实例，使用 JavaScript 的对象字面量来定义`el`（指定挂载的 DOM 元素）、`data`（定义数据）和`methods`（定义方法）。这里的`split`、`reverse`和`join`等方法都是 JavaScript 字符串对象的原生方法，Vue 借助这些 JavaScript 特性实现了数据的处理和交互逻辑。\n\n### Vue 对 JavaScript 的扩展\n\nVue 在 JavaScript 的基础上进行了多方面的扩展，极大地简化了前端开发流程。\n\n声明式语法是 Vue 的一大特色，它允许开发者通过简洁的模板语法来描述应用程序的数据状态和视图的关系。例如，使用双花括号`{{ }}`进行数据插值，将数据直接渲染到 DOM 中，无需手动操作 DOM 来更新数据展示。像`{{ message }}`会将 Vue 实例中`message`数据的值渲染到对应的 DOM 位置，当`message`数据发生变化时，视图会自动更新。\n\nVue 还拥有丰富的指令系统，以`v-`开头的特殊属性，用于实现各种功能。`v-if`指令可以根据条件动态地渲染或销毁 DOM 元素，`v-for`指令用于遍历数组或对象并生成相应的 DOM 结构，`v-bind`指令用于绑定 HTML 元素的属性等。比如：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<p v-if=\"isShow\">这是根据条件显示的内容\\</p>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(item, index) in items\" :key=\"index\">{{ item }}\\</li>\n\n&#x20;       \\</ul>\n\n&#x20;       \\<img v-bind:src=\"imageUrl\" alt=\"图片\">\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\n&#x20;   export default {\n\n&#x20;       data() {\n\n&#x20;           return {\n\n&#x20;               isShow: true,\n\n&#x20;               items: \\[\'苹果\', \'香蕉\', \'橙子\'],\n\n&#x20;               imageUrl: \'https://example.com/image.jpg\'\n\n&#x20;           };\n\n&#x20;       }\n\n&#x20;   };\n\n\\</script>\n```\n\n在这段代码中，`v-if`根据`isShow`的值决定是否显示`<p>`元素；`v-for`遍历`items`数组并为每个元素生成一个`<li>`列表项；`v-bind:src`将`imageUrl`数据绑定到`<img>`标签的`src`属性上，实现图片路径的动态设置。\n\n组件化开发是 Vue 的核心特性之一，它将整个应用程序拆分成一个个独立的、可复用的组件，每个组件都包含自己的模板、数据、逻辑和样式。这使得代码的结构更加清晰，可维护性和可复用性大大提高。在开发一个电商应用时，可以将商品列表、购物车、导航栏等分别封装成独立的组件，在不同的页面中根据需要进行复用。例如：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<product-list :products=\"productList\">\\</product-list>\n\n&#x20;       \\<shopping-cart :cart-items=\"cartItems\">\\</shopping-cart>\n\n&#x20;       \\<navigation-bar>\\</navigation-bar>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\n&#x20;   import ProductList from \'./components/ProductList.vue\';\n\n&#x20;   import ShoppingCart from \'./components/ShoppingCart.vue\';\n\n&#x20;   import NavigationBar from \'./components/NavigationBar.vue\';\n\n&#x20;   export default {\n\n&#x20;       components: {\n\n&#x20;           ProductList,\n\n&#x20;           ShoppingCart,\n\n&#x20;           NavigationBar\n\n&#x20;       },\n\n&#x20;       data() {\n\n&#x20;           return {\n\n&#x20;               productList: \\[\n\n&#x20;                   { id: 1, name: \'商品1\', price: 100 },\n\n&#x20;                   { id: 2, name: \'商品2\', price: 200 }\n\n&#x20;               ],\n\n&#x20;               cartItems: \\[\n\n&#x20;                   { id: 1, name: \'商品1\', price: 100, quantity: 2 },\n\n&#x20;                   { id: 2, name: \'商品2\', price: 200, quantity: 1 }\n\n&#x20;               ]\n\n&#x20;           };\n\n&#x20;       }\n\n&#x20;   };\n\n\\</script>\n```\n\n在这个例子中，通过导入并注册`ProductList`、`ShoppingCart`和`NavigationBar`组件，在模板中使用这些组件，并向它们传递相应的数据，实现了组件的复用和数据传递。\n\n### 在 Vue 开发中使用 JavaScript\n\n在 Vue 组件中，JavaScript 代码扮演着至关重要的角色，用于实现各种数据处理和交互逻辑。\n\n在数据处理方面，经常需要对从服务器获取的数据进行格式化、过滤或计算等操作。假设从服务器获取到一个包含用户信息的数组，需要根据用户的年龄进行筛选，只显示成年用户（年龄大于等于 18 岁）的信息，可以在 Vue 组件中使用 JavaScript 的`filter`方法来实现：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(user, index) in adultUsers\" :key=\"index\">\n\n&#x20;               {{ user.name }} - {{ user.age }}岁\n\n&#x20;           \\</li>\n\n&#x20;       \\</ul>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\n&#x20;   export default {\n\n&#x20;       data() {\n\n&#x20;           return {\n\n&#x20;               users: \\[\n\n&#x20;                   { name: \'Alice\', age: 20 },\n\n&#x20;                   { name: \'Bob\', age: 15 },\n\n&#x20;                   { name: \'Charlie\', age: 25 }\n\n&#x20;               ]\n\n&#x20;           };\n\n&#x20;       },\n\n&#x20;       computed: {\n\n&#x20;           adultUsers() {\n\n&#x20;               return this.users.filter(user => user.age >= 18);\n\n&#x20;           }\n\n&#x20;       }\n\n&#x20;   };\n\n\\</script>\n```\n\n在上述代码中，通过计算属性`adultUsers`使用`filter`方法对`users`数组进行过滤，返回成年用户的数组，然后在模板中使用`v-for`指令遍历并展示成年用户的信息。\n\n在方法调用方面，Vue 组件中的方法可以用于处理用户事件、调用 API 接口等。以一个简单的登录功能为例，当用户点击登录按钮时，需要验证用户输入的用户名和密码，并向服务器发送登录请求，可以在 Vue 组件中定义一个方法来处理这个逻辑：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<input v-model=\"username\" placeholder=\"用户名\">\n\n&#x20;       \\<input v-model=\"password\" placeholder=\"密码\" type=\"password\">\n\n&#x20;       \\<button @click=\"handleLogin\">登录\\</button>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\n&#x20;   export default {\n\n&#x20;       data() {\n\n&#x20;           return {\n\n&#x20;               username: \'\',\n\n&#x20;               password: \'\'\n\n&#x20;           };\n\n&#x20;       },\n\n&#x20;       methods: {\n\n&#x20;           handleLogin() {\n\n&#x20;               if (this.username && this.password) {\n\n&#x20;                   // 模拟向服务器发送登录请求\n\n&#x20;                   console.log(\'正在登录，用户名：\', this.username, \'，密码：\', this.password);\n\n&#x20;                   // 实际开发中，这里会使用axios等库发送HTTP请求\n\n&#x20;               } else {\n\n&#x20;                   alert(\'请输入用户名和密码\');\n\n&#x20;               }\n\n&#x20;           }\n\n&#x20;       }\n\n&#x20;   };\n\n\\</script>\n```\n\n在这段代码中，`handleLogin`方法首先验证用户名和密码是否为空，若不为空，则模拟向服务器发送登录请求（实际开发中会使用`axios`等库发送真实的 HTTP 请求）；若为空，则弹出提示框要求用户输入用户名和密码。通过`@click`指令将按钮的点击事件绑定到`handleLogin`方法上，实现了用户交互逻辑。\n\n## 实战案例：Vue 与 JavaScript 结合开发\n\n### 案例背景介绍\n\n本案例旨在构建一个电商产品展示页面，为用户提供一个直观、便捷的商品浏览平台。该页面需要展示各类商品的详细信息，包括商品图片、名称、价格、描述等，并支持用户进行商品筛选、排序以及查看商品详情等操作，目标是为用户提供良好的购物体验，提高商品的展示效果和销售转化率。\n\n### 技术选型与搭建\n\n选择 Vue 作为前端框架，主要是因为其轻量级、高效的特点，以及简洁的语法和强大的组件化开发模式，能够大大提高开发效率和代码的可维护性。同时，Vue 拥有丰富的生态系统，如 Vue Router、Vuex 等，方便进行路由管理和状态管理，非常适合构建电商类应用。\n\nJavaScript 作为前端开发的核心语言，用于实现各种复杂的业务逻辑和交互功能，与 Vue 完美结合，能够充分发挥两者的优势。\n\n项目搭建过程中，首先确保本地环境安装了 Node.js 和 npm（Node Package Manager）。然后使用 Vue CLI 快速创建项目，在命令行中执行以下命令：\n\n\n\n```\nnpm install -g @vue/cli\n\nvue create e-commerce-product-showcase\n```\n\n在创建项目的过程中，可以根据项目需求选择默认配置或手动选择特性，如是否使用 TypeScript、是否安装 Vue Router 等。创建完成后，进入项目目录：\n\n\n\n```\ncd e-commerce-product-showcase\n```\n\n接着，安装项目所需的依赖，如用于数据请求的 axios 库：\n\n\n\n```\nnpm install axios\n```\n\n同时，配置开发环境，在`vue.config.js`文件中，可以设置代理、公共路径等，例如：\n\n\n\n```\nmodule.exports = {\n\n&#x20;   publicPath: process.env.NODE\\_ENV === \'production\'? \'/prod/\' : \'/\',\n\n&#x20;   devServer: {\n\n&#x20;       proxy: {\n\n&#x20;           \'/api\': {\n\n&#x20;               target: \'https://api.example.com\',\n\n&#x20;               changeOrigin: true,\n\n&#x20;               pathRewrite: {\n\n&#x20;                   \'^/api\': \'\'\n\n&#x20;               }\n\n&#x20;           }\n\n&#x20;       }\n\n&#x20;   }\n\n};\n```\n\n上述配置中，根据不同的环境（开发环境和生产环境）设置了不同的`publicPath`，并通过代理将`/api`开头的请求转发到指定的目标地址，解决跨域问题。\n\n### 具体实现过程\n\n#### 数据获取与处理\n\n在 Vue 组件中，使用 JavaScript 的 axios 库从 API 获取商品数据。在`src/components/ProductList.vue`组件中：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(product, index) in products\" :key=\"index\">\n\n&#x20;               \\<img :src=\"product.imageUrl\" alt=\"product.name\">\n\n&#x20;               \\<p>{{ product.name }}\\</p>\n\n&#x20;               \\<p>价格：{{ product.price }}\\</p>\n\n&#x20;           \\</li>\n\n&#x20;       \\</ul>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nimport axios from \'axios\';\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           products: \\[]\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProducts();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProducts() {\n\n&#x20;           try {\n\n&#x20;               const response = await axios.get(\'/api/products\');\n\n&#x20;               this.products = response.data;\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n在上述代码中，`mounted`钩子函数在组件挂载后被调用，触发`fetchProducts`方法。`fetchProducts`方法使用`axios.get`发送 HTTP GET 请求到`/api/products`，获取商品数据。如果请求成功，将响应数据赋值给`products`数据属性；如果请求失败，在控制台输出错误信息。获取到数据后，可能需要对数据进行处理，如格式化价格、截取商品描述等。例如，在`ProductList.vue`组件中添加计算属性来格式化价格：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(product, index) in products\" :key=\"index\">\n\n&#x20;               \\<img :src=\"product.imageUrl\" alt=\"product.name\">\n\n&#x20;               \\<p>{{ product.name }}\\</p>\n\n&#x20;               \\<p>价格：{{ formattedPrices\\[index] }}\\</p>\n\n&#x20;           \\</li>\n\n&#x20;       \\</ul>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nimport axios from \'axios\';\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           products: \\[],\n\n&#x20;           formattedPrices: \\[]\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProducts();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProducts() {\n\n&#x20;           try {\n\n&#x20;               const response = await axios.get(\'/api/products\');\n\n&#x20;               this.products = response.data;\n\n&#x20;               this.formatPrices();\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       },\n\n&#x20;       formatPrices() {\n\n&#x20;           this.formattedPrices = this.products.map(product => \\`￥\\${product.price.toFixed(2)}\\`);\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n在这个更新后的代码中，添加了`formattedPrices`数据属性用于存储格式化后的价格。在`fetchProducts`方法获取到商品数据后，调用`formatPrices`方法。`formatPrices`方法使用`map`方法遍历`products`数组，对每个商品的价格进行格式化，将价格转换为以 “￥” 开头并保留两位小数的字符串形式，然后存储到`formattedPrices`数组中。在模板中，通过`formattedPrices[index]`来展示格式化后的价格。\n\n#### 组件化开发\n\n将页面拆分为多个 Vue 组件，提高代码的复用性和可维护性。主要组件包括商品列表组件（`ProductList.vue`）、商品详情组件（`ProductDetail.vue`）、筛选组件（`Filter.vue`）等。\n\n在`ProductList.vue`组件中展示商品列表：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(product, index) in products\" :key=\"index\" @click=\"goToDetail(product.id)\">\n\n&#x20;               \\<img :src=\"product.imageUrl\" alt=\"product.name\">\n\n&#x20;               \\<p>{{ product.name }}\\</p>\n\n&#x20;               \\<p>价格：{{ product.price }}\\</p>\n\n&#x20;           \\</li>\n\n&#x20;       \\</ul>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nimport axios from \'axios\';\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           products: \\[]\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProducts();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProducts() {\n\n&#x20;           try {\n\n&#x20;               const response = await axios.get(\'/api/products\');\n\n&#x20;               this.products = response.data;\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       },\n\n&#x20;       goToDetail(productId) {\n\n&#x20;           this.\\$router.push({ name: \'productDetail\', params: { id: productId } });\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n`ProductDetail.vue`组件用于展示单个商品的详细信息，通过路由参数获取商品 ID，然后从 API 获取商品详情数据：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<img :src=\"product.imageUrl\" alt=\"product.name\">\n\n&#x20;       \\<h2>{{ product.name }}\\</h2>\n\n&#x20;       \\<p>价格：{{ product.price }}\\</p>\n\n&#x20;       \\<p>描述：{{ product.description }}\\</p>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nimport axios from \'axios\';\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           product: {}\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProductDetail();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProductDetail() {\n\n&#x20;           const productId = this.\\$route.params.id;\n\n&#x20;           try {\n\n&#x20;               const response = await axios.get(\\`/api/products/\\${productId}\\`);\n\n&#x20;               this.product = response.data;\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品详情数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n组件之间通过 props 和$emit进行通信。例如，在父组件中传递筛选条件到`Filter.vue`组件，`Filter.vue`组件根据筛选条件筛选商品数据，并将筛选结果通过`$emit\\` 事件传递回父组件：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<select v-model=\"selectedCategory\" @change=\"applyFilter\">\n\n&#x20;           \\<option value=\"\">全部\\</option>\n\n&#x20;           \\<option value=\"electronics\">电子产品\\</option>\n\n&#x20;           \\<option value=\"clothing\">服装\\</option>\n\n&#x20;       \\</select>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nexport default {\n\n&#x20;   props: {\n\n&#x20;       products: Array\n\n&#x20;   },\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           selectedCategory: \'\'\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       applyFilter() {\n\n&#x20;           let filteredProducts;\n\n&#x20;           if (this.selectedCategory === \'\') {\n\n&#x20;               filteredProducts = this.products;\n\n&#x20;           } else {\n\n&#x20;               filteredProducts = this.products.filter(product => product.category === this.selectedCategory);\n\n&#x20;           }\n\n&#x20;           this.\\$emit(\'filter-products\', filteredProducts);\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n在父组件中使用`Filter.vue`组件，并监听`filter-products`事件：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<filter :products=\"products\" @filter-products=\"handleFilter\">\\</filter>\n\n&#x20;       \\<product-list :products=\"filteredProducts\">\\</product-list>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nimport Filter from \'./Filter.vue\';\n\nimport ProductList from \'./ProductList.vue\';\n\nexport default {\n\n&#x20;   components: {\n\n&#x20;       Filter,\n\n&#x20;       ProductList\n\n&#x20;   },\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           products: \\[],\n\n&#x20;           filteredProducts: \\[]\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProducts();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProducts() {\n\n&#x20;           try {\n\n&#x20;               const response = await axios.get(\'/api/products\');\n\n&#x20;               this.products = response.data;\n\n&#x20;               this.filteredProducts = this.products;\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       },\n\n&#x20;       handleFilter(filteredProducts) {\n\n&#x20;           this.filteredProducts = filteredProducts;\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n在上述代码中，`Filter.vue`组件通过`props`接收父组件传递的`products`数组，当用户选择筛选条件时，在`applyFilter`方法中根据筛选条件对`products`进行筛选，并通过`$emit(\'filter-products\', filteredProducts)`将筛选后的结果发送回父组件。父组件在模板中使用`<filter>`标签引入`Filter.vue`组件，并通过`@filter-products=\"handleFilter\"`监听`filter-products`事件，在`handleFilter`方法中接收筛选后的产品数据，并更新`filteredProducts`数据属性，然后将`filteredProducts`传递给`ProductList.vue`组件进行展示。\n\n#### 页面交互与效果\n\n使用 JavaScript 和 Vue 指令实现丰富的页面交互效果。在商品列表中，为每个商品项添加点击事件，当用户点击商品时，跳转到商品详情页面：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(product, index) in products\" :key=\"index\" @click=\"goToDetail(product.id)\">\n\n&#x20;               \\<img :src=\"product.imageUrl\" alt=\"product.name\">\n\n&#x20;               \\<p>{{ product.name }}\\</p>\n\n&#x20;               \\<p>价格：{{ product.price }}\\</p>\n\n&#x20;           \\</li>\n\n&#x20;       \\</ul>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           products: \\[]\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProducts();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProducts() {\n\n&#x20;           try {\n\n&#x20;               const response = await axios.get(\'/api/products\');\n\n&#x20;               this.products = response.data;\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       },\n\n&#x20;       goToDetail(productId) {\n\n&#x20;           this.\\$router.push({ name: \'productDetail\', params: { id: productId } });\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n在上述代码中，通过`@click=\"goToDetail(``product.id``)\"`为每个商品项绑定点击事件，当点击时调用`goToDetail`方法，该方法使用`this.$router.push`方法跳转到`productDetail`路由，并传递商品 ID 作为参数。\n\n在表单验证方面，以商品搜索表单为例，使用 Vue 指令和 JavaScript 逻辑实现输入验证：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<form @submit.prevent=\"searchProducts\">\n\n&#x20;           \\<input v-model=\"searchKeyword\" placeholder=\"请输入搜索关键词\">\n\n&#x20;           \\<button type=\"submit\">搜索\\</button>\n\n&#x20;       \\</form>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           searchKeyword: \'\'\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       searchProducts() {\n\n&#x20;           if (!this.searchKeyword) {\n\n&#x20;               alert(\'请输入搜索关键词\');\n\n&#x20;               return;\n\n&#x20;           }\n\n&#x20;           // 执行搜索逻辑，例如调用API进行搜索\n\n&#x20;           console.log(\'正在搜索:\', this.searchKeyword);\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n在这段代码中，通过`v-model=\"searchKeyword\"`将输入框的值绑定到`searchKeyword`数据属性上。当用户提交表单时，触发`searchProducts`方法，首先验证`searchKeyword`是否为空，如果为空则弹出提示框阻止表单提交；如果不为空，则执行搜索逻辑，这里简单地在控制台输出搜索关键词，实际开发中会调用 API 进行搜索。\n\n### 项目优化与总结\n\n在项目优化方面，主要从代码优化和性能优化两个角度入手。\n\n代码优化上，遵循代码规范，使用 ESLint 等工具进行代码检查，确保代码风格的一致性和规范性，提高代码的可读性和可维护性。对重复代码进行提取和封装，例如将数据请求的逻辑封装成一个独立的函数或模块，在多个组件中复用。以商品数据请求为例，在`src/api/products.js`文件中封装请求函数：\n\n\n\n```\nimport axios from \'axios\';\n\nexport const fetchProducts = async () => {\n\n&#x20;   try {\n\n&#x20;       const response = await axios.get(\'/api/products\');\n\n&#x20;       return response.data;\n\n&#x20;   } catch (error) {\n\n&#x20;       console.error(\'获取商品数据失败:\', error);\n\n&#x20;       throw error;\n\n&#x20;   }\n\n};\n\nexport const fetchProductDetail = async (productId) => {\n\n&#x20;   try {\n\n&#x20;       const response = await axios.get(\\`/api/products/\\${productId}\\`);\n\n&#x20;       return response.data;\n\n&#x20;   } catch (error) {\n\n&#x20;       console.error(\'获取商品详情数据失败:\', error);\n\n&#x20;       throw error;\n\n&#x20;   }\n\n};\n```\n\n在组件中引入并使用这些函数，如在`ProductList.vue`组件中：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(product, index) in products\" :key=\"index\" @click=\"goToDetail(product.id)\">\n\n&#x20;               \\<img :src=\"product.imageUrl\" alt=\"product.name\">\n\n&#x20;               \\<p>{{ product.name }}\\</p>\n\n&#x20;               \\<p>价格：{{ product.price }}\\</p>\n\n&#x20;           \\</li>\n\n&#x20;       \\</ul>\n\n&#x20;   \\</div>\n\n\\</template>\n\n\\<script>\n\nimport { fetchProducts } from \'../api/products.js\';\n\nexport default {\n\n&#x20;   data() {\n\n&#x20;       return {\n\n&#x20;           products: \\[]\n\n&#x20;       };\n\n&#x20;   },\n\n&#x20;   mounted() {\n\n&#x20;       this.fetchProducts();\n\n&#x20;   },\n\n&#x20;   methods: {\n\n&#x20;       async fetchProducts() {\n\n&#x20;           try {\n\n&#x20;               this.products = await fetchProducts();\n\n&#x20;           } catch (error) {\n\n&#x20;               console.error(\'获取商品数据失败:\', error);\n\n&#x20;           }\n\n&#x20;       },\n\n&#x20;       goToDetail(productId) {\n\n&#x20;           this.\\$router.push({ name: \'productDetail\', params: { id: productId } });\n\n&#x20;       }\n\n&#x20;   }\n\n};\n\n\\</script>\n```\n\n这样，当需要修改数据请求逻辑时，只需要在封装的函数中进行修改，而不需要在每个使用该逻辑的组件中逐一修改，降低了代码的维护成本。\n\n性能优化方面，采用路由懒加载技术，当路由被访问时才加载对应的组件，减少初始加载时的代码体积，提高页面加载速度。在`src/router/index.js`文件中配置路由懒加载：\n\n\n\n```\nimport Vue from \'vue\';\n\nimport Router from \'vue-router\';\n\nimport ProductList from \'@/components/ProductList.vue\';\n\nconst ProductDetail = () => import(\'@/components/ProductDetail.vue\');\n\nVue.use(Router);\n\nexport default new Router({\n\n&#x20;   routes: \\[\n\n&#x20;       {\n\n&#x20;           path: \'/\',\n\n&#x20;           name: \'productList\',\n\n&#x20;           component: ProductList\n\n&#x20;       },\n\n&#x20;       {\n\n&#x20;           path: \'/product/:id\',\n\n&#x20;           name: \'productDetail\',\n\n&#x20;           component: ProductDetail\n\n&#x20;       }\n\n&#x20;   ]\n\n});\n```\n\n在上述代码中，`ProductDetail`组件使用了动态导入的方式，即`const ProductDetail = () => import(\'@/components/ProductDetail.vue\');`，这样在初始加载时，`ProductDetail`组件的代码不会被打包进主文件，只有当用户访问`/product/:id`路由时，才会加载`ProductDetail`组件的代码。\n\n同时，对图片进行优化，压缩图片大小、使用合适的图片格式（如 WebP 格式在支持的浏览器中具有更好的压缩比和加载性能），并设置图片的`loading=\"lazy\"`属性，实现图片的懒加载，减少页面初始加载时的请求数量和数据量，提高页面加载速度。在`ProductList.vue`组件中展示商品图片时：\n\n\n\n```\n\\<template>\n\n&#x20;   \\<div>\n\n&#x20;       \\<ul>\n\n&#x20;           \\<li v-for=\"(product, index) in products\" :key=\"index\" @click=\"goToDetail(product.id)\">\n\n&#x20;               \\<img :\n\n\\##未来展望：Vue与JavaScript的发展趋势\n\n\\### 技术发展方向\n\n在未来，Vue有望在性能优化方面取得更大突破。例如，进一步优化虚拟DOM的算法，减少不必要的DOM diff计算，从而提升渲染速度，特别是在处理大规模数据和复杂组件树时，能够显著提高应用的响应性能 。Vue可能会加强对原生Web API的利用，使开发者能够更方便地使用浏览器的新特性，如WebAssembly、WebGL等，拓展Vue应用的功能边界。在生态完善方面，Vue的插件和工具库将更加丰富，为开发者提供更多开箱即用的解决方案，涵盖从项目搭建、开发调试到部署上线的全流程，进一步提升开发效率。\n\nJavaScript则会朝着更强大的功能扩展方向发展。随着ECMAScript标准的不断更新，新的语法和特性将持续涌现，如更完善的异步编程支持、更强大的对象和数组操作方法等，使开发者能够编写更简洁、高效的代码。TypeScript与JavaScript的融合也将更加深入，TypeScript的类型系统将为JavaScript代码提供更严格的类型检查和智能提示，减少运行时错误，提高代码的可维护性和健壮性。JavaScript在跨端开发领域的应用也将不断拓展，与各种移动和桌面平台的结合更加紧密，实现一次编写，多端运行。\n\n\\### 对前端开发的影响\n\nVue和JavaScript的发展将深刻影响前端开发行业。开发模式将逐渐向更高效、更智能的方向变革。低代码/无代码开发平台可能会与Vue和JavaScript深度融合，通过可视化操作和智能代码生成，降低前端开发的门槛，使更多非专业开发者能够参与到前端项目中，同时也让专业开发者能够更专注于复杂业务逻辑和用户体验的优化。\n\n在人才需求方面，对前端开发者的技能要求将更加多元化。除了掌握Vue和JavaScript的核心技术外，开发者还需要了解后端开发、移动开发、人工智能等相关领域的知识，以适应全链路开发和跨端开发的趋势。对具备良好的算法和数据结构基础、能够进行性能优化和安全防护的前端人才的需求也将日益增加。\n```', '/uploads/records/covers/b22d45bd-21fb-48d3-8cf1-7f8d21d28b7b.jpg', 6, 1, 10, 0, 1, '2025-11-30 11:07:19', '2025-11-30 17:24:46');

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
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录分类表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_like
-- ----------------------------
INSERT INTO `record_like` VALUES (2, 7, NULL, '0:0:0:0:0:0:0:1', NULL);
INSERT INTO `record_like` VALUES (7, 1, NULL, '0:0:0:0:0:0:0:1', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_tag
-- ----------------------------
INSERT INTO `record_tag` VALUES (1, 'Vue', 14, '2025-11-27 12:04:11', '#E6A23C');
INSERT INTO `record_tag` VALUES (2, 'Spring Boot', 8, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (3, 'MySQL', 6, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (4, '旅行攻略', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (5, '读书笔记', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (6, '美食探店', 7, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (7, 'Docker', 4, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (8, '生活随想', 3, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (9, 'JavaScript', 10, '2025-11-27 12:04:11', '#67C23A');
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
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录-标签关联表' ROW_FORMAT = Dynamic;

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
INSERT INTO `record_tag_relation` VALUES (22, 11, 1);
INSERT INTO `record_tag_relation` VALUES (23, 11, 9);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '网站访问统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of site_visit
-- ----------------------------
INSERT INTO `site_visit` VALUES (1, '2025-11-29', 3, '2025-11-29 13:06:39', '2025-11-29 13:55:18');
INSERT INTO `site_visit` VALUES (2, '2025-11-30', 1, '2025-11-30 10:14:03', '2025-11-30 10:14:03');

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Dawn', '3095882640@qq.com', '4b4baedff8691e5b9a01275beab4de0e', 1, 'http://localhost:9999/uploads/avatars/5715695f-4d1e-4ccb-be2d-722f62eae8e9.jpg', '时光不语，却回答了所有问题', '2025-11-26 14:54:01', '2025-11-30 13:27:41', 115, 2, 1);
INSERT INTO `user` VALUES (2, '测试用户', 'sara@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sara', '简介测试', '2025-11-26 16:08:14', '2025-11-30 10:14:18', 25, 1, 0);
INSERT INTO `user` VALUES (3, '江硕', 'jiangshuo@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=jiangshuo', '前端开发者', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (4, '经年未远', 'jingnianyuan@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=jingnianyuan', '学习中', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (5, '代码小王子', 'coder@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=coder', 'Vue开发者', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (6, '前端小白', 'xiaobai@test.com', 'e10adc3949ba59abbe56e057f20f883e', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=xiaobai', '正在学习前端', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (7, 'ex', 'ex@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=ex', '路人甲', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 0, 1, 0);
INSERT INTO `user` VALUES (8, '用户582039', '19839433499@163.com', 'e517bb455e88ffaa1a1dc47a8bad3b35', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=用户582039', '', '2025-11-27 14:23:02', '2025-11-27 14:23:02', 0, 1, 0);

SET FOREIGN_KEY_CHECKS = 1;
