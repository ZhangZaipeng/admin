
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_merchant_config
-- ----------------------------
DROP TABLE IF EXISTS `tb_merchant_config`;
CREATE TABLE `tb_merchant_config`  (
  `config_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增长',
  `user_id` bigint(11) NOT NULL COMMENT '商户 标识',
  `security_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资金安全密码',
  `team_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '团长 提成点',
  `cashier_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '收款员 提成点',
  `wx_platform_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '微信平台 提成点',
  `ali_platform_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '支付宝平台 提成点',
  `qq_platform_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT 'qq平台 提成点',
  `bank_platform_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '银行卡平台 提成点',
  `other_platform_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '其它方式平台 提成点',
  `team_leader_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '团长 提成点',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`config_id`) USING BTREE,
  UNIQUE INDEX `uniq_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商户分成配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_pay_channel_out_manual
-- ----------------------------
DROP TABLE IF EXISTS `tb_pay_channel_out_manual`;
CREATE TABLE `tb_pay_channel_out_manual`  (
  `m_out_order_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单 编号',
  `mch_user_id` bigint(11) NOT NULL COMMENT '商户编号',
  `under_user_id` bigint(11) NULL DEFAULT NULL COMMENT '下发人员编号',
  `pay_command` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随机数（支付口令）',
  `pay_type` smallint(1) NOT NULL COMMENT '用户提现方式 1银行卡 ',
  `unit_amt` decimal(20, 5) NULL DEFAULT NULL COMMENT '金额，交易币种数量',
  `data` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提现数据',
  `platform_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的平台佣金',
  `other_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的其他佣金',
  `order_confirm_time` timestamp(0) NULL DEFAULT NULL COMMENT '订单确认收款时间',
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '订单状态：1.下发中 2.出款成功 3.驳回 ',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注信息',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`m_out_order_id`) USING BTREE,
  INDEX `idx_mch_user_id`(`mch_user_id`) USING BTREE,
  INDEX `idx_under_user_id`(`under_user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '手动下发表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_pay_channel_recharge
-- ----------------------------
DROP TABLE IF EXISTS `tb_pay_channel_recharge`;
CREATE TABLE `tb_pay_channel_recharge`  (
  `recharge_order_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单 编号',
  `recharge_order_token` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单 令牌',
  `app_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '应用ID',
  `mch_user_id` bigint(11) NOT NULL COMMENT '所属 商户编号',
  `under_user_id` bigint(11) NULL DEFAULT NULL COMMENT '所属 收款员编号',
  `out_trade_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商户订单号编号',
  `pay_command` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '随机数（支付口令）',
  `recharge_unit_amt` decimal(20, 5) NULL DEFAULT NULL COMMENT '充值金额，交易币种数量',
  `recharge_type` smallint(1) NOT NULL COMMENT '商户付款方式 1.支付宝 2.微信 3.银行卡 4.QQ',
  `recharge_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '购买/充值 账户：支付宝账户，银行卡号，微信号,QQ',
  `recharge_real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '购买/充值人 真实姓名',
  `recharge_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '购买/充值人 银行地址 or 支付图片',
  `order_discount` decimal(5, 2) NULL DEFAULT 0.00 COMMENT '优惠金额',
  `order_platform_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的平台佣金',
  `order_cashier_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的收款员佣金',
  `order_team_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的团长佣金',
  `order_allocation_time` timestamp(0) NULL DEFAULT NULL COMMENT '订单分配时间',
  `order_confirm_time` timestamp(0) NULL DEFAULT NULL COMMENT '订单确认收款时间',
  `callback_notify_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回调url',
  `lowerHair` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否下发,Y:已下发 N:未下发',
  `status` smallint(1) NOT NULL DEFAULT 0 COMMENT '订单状态：1.匹配中 2.待完善信息 3.匹配完成/用户待付款 4.收款员已确认 5.回调完成 6.订单超时 7.回退',
  `operator` bigint(11) NULL DEFAULT NULL COMMENT '操作确认收款用户ID',
  `sms_count` smallint(11) NULL DEFAULT 0 COMMENT '短信发送总次数',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注信息',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`recharge_order_id`) USING BTREE,
  UNIQUE INDEX `uniq_order_token`(`recharge_order_token`) USING BTREE,
  UNIQUE INDEX `uniq_merchant_trade_no`(`mch_user_id`, `out_trade_no`) USING BTREE,
  INDEX `idx_under_user_id`(`under_user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商户购买表，用户充值表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_payment_out_config
-- ----------------------------
DROP TABLE IF EXISTS `tb_payment_out_config`;
CREATE TABLE `tb_payment_out_config`  (
  `config_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增长',
  `user_id` bigint(11) NOT NULL COMMENT '商户 标识',
  `security_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资金安全密码',
  `platform_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '平台 提成点',
  `other_commission` decimal(10, 5) NULL DEFAULT 0.00000 COMMENT '其它 提成点',
  `ips` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP 白名单限制',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`config_id`) USING BTREE,
  UNIQUE INDEX `uniq_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '出款分成配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_platform_identification
-- ----------------------------
DROP TABLE IF EXISTS `tb_platform_identification`;
CREATE TABLE `tb_platform_identification`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(11) NULL DEFAULT NULL COMMENT '商户编号',
  `identification` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员标识',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员真实姓名',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `operator` bigint(11) NULL DEFAULT NULL COMMENT '操作人',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UniqueTeam`(`user_id`, `identification`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_system_admin
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_admin`;
CREATE TABLE `tb_system_admin`  (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员登录名称',
  `real_name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员真实姓名',
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `password` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `head_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `last_login_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '上次登陆时间',
  `login_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录IP',
  `login_error_count` int(11) NOT NULL DEFAULT 0 COMMENT '登陆错误次数',
  `login_error_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '登陆错误时间',
  `update_pwd_count` int(11) NULL DEFAULT 0 COMMENT '更新密码次数',
  `limit_count` int(11) NOT NULL DEFAULT 5 COMMENT '限制次数',
  `status` smallint(1) NULL DEFAULT 1 COMMENT '状态 删除标识 0已删除，1正常，2禁用',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`admin_id`) USING BTREE,
  INDEX `uniq_mobile`(`mobile`) USING BTREE COMMENT '手机号'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_system_admin
-- ----------------------------
INSERT INTO `tb_system_admin` VALUES (1, 'zhangzaipeng', '鹏哥', '13396046865', '$2a$10$V2odumTjxgEdmCI6L9Be9enHRDnRkTAiHGKMJQ3bEVbgDx38K1lgi', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoWiaSnnWUHubiauLdsSJiaPU2IianQgYG8fJsS2yKU1kJ5O5lx4eXnXtxkyHw6lQ71ic1NibtgCoF6ClBg/132', '2020-12-11 19:47:48', '192.168.1.181', 0, '2020-05-24 17:33:17', 0, 5, 1, NULL, NULL, '2020-12-09 12:54:53', NULL, '2020-12-11 19:47:51');

-- ----------------------------
-- Table structure for tb_system_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_admin_role`;
CREATE TABLE `tb_system_admin_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `status` smallint(1) NOT NULL DEFAULT 1 COMMENT '状态 删除标识 0已删除，1正常',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员-角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_system_admin_role
-- ----------------------------
INSERT INTO `tb_system_admin_role` VALUES (1, 1, 99999, 1, NULL, '2020-05-24 17:45:13', NULL, '2020-12-10 14:05:46', NULL);
INSERT INTO `tb_system_admin_role` VALUES (2, 2, 99999, 1, NULL, '2020-05-24 20:49:30', NULL, '2020-12-10 10:34:14', NULL);
INSERT INTO `tb_system_admin_role` VALUES (3, 700015, 4, 1, NULL, '2020-10-19 20:11:38', NULL, '2020-10-19 21:01:59', NULL);
INSERT INTO `tb_system_admin_role` VALUES (4, 700016, 4, 1, NULL, '2020-10-25 09:59:28', NULL, '2020-10-25 09:59:28', NULL);
INSERT INTO `tb_system_admin_role` VALUES (5, 700017, 4, 1, NULL, '2020-11-04 15:54:23', NULL, '2020-11-04 15:54:23', NULL);
INSERT INTO `tb_system_admin_role` VALUES (6, 700018, 4, 1, NULL, '2020-11-04 19:54:30', NULL, '2020-11-04 19:54:30', NULL);
INSERT INTO `tb_system_admin_role` VALUES (7, 700019, 4, 1, NULL, '2020-11-04 22:06:16', NULL, '2020-11-04 22:06:16', NULL);
INSERT INTO `tb_system_admin_role` VALUES (8, 700020, 4, 1, NULL, '2020-11-05 23:30:21', NULL, '2020-11-05 23:30:21', NULL);
INSERT INTO `tb_system_admin_role` VALUES (12, 700024, 4, 1, NULL, '2020-11-10 22:32:46', NULL, '2020-11-10 22:32:46', NULL);
INSERT INTO `tb_system_admin_role` VALUES (13, 700025, 4, 1, NULL, '2020-11-16 18:59:46', NULL, '2020-11-16 18:59:46', NULL);
INSERT INTO `tb_system_admin_role` VALUES (14, 700026, 4, 1, NULL, '2020-11-22 13:23:20', NULL, '2020-11-22 13:23:20', NULL);
INSERT INTO `tb_system_admin_role` VALUES (15, 700027, 4, 1, NULL, '2020-11-22 16:01:04', NULL, '2020-11-22 16:01:04', NULL);
INSERT INTO `tb_system_admin_role` VALUES (16, 700028, 4, 1, NULL, '2020-11-22 21:24:03', NULL, '2020-11-22 21:24:03', NULL);

-- ----------------------------
-- Table structure for tb_system_config
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_config`;
CREATE TABLE `tb_system_config`  (
  `key` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'key',
  `remark1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `remark2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_system_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_permission`;
CREATE TABLE `tb_system_permission`  (
  `per_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `per_parent_id` bigint(11) NULL DEFAULT 0 COMMENT '父节点ID',
  `per_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `per_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `permission` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限',
  `per_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称 URL',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `status` smallint(1) NULL DEFAULT 1 COMMENT '状态 删除标识 0已删除，1正常',
  `sort` smallint(1) NULL DEFAULT 0 COMMENT '排序状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`per_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_system_permission
-- ----------------------------
INSERT INTO `tb_system_permission` VALUES (1, 0, '系统管理', 'main_menu', 'system', NULL, 'layui-icon-user', 1, 0, NULL, NULL, '2020-05-24 17:30:17', NULL, '2020-12-10 12:55:34');
INSERT INTO `tb_system_permission` VALUES (2, 1, '系统用户管理', 'sub_menu', 'systemUser', '/system/adminList.htm', 'layui-icon-heart-fill', 1, 0, NULL, NULL, '2020-05-24 17:30:45', NULL, '2020-12-10 16:25:43');
INSERT INTO `tb_system_permission` VALUES (3, 1, '角色管理', 'sub_menu', 'systemRole', '/system/roles.htm', 'layui-icon-heart-fill', 1, 0, NULL, NULL, '2020-05-24 17:31:12', NULL, '2020-12-10 15:22:45');
INSERT INTO `tb_system_permission` VALUES (4, 1, '权限管理', 'sub_menu', 'systemAuth', '/system/auths.htm', 'layui-icon-user', 1, 0, NULL, NULL, '2020-12-10 15:18:13', NULL, '2020-12-10 16:40:49');
INSERT INTO `tb_system_permission` VALUES (5, 0, '个人中心', 'main_menu', 'personal', NULL, 'layui-icon-user', 1, 0, NULL, NULL, '2020-05-24 17:31:35', NULL, '2020-12-11 17:07:50');
INSERT INTO `tb_system_permission` VALUES (6, 5, '基本资料', 'sub_menu', 'changePersonal', '/system/adminInfo.htm', 'layui-icon-user', 1, 0, NULL, NULL, '2020-05-24 17:31:53', NULL, '2020-12-10 17:11:20');
INSERT INTO `tb_system_permission` VALUES (7, 5, '修改密码', 'sub_menu', 'changePwd', '/system/changePwd.htm', 'layui-icon-user', 1, 0, NULL, NULL, '2020-05-24 17:31:53', NULL, '2020-12-10 17:10:51');
INSERT INTO `tb_system_permission` VALUES (8, 0, '订单管理', 'main_menu', 'order', NULL, 'layui-icon-user', 1, 0, NULL, NULL, '2020-12-11 17:07:46', NULL, '2020-12-11 17:08:24');
INSERT INTO `tb_system_permission` VALUES (39, 8, '订单列表', 'sub_menu', 'orderList', '/order/list.htm', 'layui-icon-user', 1, 0, NULL, NULL, '2020-12-11 17:08:37', NULL, '2020-12-11 17:09:00');
INSERT INTO `tb_system_permission` VALUES (40, 0, '财务管理', 'main_menu', NULL, NULL, 'layui-icon-user', 1, 0, NULL, NULL, '2020-12-11 19:10:53', NULL, '2020-12-11 19:42:20');
INSERT INTO `tb_system_permission` VALUES (41, 40, '提现审核', 'sub_menu', NULL, NULL, NULL, 1, 0, NULL, NULL, '2020-12-11 19:11:25', NULL, '2020-12-11 19:42:11');
INSERT INTO `tb_system_permission` VALUES (42, 40, '资产查询', 'sub_menu', NULL, NULL, NULL, 1, 0, NULL, NULL, '2020-12-11 19:42:05', NULL, '2020-12-11 19:42:13');
INSERT INTO `tb_system_permission` VALUES (43, 8, '提现订单', 'sub_menu', NULL, NULL, NULL, 1, 0, NULL, NULL, '2020-12-11 19:47:27', NULL, '2020-12-11 19:47:30');
INSERT INTO `tb_system_permission` VALUES (44, 5, '收款账户配置', 'sub_menu', NULL, NULL, NULL, 1, 0, NULL, NULL, '2020-12-11 19:52:37', NULL, '2020-12-11 20:36:03');

-- ----------------------------
-- Table structure for tb_system_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_role`;
CREATE TABLE `tb_system_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `role_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `status` smallint(1) NULL DEFAULT 1 COMMENT '状态 删除标识 0已删除，1正常',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100000 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_system_role
-- ----------------------------
INSERT INTO `tb_system_role` VALUES (1, '2', '用户管理员', 1, NULL, NULL, '2020-05-24 17:32:31', NULL, '2020-12-10 10:34:37');
INSERT INTO `tb_system_role` VALUES (2, '102', '普通用户', 1, NULL, NULL, '2020-05-24 17:32:40', NULL, '2020-10-19 16:46:34');
INSERT INTO `tb_system_role` VALUES (4, '104', '商户角色', 1, NULL, NULL, '2020-10-19 16:08:50', NULL, '2020-10-19 16:46:31');
INSERT INTO `tb_system_role` VALUES (99999, '99999', '系统管理员', 1, NULL, NULL, '2020-09-29 14:47:03', NULL, '2020-10-19 16:46:40');

-- ----------------------------
-- Table structure for tb_system_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `tb_system_role_permission`;
CREATE TABLE `tb_system_role_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  `per_id` int(11) NULL DEFAULT NULL COMMENT '资源id',
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '状态 删除标识 0已删除，1正常',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色-资源表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_system_role_permission
-- ----------------------------
INSERT INTO `tb_system_role_permission` VALUES (1, 2, 4, '1', NULL, '2020-05-24 17:46:33', NULL, '2020-05-24 17:46:56', NULL);
INSERT INTO `tb_system_role_permission` VALUES (2, 2, 5, '1', NULL, '2020-05-24 17:47:07', NULL, '2020-05-24 17:47:07', NULL);
INSERT INTO `tb_system_role_permission` VALUES (3, 2, 6, '1', NULL, '2020-05-24 17:47:12', NULL, '2020-05-24 17:47:12', NULL);
INSERT INTO `tb_system_role_permission` VALUES (4, 99999, 1, '1', '4', '2020-09-29 14:43:31', NULL, '2020-09-29 14:54:57', NULL);
INSERT INTO `tb_system_role_permission` VALUES (7, 99999, 5, '1', '4', '2020-09-29 14:43:31', NULL, '2020-09-29 14:52:30', NULL);
INSERT INTO `tb_system_role_permission` VALUES (8, 99999, 9, '1', NULL, '2020-10-07 23:02:02', NULL, '2020-10-07 23:02:02', NULL);
INSERT INTO `tb_system_role_permission` VALUES (9, 99999, 16, '1', NULL, '2020-10-17 18:23:02', NULL, '2020-10-17 18:23:09', NULL);
INSERT INTO `tb_system_role_permission` VALUES (10, 99999, 18, '1', NULL, '2020-10-18 19:29:58', NULL, '2020-10-18 19:29:58', NULL);
INSERT INTO `tb_system_role_permission` VALUES (11, 99999, 19, '1', NULL, '2020-10-18 19:30:04', NULL, '2020-10-18 19:30:04', NULL);
INSERT INTO `tb_system_role_permission` VALUES (12, 4, 31, '1', NULL, '2020-10-19 21:02:21', NULL, '2020-11-04 22:47:18', NULL);
INSERT INTO `tb_system_role_permission` VALUES (13, 99999, 25, '1', NULL, '2020-10-21 20:17:45', NULL, '2020-10-21 20:17:57', NULL);
INSERT INTO `tb_system_role_permission` VALUES (14, 2, 27, '1', NULL, '2020-10-25 10:14:43', NULL, '2020-10-25 10:14:43', NULL);
INSERT INTO `tb_system_role_permission` VALUES (15, 99999, 27, '1', NULL, '2020-10-25 10:14:52', NULL, '2020-10-25 10:14:52', NULL);
INSERT INTO `tb_system_role_permission` VALUES (18, 2, 19, '1', NULL, '2020-11-03 21:14:40', NULL, '2020-11-03 21:14:40', NULL);
INSERT INTO `tb_system_role_permission` VALUES (19, 4, 27, '1', NULL, '2020-11-04 23:40:45', NULL, '2020-11-04 23:40:45', NULL);
INSERT INTO `tb_system_role_permission` VALUES (20, 99999, 34, '1', NULL, '2020-11-08 13:38:57', NULL, '2020-11-08 13:38:57', NULL);
INSERT INTO `tb_system_role_permission` VALUES (21, 4, 35, '1', NULL, '2020-11-21 20:31:45', NULL, '2020-11-21 20:31:50', NULL);
INSERT INTO `tb_system_role_permission` VALUES (22, 5, 2, '1', NULL, '2020-12-10 10:29:03', NULL, '2020-12-10 10:29:14', NULL);
INSERT INTO `tb_system_role_permission` VALUES (23, 5, 3, '1', NULL, '2020-12-10 10:29:18', NULL, '2020-12-10 10:29:21', NULL);

-- ----------------------------
-- Table structure for tb_user_asset
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_asset`;
CREATE TABLE `tb_user_asset`  (
  `asset_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增长',
  `user_id` bigint(11) NOT NULL COMMENT '用户 标识',
  `currency` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `balance` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '用户总资产',
  `available` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '用户可用资产',
  `withfraw_freez` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '提现冻结',
  `recharge_freez` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '接单冻结',
  `status` smallint(1) NULL DEFAULT 1 COMMENT '状态：1-正常，0-删除',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`asset_id`) USING BTREE,
  UNIQUE INDEX `uniq_user_id`(`user_id`, `currency`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户资产表' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_user_asset_record
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_asset_record`;
CREATE TABLE `tb_user_asset_record`  (
  `record_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  `user_id` bigint(11) NOT NULL COMMENT '商户编号 ',
  `trans_no` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '对应表单唯一ID',
  `currency` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '总金额',
  `record_detail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '记录 明细',
  `snap_assert` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注资产快照',
  `record_type` smallint(1) NOT NULL COMMENT '收支 1.下单 2.提现',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_trans_no`(`trans_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户 资产记录' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_user_receivables
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_receivables`;
CREATE TABLE `tb_user_receivables`  (
  `id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `user_id` bigint(11) NOT NULL COMMENT '收款员 userId',
  `is_open` smallint(1) NOT NULL DEFAULT 0 COMMENT '打开方式  0：未开启 1：开启',
  `real_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号昵称，姓名',
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付宝账号，微信账号，银行卡号',
  `address` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付路径 或者 银行地址（银行-支行地址）',
  `type` smallint(1) NULL DEFAULT 0 COMMENT '类型  1：支付宝 2：微信 3：银行卡 4：QQ',
  `w` int(11) NULL DEFAULT 5,
  `r` int(11) NULL DEFAULT 0,
  `l` int(11) NULL DEFAULT 100000,
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收款员 收款方式' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_user_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_withdraw`;
CREATE TABLE `tb_user_withdraw`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `record_id` bigint(11) NULL DEFAULT NULL COMMENT '流水ID',
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `withdraw_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提现地址；',
  `withdraw_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '提现数量',
  `fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '手续费',
  `processing_id` bigint(11) NULL DEFAULT NULL COMMENT '处理管理员ID',
  `withdraw_status` smallint(1) NULL DEFAULT 0 COMMENT '提现状态 -1:拒绝 0:待处理  1:处理中 2:提现成功',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '提现记录表' ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;


