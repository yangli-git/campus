/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.7.23 : Database - campushelp
*********************************************************************
*/
USE `campushelp`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `aId` int(6) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '123456',
  `name` varchar(255) NOT NULL DEFAULT 'name',
  `addTime` datetime(6) NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `school` */

DROP TABLE IF EXISTS `school`;

CREATE TABLE `school` (
  `schoolId` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'schoolName',
  `addTime` datetime(6) NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `task` */

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
  `state` int(2) NOT NULL DEFAULT '0' COMMENT '任务状态',
  PRIMARY KEY (`taskid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Table structure for table `user` */

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
  PRIMARY KEY (`stuid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

