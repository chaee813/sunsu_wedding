CREATE SCHEMA IF NOT EXISTS `sunsu_wedding` DEFAULT CHARACTER SET utf8mb4;

USE `sunsu_wedding`;


CREATE TABLE IF NOT EXISTS user_tb
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    dtype      VARCHAR(31)           NULL,
    email      VARCHAR(100)          NOT NULL,
    password   VARCHAR(256)          NOT NULL,
    username   VARCHAR(45)           NOT NULL,
    grade      VARCHAR(255)          NOT NULL,
    upgrade_at datetime              NULL,
    is_active  BIT(1)                NULL,
    created_at datetime              NOT NULL,
    CONSTRAINT pk_user_tb PRIMARY KEY (id)
);

ALTER TABLE user_tb
    ADD CONSTRAINT uc_user_tb_email UNIQUE (email);

CREATE TABLE IF NOT EXISTS portfolio_tb
(
    id              BIGINT AUTO_INCREMENT NOT NULL,
    planner_id      BIGINT                NULL,
    title           VARCHAR(255)          NOT NULL,
    `description`   VARCHAR(255)          NULL,
    location        VARCHAR(255)          NULL,
    career          VARCHAR(255)          NULL,
    partner_company VARCHAR(255)          NULL,
    total_price     BIGINT                NULL,
    contract_count  BIGINT                NULL,
    avg_price       BIGINT                NULL,
    min_price       BIGINT                NULL,
    max_price       BIGINT                NULL,
    created_at      datetime              NULL,
    is_active       BIT(1) DEFAULT 1      NULL,
    CONSTRAINT pk_portfolio_tb PRIMARY KEY (id)
);

ALTER TABLE portfolio_tb
    ADD CONSTRAINT FK_PORTFOLIO_TB_ON_PLANNER FOREIGN KEY (planner_id) REFERENCES user_tb (id);

CREATE TABLE IF NOT EXISTS imageitem_tb
(
    id               BIGINT AUTO_INCREMENT NOT NULL,
    portfolio_id     BIGINT                NULL,
    origin_file_name VARCHAR(255)          NOT NULL,
    file_path        VARCHAR(255)          NOT NULL,
    file_size        BIGINT                NOT NULL,
    thumbnail        BIT(1)                NOT NULL,
    CONSTRAINT pk_imageitem_tb PRIMARY KEY (id)
);

ALTER TABLE imageitem_tb
    ADD CONSTRAINT FK_IMAGEITEM_TB_ON_PORTFOLIO FOREIGN KEY (portfolio_id) REFERENCES portfolio_tb (id);

CREATE TABLE IF NOT EXISTS priceitem_tb
(
    id           BIGINT AUTO_INCREMENT NOT NULL,
    portfolio_id BIGINT                NULL,
    item_title   VARCHAR(255)          NOT NULL,
    item_price   BIGINT                NOT NULL,
    CONSTRAINT pk_priceitem_tb PRIMARY KEY (id)
);

ALTER TABLE priceitem_tb
    ADD CONSTRAINT FK_PRICEITEM_TB_ON_PORTFOLIO FOREIGN KEY (portfolio_id) REFERENCES portfolio_tb (id);

CREATE TABLE IF NOT EXISTS chat_tb
(
    id         BIGINT AUTO_INCREMENT NOT NULL,
    created_at datetime              NOT NULL,
    is_active  BIT(1)                NOT NULL,
    CONSTRAINT pk_chat_tb PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS match_tb
(
    id              BIGINT AUTO_INCREMENT NOT NULL,
    planner_id      BIGINT                NULL,
    couple_id       BIGINT                NULL,
    chat_id         BIGINT                NULL,
    status          VARCHAR(255)          NOT NULL,
    price           BIGINT                NOT NULL,
    confirmed_price BIGINT                NOT NULL,
    confirmed_at    datetime              NULL,
    review_status   VARCHAR(255)          NOT NULL,
    created_at      datetime              NOT NULL,
    is_active       BIT(1)                NOT NULL,
    CONSTRAINT pk_match_tb PRIMARY KEY (id)
);

ALTER TABLE match_tb
    ADD CONSTRAINT FK_MATCH_TB_ON_CHAT FOREIGN KEY (chat_id) REFERENCES chat_tb (id);

ALTER TABLE match_tb
    ADD CONSTRAINT FK_MATCH_TB_ON_COUPLE FOREIGN KEY (couple_id) REFERENCES user_tb (id);

ALTER TABLE match_tb
    ADD CONSTRAINT FK_MATCH_TB_ON_PLANNER FOREIGN KEY (planner_id) REFERENCES user_tb (id);

CREATE TABLE IF NOT EXISTS quotation_tb
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    match_id      BIGINT                NULL,
    title         VARCHAR(255)          NOT NULL,
    price         BIGINT                NOT NULL,
    company       VARCHAR(255)          NULL,
    `description` VARCHAR(255)          NULL,
    status        VARCHAR(255)          NOT NULL,
    modified_at   datetime              NULL,
    created_at    datetime              NOT NULL,
    is_active     BIT(1)                NOT NULL,
    CONSTRAINT pk_quotation_tb PRIMARY KEY (id)
);

ALTER TABLE quotation_tb
    ADD CONSTRAINT FK_QUOTATION_TB_ON_MATCH FOREIGN KEY (match_id) REFERENCES match_tb (id);

CREATE TABLE IF NOT EXISTS review_tb
(
    id          BIGINT AUTO_INCREMENT NOT NULL,
    match_id    BIGINT                NULL,
    content     VARCHAR(255)          NOT NULL,
    created_at  datetime              NOT NULL,
    modified_at datetime              NULL,
    is_active   BIT(1)                NOT NULL,
    CONSTRAINT pk_review_tb PRIMARY KEY (id)
);

ALTER TABLE review_tb
    ADD CONSTRAINT FK_REVIEW_TB_ON_MATCH FOREIGN KEY (match_id) REFERENCES match_tb (id);

CREATE TABLE IF NOT EXISTS payment_tb
(
    id           BIGINT AUTO_INCREMENT NOT NULL,
    user_id      BIGINT                NULL,
    order_id     VARCHAR(255)          NOT NULL,
    payment_key  VARCHAR(255)          NULL,
    payed_amount BIGINT                NOT NULL,
    created_at   datetime              NOT NULL,
    payed_at     datetime              NULL,
    is_active    BIT(1)                NULL,
    CONSTRAINT pk_payment_tb PRIMARY KEY (id)
);

ALTER TABLE payment_tb
    ADD CONSTRAINT FK_PAYMENT_TB_ON_USER FOREIGN KEY (user_id) REFERENCES user_tb (id);

CREATE TABLE IF NOT EXISTS token_tb
(
    id            BIGINT AUTO_INCREMENT NOT NULL,
    user_id       BIGINT                NULL,
    access_token  VARCHAR(255)          NOT NULL,
    refresh_token VARCHAR(255)          NOT NULL,
    CONSTRAINT pk_token_tb PRIMARY KEY (id)
);

ALTER TABLE token_tb
    ADD CONSTRAINT FK_TOKEN_TB_ON_USER FOREIGN KEY (user_id) REFERENCES user_tb (id);
