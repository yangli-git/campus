/*
 Navicat Premium Data Transfer

 Source Server         : school
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : localhost:3306
 Source Schema         : campus

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 14/03/2021 00:36:50   含有数据
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `aId` int(6) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '123456',
  `name` varchar(255) NOT NULL DEFAULT 'name',
  `addTime` datetime(6) NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES (1, 'yangli', '123456', 'yangli', '2021-03-14 00:32:00.000000', 0);
COMMIT;

-- ----------------------------
-- Table structure for school
-- ----------------------------
DROP TABLE IF EXISTS `school`;
CREATE TABLE `school` (
  `schoolId` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'schoolName',
  `addTime` datetime(6) NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of school
-- ----------------------------
BEGIN;
INSERT INTO `school` VALUES (1, '武汉轻工大学', '2021-03-14 00:35:49.000000', 0);
INSERT INTO `school` VALUES (2, '武汉理工大学', '2021-03-14 00:36:06.000000', 0);
COMMIT;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `taskId` int(8) NOT NULL AUTO_INCREMENT,
  `publish_user_id` varchar(255) NOT NULL COMMENT '发布用户学号',
  `publish_user_name` varchar(255) NOT NULL,
  `publish_school_id` int(6) NOT NULL COMMENT '发布用户学校ID',
  `accept_user_id` int(11) NOT NULL DEFAULT '0',
  `reward` double(30,0) NOT NULL DEFAULT '0' COMMENT '任务奖励',
  `addTime` datetime(6) NOT NULL COMMENT '发布时间',
  `endTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `taskName` varchar(255) NOT NULL COMMENT '任务名称',
  `taskContext` varchar(255) NOT NULL COMMENT '任务描述',
  `state` int(2) NOT NULL DEFAULT '0' COMMENT '任务状态,-1暂存 0 已完成 1 解决中 2 待解决',
  PRIMARY KEY (`taskId`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `stuId` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` varchar(20) NOT NULL DEFAULT '' COMMENT '学号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `schoolId` int(6) NOT NULL,
  `sex` int(2) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT 'name',
  `registerTime` datetime(6) NOT NULL COMMENT '注册时间',
  `money` double(20,0) NOT NULL DEFAULT '0',
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stuId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, '1705110115', '123456', 1, 0, '张三', '2021-03-14 00:34:21.000000', 20, 0);
INSERT INTO `user` VALUES (2, '1705110116', '123456', 1, 0, '李四', '2021-03-14 00:35:02.000000', 20, 0);
INSERT INTO `user` VALUES (3, '1705110117', '123456', 2, 0, '王五', '2021-03-14 00:35:28.000000', 0, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
