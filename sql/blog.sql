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

 Date: 29/11/2025 11:23:06
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '签到记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in
-- ----------------------------
INSERT INTO `check_in` VALUES (1, 1, '2025-11-29', 10, 1, '2025-11-29 11:05:33');

-- ----------------------------
-- Table structure for essay
-- ----------------------------
DROP TABLE IF EXISTS `essay`;
CREATE TABLE `essay`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '随笔ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '随笔内容',
  `images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片URL，多张用逗号分隔',
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
INSERT INTO `essay` VALUES (1, 1, '🌟送大家一片星空🌟\n\n☀️ ☁️ 🌍 • 🌈 🌙 • ⬛⬛⬛ 🚀 ☆☆ ★\n\n✨ · · · · · ★ · ▁▂▃▄▅▆▇██▇▆▅▄▃▂▁ · ★', NULL, 6, '2025-10-17 10:30:00', '2025-11-29 11:18:18');
INSERT INTO `essay` VALUES (2, 1, '有点过于无敌了...', 'https://picsum.photos/400/200?random=1', 4, '2025-04-20 15:20:00', '2025-11-29 11:18:19');
INSERT INTO `essay` VALUES (3, 1, '杀神，回来了。', 'https://picsum.photos/400/250?random=2', 6, '2025-04-13 09:00:00', '2025-11-29 11:18:19');
INSERT INTO `essay` VALUES (4, 1, '今天学习了Vue3的组合式API，感觉比Vue2的选项式API更加灵活，代码组织也更清晰了！分享给大家～', NULL, 4, '2025-04-10 14:00:00', '2025-11-29 11:18:20');

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
INSERT INTO `essay_comment` VALUES (1, 3, 7, 0, NULL, '🐶', NULL, '2025-06-07 10:00:00');
INSERT INTO `essay_comment` VALUES (2, 3, 7, 0, NULL, '好漂亮的博客', NULL, '2025-06-07 10:05:00');
INSERT INTO `essay_comment` VALUES (3, 3, 3, 0, NULL, '大佬带带我', NULL, '2025-05-14 16:30:00');
INSERT INTO `essay_comment` VALUES (4, 3, 4, 3, NULL, '带带弟弟', NULL, '2025-05-26 11:00:00');
INSERT INTO `essay_comment` VALUES (5, 3, 4, 3, 4, '想学习啊', NULL, '2025-05-26 11:05:00');
INSERT INTO `essay_comment` VALUES (6, 4, 6, 0, NULL, '大佬能出个教程吗？', NULL, '2025-04-11 09:30:00');
INSERT INTO `essay_comment` VALUES (10, 1, 1, 0, NULL, '😂', NULL, '2025-11-26 16:14:45');
INSERT INTO `essay_comment` VALUES (11, 4, 1, 0, NULL, '1', 'http://localhost:9999/uploads/essays/b184b1a8-a48e-4df1-831f-af4bdb2f7cb8.png', '2025-11-26 16:20:46');
INSERT INTO `essay_comment` VALUES (12, 2, 1, 0, NULL, NULL, 'http://localhost:9999/uploads/essays/568ab33e-51e0-4707-8dfe-eecd9c0b6f11.jpg', '2025-11-26 16:20:59');
INSERT INTO `essay_comment` VALUES (13, 2, 1, 0, NULL, '', 'http://localhost:9999/uploads/essays/3bbfe830-a9de-4bb1-abe2-841720e51049.png', '2025-11-26 16:21:46');
INSERT INTO `essay_comment` VALUES (14, 1, 1, 0, NULL, NULL, 'http://localhost:9999/uploads/essays/20ba1d5e-d56c-41c6-b0f8-9c0a9d773cdf.jpg', '2025-11-26 16:25:27');
INSERT INTO `essay_comment` VALUES (15, 2, 1, 0, NULL, '123', NULL, '2025-11-26 16:25:38');
INSERT INTO `essay_comment` VALUES (16, 3, 1, 0, NULL, '666', NULL, '2025-11-26 16:25:52');
INSERT INTO `essay_comment` VALUES (17, 4, 1, 0, NULL, 'cs', NULL, '2025-11-26 16:29:20');
INSERT INTO `essay_comment` VALUES (18, 4, 1, 11, NULL, '123', NULL, '2025-11-26 16:29:27');
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
INSERT INTO `level` VALUES (2, '初露锋芒', 100, '🌿', '#4caf50', '开始崭露头角');
INSERT INTO `level` VALUES (3, '小有名气', 300, '🌳', '#2196f3', '已经小有名气了');
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
INSERT INTO `record` VALUES (1, 'Vue3 组合式 API 深度解析', '详细介绍 Vue3 Composition API 的使用方法，包括 setup、ref、reactive、computed 等核心概念...', '# \n\n## 1、Java多态，子类父类中类的加载顺序\n\n(1) 父类静态代码块(包括静态初始化块，静态属性，但不包括静态方法) \n\n(2) 子类静态代码块(包括静态初始化块，静态属性，但不包括静态方法  )\n\n(3) 父类非静态代码块(  包括非静态初始化块，非静态属性  )\n\n(4) 父类构造函数\n\n(5) 子类非静态代码块  (  包括非静态初始化块，非静态属性  )\n\n(6) 子类构造函数\n\n例：下面代码的输出是什么？\n\n```java\n public class Base\n    {\n        private String baseName = \"base\";\n        public Base()\n        {\n            callName();\n        }\n\n        public void callName()\n        {\n            System. out. println(baseName);\n        }\n\n        static class Sub extends Base\n        {\n            private String baseName = \"sub\";\n            public void callName()\n            {\n                System. out. println (baseName) ;\n            }\n        }\n        public static void main(String[] args)\n        {\n            Base b = new Sub();\n        }\n    }\n```\n\n答案：null\n\n## 2、JVM操作指令\n\n- **jinfo**：查看或修改JVM运行时参数（如系统属性、启动参数），不涉及内存映像。\n- **jhat**：分析已生成的堆转储文件（如.hprof），提供HTTP服务展示内存分析结果，但本身不生成内存映像。\n- **jstat**：监控JVM运行时统计信息（如GC次数、堆内存使用率），仅提供动态数据，不生成完整内存映像。\n- **jmap**：生成JVM堆转储快照（heap dump），并提供堆内存的详细信息，包括对象分布、内存使用率、垃圾收集器配置等。**适用场景**：分析内存泄漏、查看对象内存占用、诊断内存溢出问题。\n\n## 3、Map\n\nHashMap，是map的默认实现类，每个元素由 `key` 和 `value` 组成，`key` 唯一（不可重复），`value` 可重复。是无序的。允许 1 个 `null` 键和多个 `null` 值。\n\nLinkedHashMap，可保证插入 / 访问顺序。不允许 `null` 键和 `null` 值。\n\nTreeMap，有序，不允许 `null` 键（会抛 `NullPointerException`），但允许 `null` 值。\n\nHashtable，允许 `null` 键和 `null` 值。\n\n|      实现类       |        底层结构         |                           特点                           | 线程安全 |\n| :---------------: | :---------------------: | :------------------------------------------------------: | :------: |\n|      HashMap      |    数组+链表+红黑树     | 查找效率高（平均O（1）），无序，jdk1.8优化了哈希冲突处理 |    否    |\n|   LinkedHashMap   |     哈希表+双向链表     |   继承HashMap，保留插入顺序或访问顺序（可用于LRU缓存）   |    否    |\n|      TreeMap      |         红黑树          |   键按自然顺序或自定义比较器排序，查找/插入O（log n）    |    否    |\n|     Hashtable     |        数组+链表        |            古老实现，性能较差，不允许null键值            | 是(低效) |\n| ConcurrentHashMap | 分段锁 / CAS（JDK 1.8） |            线程安全，高效并发，支持多线程操作            |    是    |\n\n## 4、“先进先出”的容器是\n\n**例：“先进先出”的容器是：( )**\n\n**A、堆栈(Stack)**\n\n**B、队列（Queue）**\n\n**C、字符串(String)**\n\n**D、迭代器(Iterator)**\n\n堆栈(Stack)错误：堆栈是\"后进先出\"（LIFO）的数据结构，最后压入栈的元素会最先被弹出，这与\"先进先出\"的特性相反。\n\n字符串(String)错误：字符串是用于存储字符序列的数据类型，它并不具有\"先进先出\"的特性。字符串的访问可以是随机的，不遵循任何进出顺序。\n\n 迭代器(Iterator)错误：迭代器是一种用于遍历集合的工具，它提供了按特定顺序访问集合元素的方法，但本身并不是一个存储容器，也不具备\"先进先出\"的特性。\n\n\"先进先出\"是队列（Queue）这种数据结构的核心特征，所以B是正确答案。队列的工作原理是：第一个进入队列的元素会第一个被处理和移出，就像排队买票一样，先到的人先买票离开。\n\n## 5、Java与C++对比\n\nJava完全取消了指针的概念,这是Java相对C++的一个重要区别。Java中的引用可以理解为受限的指针,但它不允许直接进行指针运算和操作。\n\nJava的垃圾回收机制(Garbage Collection)是自动进行的,不是程序结束时才回收。当JVM发现某些对象不再被引用时,就会将其标记并在合适的时机进行回收,这个过程是动态的、持续的。\n\nJava和C++都有三个特征：封装、继承和多态。\n\n## 6、i++与++i\n\n**i++执行逻辑：**先使用变量 `i` 当前的值参与表达式运算，然后再将 `i` 的值加 1。\n\n**++i执行逻辑：**先将变量 `i` 的值加 1，然后再使用更新后的值参与表达式运算。\n\n例：下方代码的输出结果是： 			结束是：0\n\n```java\npackage algorithms.com.guan.javajicu;\npublic class Inc { \n  public static void main(String[] args) { \n    Inc inc = new Inc(); \n    int i = 0; \n    inc.fermin(i); \n    i= i ++; \n    System.out.println(i);\n  \n  } \n  void fermin(int i){ \n    i++; \n  }\n}\n```\n\n## 7、Java面向对象\n\nJava是纯面向对象语言，所有代码必须定义在类中，不存在独立的“过程”或“函数”。\n\n方法必须隶属于类或对象，不能单独存在。\n\n非静态方法属于实例成员（对象），而静态方法才属于类成员。\n\n虽然Java方法必须属于类或对象，但调用方式与C/C++不同：\n\n​	Java需通过类名（静态方法）或对象（实例方法）调用。\n\n​	C/C++允许独立调用函数或过程。\n\n## 8、\n\n\n\n', 'https://picsum.photos/400/200?random=1', 6, 1, 1317, 157, 1, '2025-11-25 10:00:00', '2025-11-28 16:56:40');
INSERT INTO `record` VALUES (2, 'Spring Boot 3.0 新特性总结', 'Spring Boot 3.0 带来了许多激动人心的新特性，包括对 Java 17 的原生支持、GraalVM 原生镜像...', '## 引言\r\n\r\nSpring Boot 3.0 是一个里程碑式的版本，带来了众多令人兴奋的新特性和改进。本文将详细介绍这些变化。\r\n\r\n![Spring Boot](https://spring.io/img/projects/spring-boot.svg)\r\n\r\n## 一、Java 17 基线\r\n\r\nSpring Boot 3.0 要求最低 **Java 17**，这意味着我们可以使用许多新特性：\r\n\r\n- **Records** - 简洁的数据类\r\n- **Pattern Matching** - 模式匹配\r\n- **Sealed Classes** - 密封类\r\n- **Text Blocks** - 文本块\r\n\r\n> 💡 **提示**：升级到 Java 17 不仅能使用新特性，还能获得更好的性能和安全性。\r\n\r\n### 1.1 Records 示例\r\n\r\n```java\r\npublic record User(String name, int age, String email) {\r\n    // 自动生成 getter、equals、hashCode、toString\r\n}\r\n\r\n// 使用\r\nUser user = new User(\"张三\", 25, \"zhangsan@example.com\");\r\nSystem.out.println(user.name()); // 张三\r\n1.2 Pattern Matching\r\n二、Jakarta EE 9+\r\n从 javax.* 迁移到 jakarta.* 命名空间，这是最大的破坏性变更：\r\n\r\n旧包名	新包名\r\njavax.servlet	jakarta.servlet\r\njavax.persistence	jakarta.persistence\r\njavax.validation	jakarta.validation\r\njavax.annotation	jakarta.annotation\r\n三、GraalVM 原生镜像支持\r\nSpring Boot 3.0 提供了一流的 GraalVM 原生镜像支持：\r\n\r\n优势对比\r\n指标	JVM 模式	Native 模式\r\n启动时间	~2秒	~0.05秒\r\n内存占用	~200MB	~50MB\r\n打包大小	~20MB	~70MB\r\n⚡ 性能提升：原生镜像启动时间可以从秒级降到毫秒级，非常适合 Serverless 场景！\r\n\r\n四、可观测性增强\r\n新增 Micrometer 和 Micrometer Tracing 支持：\r\n\r\n支持的追踪系统\r\nZipkin\r\nWavefront\r\nOpenTelemetry\r\nJaeger\r\n五、HTTP 接口客户端\r\n声明式 HTTP 客户端，类似 Feign：\r\n\r\n总结\r\nSpring Boot 3.0 是现代 Java 开发的重要升级，主要改进包括：\r\n\r\nJava 17 基线\r\nJakarta EE 9+ 迁移\r\nGraalVM 原生镜像支持\r\n可观测性增强\r\n声明式 HTTP 客户端\r\n建议尽快升级体验新特性！ 🚀\r\n\r\n参考文档：Spring Boot 3.0 Release Notes', 'https://picsum.photos/400/200?random=2', 7, 1, 929, 99, 1, '2025-11-20 14:30:00', '2025-11-28 15:17:28');
INSERT INTO `record` VALUES (3, '周末京都赏枫之旅', '趁着深秋时节，来了一场说走就走的京都之旅。清水寺的红叶美得让人窒息，仿佛置身于画中...', NULL, 'https://picsum.photos/400/200?random=3', 18, 1, 2102, 345, 1, '2025-11-18 09:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (4, '《代码整洁之道》读书笔记', 'Robert C. Martin 的经典著作，教会我们如何写出优雅、可维护的代码。以下是我的读书心得...', NULL, 'https://picsum.photos/400/200?random=4', 15, 1, 562, 78, 1, '2025-11-15 16:00:00', '2025-11-29 11:18:04');
INSERT INTO `record` VALUES (5, '自制提拉米苏蛋糕', '第一次尝试在家做提拉米苏，没想到效果出奇的好！分享一下详细的制作步骤和一些小技巧...', NULL, 'https://picsum.photos/400/200?random=5', 23, 1, 1560, 234, 1, '2025-11-12 11:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (6, '今日份的好心情', '阳光正好，微风不燥。在咖啡馆坐了一下午，看着窗外的人来人往，突然觉得生活也挺美好的...', NULL, NULL, 12, 1, 421, 89, 1, '2025-11-10 15:00:00', '2025-11-28 15:18:08');
INSERT INTO `record` VALUES (7, 'MySQL 索引优化实战', '记录一次线上数据库慢查询优化的完整过程，从分析执行计划到创建合适的索引...', NULL, 'https://picsum.photos/400/200?random=7', 8, 1, 781, 113, 1, '2025-11-08 10:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (8, '上海城市漫步：武康路一日游', '漫步在梧桐树下的武康路，感受老上海的优雅与浪漫。这里的每一栋老洋房都有自己的故事...', NULL, 'https://picsum.photos/400/200?random=8', 19, 1, 1890, 267, 1, '2025-11-05 09:30:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (9, 'Docker 容器化部署指南', '从零开始学习 Docker，包括镜像构建、容器管理、Docker Compose 编排等核心内容...', NULL, 'https://picsum.photos/400/200?random=9', 9, 1, 920, 134, 1, '2025-11-01 14:00:00', '2025-11-28 15:09:30');
INSERT INTO `record` VALUES (10, '探店：藏在巷子里的宝藏面馆', '朋友推荐的一家老面馆，店面不大但味道绝了！招牌的红烧牛肉面，汤头浓郁，面条劲道...', NULL, 'https://picsum.photos/400/200?random=10', 21, 1, 2340, 389, 1, '2025-10-28 12:00:00', '2025-11-28 15:09:30');

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录点赞表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record_like
-- ----------------------------
INSERT INTO `record_like` VALUES (2, 7, NULL, '0:0:0:0:0:0:0:1', NULL);
INSERT INTO `record_like` VALUES (4, 1, NULL, '0:0:0:0:0:0:0:1', NULL);
INSERT INTO `record_like` VALUES (6, 2, NULL, '0:0:0:0:0:0:0:1', NULL);

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
INSERT INTO `record_tag` VALUES (1, 'Vue', 12, '2025-11-27 12:04:11', '#E6A23C');
INSERT INTO `record_tag` VALUES (2, 'Spring Boot', 8, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (3, 'MySQL', 6, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (4, '旅行攻略', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (5, '读书笔记', 5, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (6, '美食探店', 7, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (7, 'Docker', 4, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (8, '生活随想', 3, '2025-11-27 12:04:11', '#409EFF');
INSERT INTO `record_tag` VALUES (9, 'JavaScript', 8, '2025-11-27 12:04:11', '#409EFF');
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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '记录-标签关联表' ROW_FORMAT = Dynamic;

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
INSERT INTO `record_tag_relation` VALUES (14, 10, 6);

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
  `level` int(0) NULL DEFAULT 1 COMMENT '用户等级 1-5',
  `exp` int(0) NULL DEFAULT 0 COMMENT '经验值',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '新人' COMMENT '用户称号',
  `role` tinyint(0) NOT NULL DEFAULT 0 COMMENT '角色：0-普通用户，1-管理员',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE,
  UNIQUE INDEX `uk_email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Dawn', '3095882640@qq.com', '4b4baedff8691e5b9a01275beab4de0e', 1, 'http://localhost:9999/uploads/avatars/5715695f-4d1e-4ccb-be2d-722f62eae8e9.jpg', '时光不语，却回答了所有问题', '2025-11-26 14:54:01', '2025-11-29 11:05:33', 1, 10, '太乙玉仙', 1);
INSERT INTO `user` VALUES (2, 'Sara', 'sara@test.com', 'e10adc3949ba59abbe56e057f20f883e', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=Sara', '热爱生活', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 5, 0, '太乙玉仙', 0);
INSERT INTO `user` VALUES (3, '江硕', 'jiangshuo@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=jiangshuo', '前端开发者', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 4, 0, '金仙', 0);
INSERT INTO `user` VALUES (4, '经年未远', 'jingnianyuan@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=jingnianyuan', '学习中', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 1, 0, '大乘', 0);
INSERT INTO `user` VALUES (5, '代码小王子', 'coder@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=coder', 'Vue开发者', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 3, 0, '渡劫', 0);
INSERT INTO `user` VALUES (6, '前端小白', 'xiaobai@test.com', 'e10adc3949ba59abbe56e057f20f883e', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=xiaobai', '正在学习前端', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 1, 0, '练气', 0);
INSERT INTO `user` VALUES (7, 'ex', 'ex@test.com', 'e10adc3949ba59abbe56e057f20f883e', 1, 'https://api.dicebear.com/7.x/avataaars/svg?seed=ex', '路人甲', '2025-11-26 16:08:14', '2025-11-26 16:08:14', 1, 0, '大乘', 0);
INSERT INTO `user` VALUES (8, '用户582039', '19839433499@163.com', 'e517bb455e88ffaa1a1dc47a8bad3b35', 0, 'https://api.dicebear.com/7.x/avataaars/svg?seed=用户582039', '', '2025-11-27 14:23:02', '2025-11-27 14:23:02', 1, 0, '新人', 0);

SET FOREIGN_KEY_CHECKS = 1;
