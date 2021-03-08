/*
    --2021.02.01 by fight, sms about table info
*/

-- ----------------------------
-- Table structure for sms_channel
-- ----------------------------
DROP TABLE IF EXISTS `sms_channel`;
CREATE TABLE `sms_channel`
(
    `id`               bigint(20)   NOT NULL AUTO_INCREMENT COMMENT '自增编号',
    `code`             varchar(50)  NOT NULL COMMENT '编码(来自枚举类 阿里、华为、七牛等)',
    `api_key`          varchar(100) NOT NULL COMMENT '账号id',
    `api_secret`       varchar(100) NOT NULL COMMENT '账号秘钥',
    `had_callback`     bit(1)       NOT NULL DEFAULT b'0' COMMENT '是否拥有回调函数',
    `callback_url`     varchar(100) NOT NULL default '' COMMENT '回调请求路径',
    `api_signature_id` varchar(100) NOT NULL COMMENT '实际渠道签名唯一标识',
    `name`             varchar(50)  NOT NULL COMMENT '名称',
    `signature`        varchar(50)  NOT NULL COMMENT '签名值',
    `remark`           varchar(200) NOT NULL COMMENT '备注',

    `status`           tinyint(4)   NOT NULL DEFAULT 0 COMMENT '启用状态（0正常 1停用）',
    `create_by`        varchar(64)  NOT NULL DEFAULT '' COMMENT '创建者',
    `create_time`      datetime              DEFAULT NULL COMMENT '创建时间',
    `update_by`        varchar(64)           DEFAULT '' COMMENT '更新者',
    `update_time`      datetime              DEFAULT NULL COMMENT '更新时间',
    `deleted`          bit(1)                DEFAULT b'0' COMMENT '是否删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='短信渠道';
/*
	优先级值一样时，按照id顺序取值
*/

-- ----------------------------
-- Table structure for sms_template
-- ----------------------------
DROP TABLE IF EXISTS `sms_template`;
CREATE TABLE `sms_template`
(
    `id`              bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增编号',
    `channel_code`    varchar(50)   NOT NULL COMMENT '短信渠道编码(来自枚举类)',
    `channel_id`      bigint(20)    NOT NULL COMMENT '短信渠道id (对于前端来说就是绑定一个签名)',
    `type`            tinyint(4)    NOT NULL DEFAULT 1 COMMENT '消息类型 [0验证码 1短信通知 2推广短信 3国际/港澳台消息]',
    `biz_code`        varchar(50)   NOT NULL COMMENT '业务编码(来自数据字典, 用户自定义业务场景 一个场景可以有多个模板)',
    `code`            varchar(50)   NOT NULL COMMENT '编码',
    `name`            varchar(50)   NOT NULL COMMENT '名称',
    `api_template_id` varchar(100)  NOT NULL COMMENT '实际渠道模板唯一标识',
    `content`         varchar(1000) NOT NULL DEFAULT '' COMMENT '内容',
    `params`          varchar(200)  NOT NULL DEFAULT '' COMMENT '参数数组(自动根据内容生成)',
    `remark`          varchar(200)  NOT NULL COMMENT '备注',

    `status`          tinyint(4)    NOT NULL DEFAULT 0 COMMENT '启用状态（0正常 1停用）',
    `create_by`       varchar(64)   NOT NULL DEFAULT '' COMMENT '创建者',
    `create_time`     datetime               DEFAULT NULL COMMENT '创建时间',
    `update_by`       varchar(64)            DEFAULT '' COMMENT '更新者',
    `update_time`     datetime               DEFAULT NULL COMMENT '更新时间',
    `deleted`         bit(1)                 DEFAULT b'0' COMMENT '是否删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='短信模板';

-- ----------------------------
-- Table structure for sms_query_log
-- ----------------------------
DROP TABLE IF EXISTS `sms_query_log`;
CREATE TABLE `sms_query_log`
(
    `id`                bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增编号',
    `api_id`            varchar(100)  NOT NULL COMMENT '第三方唯一标识',
    `channel_code`      varchar(50)   NOT NULL COMMENT '短信渠道编码(来自枚举类)',
    `channel_id`        bigint(20)    NOT NULL COMMENT '短信渠道id',
    `template_code`     varchar(50)   NOT NULL COMMENT '渠道编码',
    `phones`            varchar(2000) NOT NULL COMMENT '手机号(数组json字符串)',
    `content`           varchar(1000) NOT NULL DEFAULT '' COMMENT '内容',
    `send_result_param` varchar(200)  NOT NULL DEFAULT '' COMMENT '查询短信发送结果的参数',
    `send_status`       tinyint(1)    NOT NULL DEFAULT 2 COMMENT '发送状态（0本地异步中 1发送请求失败 2发送请求成功）',
    `got_result`        bit(1)        NOT NULL DEFAULT b'0' COMMENT '是否获取发送结果',
    `had_callback`      bit(1)        NOT NULL DEFAULT b'0' COMMENT '是否拥有回调函数',
    `create_by`         varchar(64)   NOT NULL DEFAULT '' COMMENT '创建者',
    `create_time`       datetime               DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='短信请求日志';

-- ----------------------------
-- Table structure for sms_log
-- ----------------------------
DROP TABLE IF EXISTS `sms_send_log`;
CREATE TABLE `sms_send_log`
(
    `id`            bigint(20)    NOT NULL AUTO_INCREMENT COMMENT '自增编号',
    `channel_code`  varchar(50)   NOT NULL COMMENT '短信渠道编码(来自枚举类)',
    `channel_id`    bigint(20)    NOT NULL COMMENT '短信渠道id',
    `template_code` varchar(50)   NOT NULL COMMENT '渠道编码',
    `query_log_id`  bigint(20)    NOT NULL COMMENT '请求日志id',
    `phone`         char(11)      NOT NULL COMMENT '手机号',
    `content`       varchar(1000) NOT NULL DEFAULT '' COMMENT '内容',
    `remark`        varchar(200)           DEFAULT NULL COMMENT '备注',
    `success`       tinyint(1)    NOT NULL DEFAULT b'0' COMMENT '是否删除',
    `send_time`     datetime               DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4 COMMENT ='短信发送日志';
