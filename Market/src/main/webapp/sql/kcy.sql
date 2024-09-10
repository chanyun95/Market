--회원 테이블
create table member(
	mem_num NUMBER NOT NULL,
	mem_id VARCHAR2(12) NOT NULL,	--아이디
	mem_name VARCHAR2(30) NOT NULL,	--이름
	mem_photo VARCHAR2(400),	-- 프로필 사진
	mem_auth NUMBER(1) DEFAULT 2 NOT NULL,	--권한등급
	CONSTRAINT member_pk PRIMARY KEY (mem_num)
);
create sequence member_seq;

--일반회원 상세 테이블
create table member_detail(
	mem_num NUMBER NOT NULL,
	au_id VARCHAR2(36) UNIQUE,	--자동로그인에 식별되는 식별값
	mem_passwd VARCHAR2(20) NOT NULL,
	mem_birth DATE NOT NULL,
	mem_email VARCHAR2(50) NOT NULL,
	mem_phone VARCHAR2(11) NOT NULL,
	mem_zipcode VARCHAR2(5) NOT NULL,
	mem_address1 VARCHAR2(90) NOT NULL,
	mem_address2 VARCHAR2(90) NOT NULL,
	mem_reg DATE DEFAULT sysdate NOT NULL,
	mem_modify DATE,
	CONSTRAINT member_detail_pk PRIMARY KEY (mem_num),
	CONSTRAINT member_detail_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
create table article (
    arti_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    arti_category VARCHAR2(100) NOT NULL,
    arti_name VARCHAR2(50) NOT NULL,
    arti_content CLOB NOT NULL,
    arti_price NUMBER NOT NULL,
    arti_image BLOB NOT NULL,
    arti_reg DATE DEFAULT SYSDATE NOT NULL,
    arti_modify DATE,
    arti_hit NUMBER DEFAULT 0 NOT NULL,
    arti_sold CHAR(1) DEFAULT 'N' NOT NULL,
    arti_location VARCHAR2(150) NOT NULL,
    arti_location2 VARCHAR2(150) NOT NULL,
    CONSTRAINT article_pk PRIMARY KEY (arti_num),
    CONSTRAINT article_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num)
);
create sequence article_seq;