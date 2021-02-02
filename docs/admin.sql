-- 收款表
CREATE TABLE `tb_order_income` (
  `order_id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单 编号',
  `order_token` varchar(50) NULL DEFAULT NULL COMMENT '订单 令牌',
  `app_id` varchar(50) NOT NULL COMMENT '应用ID',
  `merchant_id` bigint(11) NOT NULL COMMENT '所属 商户编号',
  `member_id` bigint(11) NULL DEFAULT NULL COMMENT '所属 会员编号',
  `out_trade_no` varchar(100) NULL DEFAULT NULL COMMENT '商户订单号编号',

  `order_type` smallint(1) NOT NULL COMMENT '商户付款方式 1.支付宝 2.微信 3.银行卡 4.QQ',

  `order_amt` decimal(20, 5) NULL DEFAULT NULL COMMENT '下单金额',
  `pay_amt` decimal(20, 5) NULL DEFAULT NULL COMMENT '支付金额',
  `order_platform_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的平台佣金',
  `order_team_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的团长佣金',
  `order_cashier_commission` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单完成后的收款员佣金',
  `order_allocation_time` timestamp(0) NULL DEFAULT NULL COMMENT '订单分配时间',
  `order_confirm_time` timestamp(0) NULL DEFAULT NULL COMMENT '订单确认收款时间',
  `confirm_operator_id` bigint(11) NULL DEFAULT NULL COMMENT '操作确认收款用户ID',

  `receive_account` varchar(50) NULL DEFAULT NULL COMMENT '收款账户：支付宝账户，银行卡号，微信号, QQ号',
  `receive_real_name` varchar(50) NULL DEFAULT NULL COMMENT '收款账户 真实姓名',
  `receive_url` varchar(255) NULL DEFAULT NULL COMMENT '银行地址 or 支付图片',

  `callback_notify_url` varchar(255) NULL DEFAULT NULL COMMENT '回调url',
  `status` smallint(1) NOT NULL DEFAULT 0 COMMENT '订单状态：1.匹配中 2.匹配完成/用户待付款 3.收款员已确认 4.回调完成 9.订单超时 ',

  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注信息',
  `created_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',

  PRIMARY KEY (`order_id`) ,
  UNIQUE INDEX `uniq_merchant_trade_no`(`merchant_id`, `out_trade_no`) ,
  INDEX `idx_member_id`(`member_id`)
) ENGINE = InnoDB CHARACTER SET = utf8 COMMENT = '收款订单表' ROW_FORMAT = Compact;



-- 收款员 收款码表
CREATE TABLE `tb_receivables` (
  `user_id` bigint(11) NOT NULL COMMENT '收款员 userId',
  `is_open` smallint(1) DEFAULT '0' COMMENT '打开方式  0：未开启 1：开启',
  `real_name` varchar(20) DEFAULT NULL COMMENT '账号昵称，姓名',
  `account` varchar(20) DEFAULT NULL COMMENT '支付宝账号，微信账号，银行卡号',
  `address` varchar(128) DEFAULT NULL COMMENT '支付路径 或者 银行地址（银行-支行地址）',
  `type` smallint(1) DEFAULT '0' COMMENT '类型  1：支付宝 2：微信 3：银行卡',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收款员 收款方式';



-- 提现记录表 tb_user_withdraw
CREATE TABLE `tb_withdraw` (
    `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `record_id` bigint(11) DEFAULT NULL COMMENT '流水ID',
    `user_id` bigint(11) NOT NULL COMMENT '用户ID',
    `withdraw_address` varchar(100) DEFAULT NULL COMMENT '提现地址；',
    `withdraw_amount` decimal(10,2) DEFAULT NULL COMMENT '提现数量',

    `processing_id` bigint(11) DEFAULT NULL COMMENT '处理管理员ID',
    `withdraw_status` smallint(1) DEFAULT '0' COMMENT '提现状态 -1:拒绝 0:待处理  1:处理中 2:提现成功',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='提现记录表';

-- 用户资产表
CREATE TABLE `tb_asset` (
    `asset_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增长',
    `user_id` bigint(11) NOT NULL COMMENT '用户 标识',
    `balance` decimal(10,2) DEFAULT '0.00' COMMENT '用户总资产',
    `available` decimal(10,2) DEFAULT '0.00' COMMENT '用户可用资产',
    `withfraw_freez` decimal(10,2) DEFAULT '0.00' COMMENT '提现冻结',
    `recharge_freez` decimal(10,2) DEFAULT '0.00' COMMENT '接单冻结',
    `status` smallint(1) DEFAULT '1' COMMENT '状态：1-正常，0-删除',
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    PRIMARY KEY (`asset_id`) USING BTREE,
    UNIQUE KEY `uniq_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户资产表';
