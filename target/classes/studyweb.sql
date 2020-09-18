
SET names gbk;

DROP database if EXISTS studyweb;
create database if NOT EXISTS studyweb;
use studyweb;

/*教室表*/
DROP TABLE IF EXISTS `clsroom`;
CREATE TABLE `clsroom` (
  `clsroom_id` int(11) NOT NULL AUTO_INCREMENT,
  `clsroom_name` varchar(255) DEFAULT NULL,
  `clsroom_status` int(11) DEFAULT '1',
  PRIMARY KEY (`clsroom_id`),
  UNIQUE KEY `clsroom_name` (`clsroom_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO clsroom(clsroom_name) VALUES ('教室1');
INSERT INTO clsroom(clsroom_name) VALUES ('教室2');
INSERT INTO clsroom(clsroom_name) VALUES ('教室3');
INSERT INTO clsroom(clsroom_name) VALUES ('教室4');
INSERT INTO clsroom(clsroom_name) VALUES ('教室5');


/*教师表*/
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL AUTO_INCREMENT,
  `teacher_name` varchar(50) NOT NULL,
  `teacher_pwd` varchar(32) NOT NULL,
  `teacher_nickname` varchar(50) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `teacher_status` int(11) DEFAULT '1',
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `teacher_nickname` (`teacher_nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO teacher(teacher_name,teacher_pwd,teacher_nickname,role_id,teacher_status) VALUES ('adminA','8C7E1F3B1B787EC9F24FCC01E243E072','任丹丹',1,1);
INSERT INTO teacher(teacher_name,teacher_pwd,teacher_nickname,role_id,teacher_status) VALUES ('adminB','8C7E1F3B1B787EC9F24FCC01E243E072','钱前',2,1);
INSERT INTO teacher(teacher_name,teacher_pwd,teacher_nickname,role_id,teacher_status) VALUES ('adminC','8C7E1F3B1B787EC9F24FCC01E243E072','郑娇',1,1);
INSERT INTO teacher(teacher_name,teacher_pwd,teacher_nickname,role_id,teacher_status) VALUES ('adminD','8C7E1F3B1B787EC9F24FCC01E243E072','叶林新雷',2,1);
INSERT INTO teacher(teacher_name,teacher_pwd,teacher_nickname,role_id,teacher_status) VALUES ('adminE','8C7E1F3B1B787EC9F24FCC01E243E072','占中心',2,1);


/*班级表*/
DROP TABLE IF EXISTS `cls`;
CREATE TABLE `cls` (
  `cls_id` int(20) NOT NULL AUTO_INCREMENT,
  `cls_name` varchar(255) DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `clsroom_id` int(11) DEFAULT NULL,
  `cls_status` int(11) DEFAULT '1',
  PRIMARY KEY (`cls_id`),
  UNIQUE KEY `cls_name` (`cls_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

insert into cls(cls_name,teacher_id,manager_id,clsroom_id) values('42期',5,1,1);
insert into cls(cls_name,teacher_id,manager_id,clsroom_id) values('43期',4,1,5);
insert into cls(cls_name,teacher_id,manager_id,clsroom_id) values('44期',4,3,4);
insert into cls(cls_name,teacher_id,manager_id,clsroom_id) values('45期',4,3,3);
insert into cls(cls_name,teacher_id,manager_id,clsroom_id) values('46期',5,1,2);

/*问题内容表*/
DROP TABLE IF EXISTS `questiontype`;
CREATE TABLE `questiontype` (
  `questiontype_id` int(11) NOT NULL AUTO_INCREMENT,
  `questiontype_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`questiontype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


INSERT INTO `questiontype` VALUES (1,'技术问答'),(2,'面试题'),(3,'作业问答');

/*问题表*/
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_title` varchar(100) DEFAULT NULL,
  `question_content` text,
  `question_typeid` int(11) DEFAULT NULL,
  `question_tag1` varchar(20) DEFAULT NULL,
  `question_tag2` varchar(20) DEFAULT NULL,
  `question_tag3` varchar(20) DEFAULT NULL,
  `question_userid` int(11) DEFAULT NULL,
  `question_votenum` int(11) DEFAULT '0',
  `question_answernum` int(11) DEFAULT '0',
  `question_viewnum` int(11) DEFAULT '0',
  `question_status` int(11) DEFAULT '0',
  `question_createtime` datetime DEFAULT NULL,
  `question_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

insert into question(question_title,question_content,question_userid, question_votenum, question_answernum, question_viewnum, question_status, question_createtime)
				values('测试一下分页','分页有了',1,5,9,19,1,now());
insert into question(question_title,question_content,question_userid, question_votenum, question_answernum, question_viewnum, question_status, question_createtime)
				values('测试一下新增','新增有了',2,5,9,19,1,now());
insert into question(question_title,question_content,question_userid, question_votenum, question_answernum, question_viewnum, question_status, question_createtime)
				values('测试一下','分页有了',3,5,9,19,1,now());
insert into question(question_title,question_content,question_userid, question_votenum, question_answernum, question_viewnum, question_status, question_createtime)
				values('测试一下统计图','图有了',2,5,5,19,1,now());				
/*答案表*/
DROP TABLE IF EXISTS `answer`;

CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_questionid` int(11) DEFAULT NULL,
  `answer_content` text,
  `answer_createtime` datetime DEFAULT NULL,
  `answer_userid` int(11) DEFAULT NULL,
  `answer_vote` int(11) DEFAULT '0',
  `answer_status` int(11) DEFAULT '0',
  `answer_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`answer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

insert into answer(answer_questionid,answer_content, answer_createtime, answer_userid, answer_vote, answer_status)
				values(2,"这是一个测试答案",now(),1,5,1);
insert into answer(answer_questionid,answer_content, answer_createtime, answer_userid, answer_vote, answer_status)
				values(2,"这是一个测试答案",now(),2,6,1);
insert into answer(answer_questionid,answer_content, answer_createtime, answer_userid, answer_vote, answer_status)
				values(3,"这是一个测试答案",now(),3,6,1);
insert into answer(answer_questionid,answer_content, answer_createtime, answer_userid, answer_vote, answer_status)
				values(4,"这是一个测试答案",now(),1,5,1);	
insert into answer(answer_questionid,answer_content, answer_createtime, answer_userid, answer_vote, answer_status)
				values(3,"这是一个测试答案",now(),1,5,1);					
/*权限表*/
DROP TABLE IF EXISTS `rights`;
CREATE TABLE `rights` (
  `right_id` int(11) NOT NULL AUTO_INCREMENT,
  `right_name` varchar(30) DEFAULT NULL,
  `right_url` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`right_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

insert into rights(right_id,right_name,right_url) values(10,'教室查看','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(11,'教室新增','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(12,'教室修改','/basic/addcls');
insert into rights(right_id,right_name,right_url) values(13,'教室恢复删除','/basic/updatecls');

insert into rights(right_id,right_name,right_url) values(20,'用户查看','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(21,'用户新增','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(22,'用户修改','/basic/addcls');
insert into rights(right_id,right_name,right_url) values(23,'用户删除','/basic/updatecls');

insert into rights(right_id,right_name,right_url) values(30,'班级查看','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(31,'班级新增','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(32,'班级修改','/basic/addcls');
insert into rights(right_id,right_name,right_url) values(33,'班级删除','/basic/updatecls');


insert into rights(right_id,right_name,right_url) values(40,'员工查看','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(41,'员工新增','/basic/editcls');
insert into rights(right_id,right_name,right_url) values(42,'员工修改','/basic/addcls');
insert into rights(right_id,right_name,right_url) values(43,'员工删除','/basic/updatecls');

/*角色表*/
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

insert into role(role_name) values('讲师');
insert into role(role_name) values('班主任');
insert into role(role_name) values('咨询师');
insert into role(role_name) values('教学经理');
insert into role(role_name) values('校长');

/*角色权限表*/
DROP TABLE IF EXISTS `role_rights`;
CREATE TABLE `role_rights` (
  `role_id` int(11) NOT NULL DEFAULT '0',
  `right_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

insert into role_rights values(1,10);
insert into role_rights values(1,12);
insert into role_rights values(1,13);


/*用户表*/
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) DEFAULT 'Lion King',
  `user_login` varchar(30) DEFAULT NULL,
  `user_passwd` varchar(32) DEFAULT '8C7E1F3B1B787EC9F24FCC01E243E072',
  `user_telephone` char(11) DEFAULT NULL,
  `user_status` tinyint(3) unsigned DEFAULT '1',
  `user_additional` varchar(90) DEFAULT NULL,
  `user_head` varchar(30) DEFAULT 'header3.jpeg',
  `user_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cls_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_login` (`user_login`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `userinfo` VALUES (1,'汤姆','tomcat','8C7E1F3B1B787EC9F24FCC01E243E072','13613361987',0,NULL,'header1.jpg','2019-10-21 19:45:29',2);
INSERT INTO `userinfo` VALUES (2,'管理员','admin666','8C7E1F3B1B787EC9F24FCC01E243E072','13813381234',0,NULL,'header2.png','2019-10-21 19:45:29',3);

INSERT INTO `userinfo` VALUES (3,'露西','lucy','8C7E1F3B1B787EC9F24FCC01E243E072','18813361987',1,NULL,'header3.jpeg','2019-10-21 19:45:29',1);
INSERT INTO `userinfo` VALUES (4,'阿利弗','alif','8C7E1F3B1B787EC9F24FCC01E243E072','18813381234',1,NULL,'header3.jpeg','2019-10-21 19:45:29',2);
--

/*投票记录表*/
DROP TABLE IF EXISTS `votehistory`;
CREATE TABLE `votehistory` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_questionid` int(11) DEFAULT NULL,
  `history_answerid` int(11) DEFAULT NULL,
  `history_userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
insert into votehistory(history_questionid,history_answerid,history_userid) values(1,2,3);
insert into votehistory(history_questionid,history_answerid,history_userid) values(3,2,1);
insert into votehistory(history_questionid,history_answerid,history_userid) values(2,3,4);
insert into votehistory(history_questionid,history_answerid,history_userid) values(4,3,2);
