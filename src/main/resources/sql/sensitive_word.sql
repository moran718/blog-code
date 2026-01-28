-- 敏感词表
CREATE TABLE IF NOT EXISTS sensitive_word (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    word VARCHAR(100) NOT NULL COMMENT '敏感词',
    replacement VARCHAR(100) DEFAULT '***' COMMENT '替换文本',
    enabled TINYINT DEFAULT 1 COMMENT '是否启用：0-禁用 1-启用',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 系统配置表
CREATE TABLE IF NOT EXISTS system_config (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    config_key VARCHAR(50) NOT NULL UNIQUE COMMENT '配置键',
    config_value VARCHAR(200) NOT NULL COMMENT '配置值',
    description VARCHAR(200) COMMENT '描述',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 插入默认策略配置
INSERT INTO system_config (config_key, config_value, description) 
VALUES ('sensitive_word_strategy', 'replace', '敏感词策略：replace-替换 block-禁止')
ON DUPLICATE KEY UPDATE config_key = config_key;
