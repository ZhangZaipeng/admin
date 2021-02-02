-- 商户请求接口秘钥表
CREATE TABLE `tb_user_app_secret` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '密钥 编号',
  `user_id` bigint(11) NOT NULL COMMENT '商户 编号',
  `app_id` varchar(50) NOT NULL COMMENT 'APP ID',
  `app_name` varchar(20) DEFAULT NULL COMMENT '应用名称',
  `app_secret` varchar(128) DEFAULT NULL COMMENT '应用 密钥',
  `deleted` smallint(1) DEFAULT '0' COMMENT '账号状态： 1 有效 0 无效 ',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_app_id` (`app_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户接口密钥表';


-- 商户下单表（接口加密方式 ）
CREATE TABLE `tb_pay_channel_recharge` (
  `recharge_order_id` varchar(50) NOT NULL COMMENT '订单 编号',
  `recharge_order_token` varchar(50) DEFAULT NULL COMMENT '订单 令牌',
  `app_id` varchar(50) NOT NULL COMMENT '应用ID',
  `mch_user_id` bigint(11) NOT NULL COMMENT '所属 商户编号',
  `under_user_id` bigint(11) DEFAULT NULL COMMENT '所属 收款员编号',
  `out_trade_no` varchar(100) DEFAULT NULL COMMENT '商户订单号编号',
  `pay_command` varchar(10) DEFAULT NULL COMMENT '随机数（支付口令）',

  `recharge_unit_amt` decimal(20,5) DEFAULT NULL COMMENT '充值金额，交易币种数量',
  `recharge_type` smallint(1) NOT NULL COMMENT '商户付款方式 1.支付宝 2.微信 3.银行卡 4.数字货币',
  `recharge_account` varchar(50) DEFAULT NULL COMMENT '购买/充值 账户：支付宝账户，银行卡号，微信号',
  `recharge_real_name` varchar(50) DEFAULT NULL COMMENT '购买/充值人 真实姓名',
  `recharge_url` varchar(255) DEFAULT NULL COMMENT '购买/充值人 银行地址 or 支付图片',
  `order_commission` decimal(10,5) DEFAULT NULL COMMENT '订单完成后的佣金',
  `order_allocation_time` timestamp NULL DEFAULT NULL COMMENT '订单分配时间',
  `order_confirm_time` timestamp NULL DEFAULT NULL COMMENT '订单确认收款时间',
  `status` smallint(1) NOT NULL DEFAULT '0' COMMENT '订单状态：1.匹配中 2.待完善信息 3.匹配完成/用户待付款 4.收款员已确认 5.回调完成 6.订单超时',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`recharge_order_id`) ,
  UNIQUE KEY `uniq_order_token` (`recharge_order_token`) ,
  UNIQUE KEY `uniq_merchant_trade_no` (`mch_user_id`,`out_trade_no`) ,
  KEY `idx_under_user_id` (`under_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户购买表，用户充值表';


-- 收款员 收款码表
CREATE TABLE `tb_user_receivables` (
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
CREATE TABLE `tb_user_withdraw` (
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
CREATE TABLE `tb_user_asset` (
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


-- 商户分成配置表
CREATE TABLE `tb_merchant_config` (
     `config_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增长',
     `user_id` bigint(11) NOT NULL COMMENT '商户 标识',

     `security_pwd` varchar(100) DEFAULT NULL COMMENT '资金安全密码',
     `cashier_commission` decimal(10,5) DEFAULT '0.00000' COMMENT '收款员提成点',
     `platform_commission` decimal(10,5) DEFAULT '0.00000' COMMENT '平台提成点',

     `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
     PRIMARY KEY (`config_id`) ,
     UNIQUE KEY `uniq_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商户分成配置表';



CREATE TABLE `tb_pay_channel_out` (
  `out_order_id` varchar(50) NOT NULL DEFAULT '' COMMENT '订单 编号',
  `out_order_token` varchar(50) DEFAULT NULL COMMENT '订单 令牌',
  `app_id` varchar(50) NOT NULL COMMENT '应用ID',
  `mch_user_id` bigint(11) NOT NULL COMMENT '商户编号',
  `under_user_id` bigint(11) DEFAULT NULL COMMENT '下发人员编号',
  `out_trade_no` varchar(100) DEFAULT NULL COMMENT '商户订单号编号',

  `pay_command` varchar(10) DEFAULT NULL COMMENT '随机数（支付口令）',
  `mch_member_id` bigint(11) NOT NULL COMMENT '商户会员编号',
  `unit_amt` decimal(20,5) DEFAULT NULL COMMENT '金额，交易币种数量',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `card_no` varchar(255) DEFAULT NULL COMMENT '银行卡号',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '银行名称',

  `order_commission` decimal(10,5) DEFAULT NULL COMMENT '订单完成后的平台佣金',
  `order_confirm_time` timestamp NULL DEFAULT NULL COMMENT '订单确认收款时间',
  `callback_notify_url` varchar(255) DEFAULT NULL COMMENT '回调url',

  `status` smallint(1) NOT NULL DEFAULT '0' COMMENT '订单状态：1.下发中 2.驳回 3.出款成功',
  `remark` varchar(100) DEFAULT NULL COMMENT '订单备注信息',

  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`out_order_id`),
  UNIQUE KEY `uniq_order_token` (`out_order_token`),
  UNIQUE KEY `uniq_merchant_trade_no` (`mch_user_id`,`out_trade_no`),
  KEY `idx_under_user_id` (`under_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='下发表';


CREATE TABLE `tb_user_out_asset` (
  `asset_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增长',
  `user_id` bigint(11) NOT NULL COMMENT '用户 标识',
  `currency` varchar(20) NOT NULL,
  `balance` decimal(10,2) DEFAULT '0.00' COMMENT '用户总资产',
  `available` decimal(10,2) DEFAULT '0.00' COMMENT '用户可用资产',
  `withfraw_freez` decimal(10,2) DEFAULT '0.00' COMMENT '充值冻结',

  `status` smallint(1) DEFAULT '1' COMMENT '状态：1-正常，0-删除',

  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`asset_id`),
  UNIQUE KEY `uniq_user_id` (`user_id`,`currency`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='下发 用户资产表';

CREATE TABLE `tb_user_out_asset_record` (
  `record_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  `user_id` bigint(11) NOT NULL COMMENT '商户编号 ',
  `trans_no` char(40) NOT NULL COMMENT '对应表单唯一ID',
  `currency` varchar(40) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL COMMENT '总金额',
  `record_detail` varchar(100) DEFAULT NULL COMMENT '记录 明细',
  `snap_assert` varchar(1024) DEFAULT NULL COMMENT '备注资产快照',
  `record_type` smallint(1) NOT NULL COMMENT '收支 1.下发 2.充值',

  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`record_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_trans_no` (`trans_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='下发用户 资产记录';

