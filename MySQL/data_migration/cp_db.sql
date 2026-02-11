CREATE DATABASE cp_data;

USE cp_data;

CREATE TABLE news_master (
    seq_no INT(20) NOT NULL AUTO_INCREMENT,
    news_title TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    news_desc TEXT NULL DEFAULT NULL  COLLATE 'utf8mb4_general_ci',
    news_category TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
    news_author TEXT NULL DEFAULT NULL  COLLATE 'utf8mb4_general_ci',
    publisher TINYTEXT NULL DEFAULT NULL  COLLATE 'utf8mb4_general_ci',
    news_pub_date CHAR(30) NULL DEFAULT NULL  COLLATE 'utf8mb4_general_ci',
    news_url TINYTEXT NULL DEFAULT NULL  COLLATE 'utf8mb4_general_ci',
    news_update CHAR(19) NULL DEFAULT NULL  COLLATE 'utf8mb4_general_ci',
    PRIMARY KEY (seq_no) USING BTREE,
    INDEX news_url (news_url(255)) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=213
;