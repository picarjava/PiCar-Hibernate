
DROP TABLE GROUP_REPORT;
DROP SEQUENCE GREPORT_ID_SEQ;
DROP TABLE GROUP_ORDER;
DROP TABLE GROUP_MEM;
DROP TABLE GROUP_BAND;
DROP SEQUENCE GROUP_BAND_SEQ;
DROP SEQUENCE GODR_ID_SEQ;


DROP TABLE DRIVER_REPORT;
DROP SEQUENCE DREPORT_ID_SEQ;

DROP TABLE PAYMENT_RECORD;
DROP SEQUENCE PAY_SEQ;

DROP TABLE SINGLE_ORDER;
DROP SEQUENCE SEQ_SINGLE_ORDER;
--
DROP TABLE BROADCAST;
DROP SEQUENCE MSG_ID_SEQ;
--DROP SEQUENCE
DROP TABLE STORE_RECORD;
DROP SEQUENCE STO_SEQ;
/* Drop table instant_message */
DROP TABLE INSTANT_MESSAGE;
/* Drop table location*/
DROP SEQUENCE ACTIVITY_SEQ;
DROP TABLE LOCATION;
DROP TABLE ACTIVITY_TOKEN;
DROP TABLE ACTIVITY;
DROP TABLE RATE;
DROP SEQUENCE RAT_SEQ;
DROP TABLE DRIVER;
DROP SEQUENCE DRIVER_ID_SEQ;
---------------------------------
DROP TABLE MEMBER;
DROP SEQUENCE MEM_SEQ;

DROP SEQUENCE ADMIN_SEQ;
DROP TABLE ADMIN;

------------------START------------------

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';

--建立後臺管理員TABLE--
--IS_EMP原本設定是Boolean,我改為number, 1=true, 0 = false --
CREATE TABLE ADMIN(
    ADMIN_ID VARCHAR2(5) NOT NULL,
    ADMIN_NAME VARCHAR2(10) NOT NULL,
    PASSWORD VARCHAR2(12) NOT NULL,
    IS_EMP NUMBER(1,0) NOT NULL,
    CONSTRAINT ADMIN_PK PRIMARY KEY (ADMIN_ID)
    );
CREATE SEQUENCE ADMIN_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

INSERT INTO ADMIN (ADMIN_ID, ADMIN_NAME, PASSWORD, IS_EMP) 
VALUES ('A'||LPAD(to_char(ADMIN_SEQ.NEXTVAL),3,'0'), '王小明', 'abc123456', 1);
INSERT INTO ADMIN (ADMIN_ID, ADMIN_NAME, PASSWORD, IS_EMP) 
VALUES ('A'||LPAD(to_char(ADMIN_SEQ.NEXTVAL),3,'0'), '林小華', 'seewdf111', 1);
INSERT INTO ADMIN (ADMIN_ID, ADMIN_NAME, PASSWORD, IS_EMP) 
VALUES ('A'||LPAD(to_char(ADMIN_SEQ.NEXTVAL),3,'0'), '陳小美', '12345111a', 0);

-- 建立會員MEMBER的表格
CREATE TABLE MEMBER (
  MEM_ID          VARCHAR2(5)   PRIMARY KEY NOT NULL,
  NAME            VARCHAR2(100) NOT NULL,
  EMAIL           VARCHAR2(50)  NOT NULL,
  PASSWORD        VARCHAR2(128) NOT NULL,
  PHONE           VARCHAR2(40)  NOT NULL,
  CREDIT_CARD     VARCHAR2(40)  NOT NULL,
  PET             NUMBER(1,0)   NOT NULL,
  SMOKE           NUMBER(1,0)   NOT NULL,
  GENDER          NUMBER(1,0)   NOT NULL,
  TOKEN           NUMBER(7,0),
  ACTIVITY_TOKEN  NUMBER(7,0),
  BIRTHDAY        DATE          NOT NULL,
  VERIFIED        NUMBER(1,0)   NOT NULL,  
  BABY_SEAT       NUMBER(1,0)   NOT NULL
);
----SEQ
CREATE SEQUENCE MEM_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 建立會員member的假資料
--     MEM_ID,  EMAIL,               PASSWORD, PHONE        ,  CREDIT_CARD      PET, SMOKER, GENDER,                                    VERIFIED,  BABY_SEAT --

INSERT INTO MEMBER 
VALUES('M'||LPAD(MEM_SEQ.NEXTVAL, 3, '0'), '皮卡丘', 'Pikachu@gmail.com', 'Pikachu', '0915-523-698', '9593-9898-4545-2323', 1, 1, 1, 1000, 50, TO_DATE('1981-11-17','YYYY-MM-DD'), 1, 0);
INSERT INTO MEMBER 
VALUES('M'||LPAD(MEM_SEQ.NEXTVAL, 3, '0'), '妙蛙種子', 'Bulbasaur@gmail.com', 'Bulbasaur', '0912-628-817', '9593-9897-1950-1812', 0, 1, 0, NULL, 50, TO_DATE('1988-07-15','YYYY-MM-DD'), 1, 0);
INSERT INTO MEMBER 
VALUES('M'||LPAD(MEM_SEQ.NEXTVAL, 3, '0'), '小火龍', 'Charmander@gmail.com', 'Charmander', '0928-951-477', '9593-9897-9451-1556', 1, 1, 1, 500, NULL, TO_DATE('1985-06-06','YYYY-MM-DD'), 0, 0);
INSERT INTO MEMBER 
VALUES('M'||LPAD(MEM_SEQ.NEXTVAL, 3, '0'), '傑尼龜', 'Squirtle@gmail.com', 'Squirtle', '0933-258-746', '9593-9897-1584-7845', 0, 0, 0, 1000, 55, TO_DATE('1995-02-09','YYYY-MM-DD'), 0, 0);
INSERT INTO MEMBER 
VALUES('M'||LPAD(MEM_SEQ.NEXTVAL, 3, '0'), '伊布', 'Eevee@gmail.com', 'Eevee', '0935-336-681', '9593-9897-9585-5541', 0, 0, 0, 2000, 10, TO_DATE('1986-11-23','YYYY-MM-DD'), 1, 1);
INSERT INTO MEMBER 
VALUES('M'||LPAD(MEM_SEQ.NEXTVAL, 3, '0'), '超夢', 'Mewtwo@gmail.com', 'Mewtwo', '0965-154-515', '9593-9897-5848-0290', 1, 1, 0, null, null, TO_DATE('1990-12-15','YYYY-MM-DD'), 0, 0);
--------------------

CREATE TABLE DRIVER(
MEM_ID    VARCHAR2(5)   NOT NULL,
DRIVER_ID  VARCHAR2(5)    NOT NULL,
CONSTRAINT DRIVER_MEM_ID_FK FOREIGN KEY(MEM_ID) REFERENCES MEMBER(MEM_ID),

PLATE_NUM VARCHAR2(8 CHAR)  NOT NULL,
LICENCE BLOB           NOT NULL,
CRIMINAL BLOB          NOT NULL,
TRAFFIC_RECORD BLOB    NOT NULL,
ID_NUM BLOB            NOT NULL,
PHOTO BLOB             NOT NULL,
VERIFIED   NUMBER(1,0) NOT NULL,
BANNED     NUMBER(1,0) NOT NULL,
DEADLINE   DATE                ,
ONLINE_CAR NUMBER(1,0) NOT NULL,
SCORE      NUMBER(3,1)         ,
CAR_TYPE   CLOB        NOT NULL,
SHARED_CAR NUMBER(1,0) NOT NULL,
PET        NUMBER(1,0) NOT NULL,
SMOKE NUMBER(1,0)      NOT NULL,
BABY_SEAT NUMBER(1,0)  NOT NULL,
CONSTRAINT DRIVER_ID_PK PRIMARY KEY (DRIVER_ID)
);

CREATE SEQUENCE DRIVER_ID_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    CACHE 10;

--DRIVER DATA
INSERT INTO DRIVER VALUES('M003', 'D'||LPAD(to_char(DRIVER_ID_SEQ.NEXTVAL),3,'0'),'ABC-0001',EMPTY_BLOB(),EMPTY_BLOB(),
EMPTY_BLOB(),EMPTY_BLOB(),EMPTY_BLOB(),'1','1','2019-02-01','0','70.5','FORD','1','1','1','1');
INSERT INTO DRIVER VALUES('M004', 'D'||LPAD(to_char(DRIVER_ID_SEQ.NEXTVAL),3,'0'),'ABC-0002',EMPTY_BLOB(),EMPTY_BLOB(),
EMPTY_BLOB(),EMPTY_BLOB(),EMPTY_BLOB(),'1','1','2019-02-01','0','70.5','FORD','1','1','1','1');
--
-- 建立費率RATE的表格
CREATE TABLE RATE(
RATE_ID     NUMBER(2,0)        PRIMARY KEY NOT NULL,
RATE_NAME   VARCHAR2(40)       NOT NULL,
RATE_PRICE  NUMBER(3,1)        NOT NULL,
RATE_BASIC  NUMBER(2,0)        NOT NULL

);
-- 建立費率RATE的假資料
CREATE SEQUENCE RAT_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO RATE VALUES(RAT_SEQ.NEXTVAL, '一般時段(06~16)', 10, 60);
INSERT INTO RATE VALUES(RAT_SEQ.NEXTVAL, '夜間時段(21~06)', 30, 60);
INSERT INTO RATE VALUES(RAT_SEQ.NEXTVAL, '下班時段(17~20)', 20, 60);
--
/*被參照的表格先建，故先建立ACTIVITY表格*/
CREATE TABLE ACTIVITY(
ACTIVITY_ID    VARCHAR2(10)  NOT NULL ,
ACTIVITY_NAME  VARCHAR2(60)  NOT NULL,  
ACTIVITY_INFO  CLOB         NOT NULL,   
ACTIVITY_START DATE         NOT NULL,   
ACTIVITY_END   DATE         NOT NULL,
ACTIVITY_CODE  VARCHAR2(5),     
TOKEN_AMOUNT   NUMBER(5),       
ACTIVITY_POST  BLOB,
CONSTRAINT ACTIVITY_ID_PK PRIMARY KEY (ACTIVITY_ID)
);
CREATE SEQUENCE ACTIVITY_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    CACHE 10;


INSERT INTO ACTIVITY VALUES('AC'||LPAD(to_char(ACTIVITY_SEQ.NEXTVAL),3,'0'),'白色情人節',EMPTY_CLOB(),'2019-02-01','2019-03-14','FREE1',50,EMPTY_BLOB());
INSERT INTO ACTIVITY VALUES('AC'||LPAD(to_char(ACTIVITY_SEQ.NEXTVAL),3,'0'),'清明返鄉優惠',EMPTY_CLOB(),'2019-03-29','2019-04-08','FREE2',100,EMPTY_BLOB());
INSERT INTO ACTIVITY VALUES('AC'||LPAD(to_char(ACTIVITY_SEQ.NEXTVAL),3,'0'),'勞動節優惠',EMPTY_CLOB(),'2019-04-28','2019-05-04','FREE3',50,EMPTY_BLOB());
INSERT INTO ACTIVITY VALUES('AC'||LPAD(to_char(ACTIVITY_SEQ.NEXTVAL),3,'0'),'母親節優惠',EMPTY_CLOB(),'2019-05-05','2019-05-19','FREE4',100,EMPTY_BLOB());
INSERT INTO ACTIVITY VALUES('AC'||LPAD(to_char(ACTIVITY_SEQ.NEXTVAL),3,'0'),'端午返鄉優惠',EMPTY_CLOB(),'2019-06-01','2019-06-10','FREE5',100,EMPTY_BLOB());

--

/*再建立ACTIVITY_TOKEN表格*/
CREATE TABLE ACTIVITY_TOKEN(
MEM_ID       VARCHAR2(5)     NOT NULL,  
ACTIVITY_ID  VARCHAR2(10)    NOT NULL,
TOKEN_AMOUNT NUMBER(5)   NOT NULL,  
DEADLINE     DATE            NOT NULL,
CONSTRAINT PK_ACTIVITY_TOKEN PRIMARY KEY (MEM_ID, ACTIVITY_ID),
CONSTRAINT FK_TOKEN_MEMBER FOREIGN KEY (MEM_ID)
REFERENCES MEMBER(MEM_ID),
CONSTRAINT FK_TOKEN_ACTIVIT FOREIGN KEY (ACTIVITY_ID)
REFERENCES ACTIVITY(ACTIVITY_ID)
);

INSERT INTO ACTIVITY_TOKEN VALUES('M001','AC001',50,'2019-03-14');
INSERT INTO ACTIVITY_TOKEN VALUES('M002','AC001',50,'2019-03-14');
INSERT INTO ACTIVITY_TOKEN VALUES('M003','AC001',50,'2019-03-14');
INSERT INTO ACTIVITY_TOKEN VALUES('M004','AC001',50,'2019-03-14');
INSERT INTO ACTIVITY_TOKEN VALUES('M005','AC001',50,'2019-03-14');
INSERT INTO ACTIVITY_TOKEN VALUES('M006','AC001',50,'2019-03-14');
INSERT INTO ACTIVITY_TOKEN VALUES('M002','AC002',100,'2019-04-08');
INSERT INTO ACTIVITY_TOKEN VALUES('M003','AC003',50,'2019-05-04');
INSERT INTO ACTIVITY_TOKEN VALUES('M004','AC004',100,'2019-05-19');
INSERT INTO ACTIVITY_TOKEN VALUES('M005','AC005',100,'2019-06-10');
--
/* Create table Location*/
CREATE TABLE LOCATION(
    MEM_ID VARCHAR2(5),
    LOCATION VARCHAR2(20CHAR),
    /*Composite primary key needs to define by constraint command*/
    CONSTRAINT PK_LOCATION PRIMARY KEY (MEM_ID, LOCATION),
    CONSTRAINT FK_LOCATION_MEMBER FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID)
);
/*Insert location data*/
INSERT INTO LOCATION VALUES ('M004', '台北火車站');
INSERT INTO LOCATION VALUES ('M005', '台北市政府');
INSERT INTO LOCATION VALUES ('M005', '中央大學');
INSERT INTO LOCATION VALUES ('M006', '中壢火車站');
--
/*Creat table Instant_Message*/
CREATE TABLE INSTANT_MESSAGE(
    MEM_ID VARCHAR2(5),
    START_TIME DATE,
    MSG_RECORD CLOB,
    /*Composite primary key needs to define by constraint command*/
    CONSTRAINT PK_INSTANT_MESSAGE PRIMARY KEY(MEM_ID, START_TIME),
    CONSTRAINT FK_INSTANT_MESSAGE_MEMBER FOREIGN KEY(MEM_ID) REFERENCES MEMBER(MEM_ID)
);
/*Insert Instant message data*/
INSERT INTO INSTANT_MESSAGE VALUES('M001', SYSDATE, EMPTY_CLOB());
INSERT INTO INSTANT_MESSAGE VALUES('M002', SYSDATE, EMPTY_CLOB());
INSERT INTO INSTANT_MESSAGE VALUES('M003', SYSDATE, EMPTY_CLOB());
INSERT INTO INSTANT_MESSAGE VALUES('M004', SYSDATE, EMPTY_CLOB());
INSERT INTO INSTANT_MESSAGE VALUES('M005', SYSDATE, EMPTY_CLOB());
INSERT INTO INSTANT_MESSAGE VALUES('M006', SYSDATE, EMPTY_CLOB());
--
-- 建立儲值紀錄STORE_RECORD的表格
CREATE TABLE STORE_RECORD(
RECORD_ID  VARCHAR2(20)    NOT NULL,
MEM_ID     VARCHAR2(5)    NOT NULL,
SAVE_DATE  DATE NOT NULL,
AMOUNT     NUMBER(7,0) NOT NULL,
CONSTRAINT STO_MEM_ID_FK FOREIGN KEY(MEM_ID) REFERENCES MEMBER (MEM_ID),
CONSTRAINT RECORD_ID_PK PRIMARY KEY (RECORD_ID)

);
-- 建立儲值紀錄STORE_RECORD的假資料
CREATE SEQUENCE STO_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

INSERT INTO STORE_RECORD VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(STO_SEQ.NEXTVAL), 4, '0'), 'M001', SYSDATE, 50);
INSERT INTO STORE_RECORD VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(STO_SEQ.NEXTVAL), 4, '0'), 'M003', SYSDATE, 500);
INSERT INTO STORE_RECORD VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(STO_SEQ.NEXTVAL), 4, '0'), 'M001', SYSDATE, 450);
INSERT INTO STORE_RECORD VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(STO_SEQ.NEXTVAL), 4, '0'), 'M004', SYSDATE, 1000);
INSERT INTO STORE_RECORD VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(STO_SEQ.NEXTVAL), 4, '0'), 'M001', SYSDATE, 2000);
INSERT INTO STORE_RECORD VALUES(to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(STO_SEQ.NEXTVAL), 4, '0'), 'M001', SYSDATE, 500);
--
CREATE TABLE BROADCAST(
MSG_ID  VARCHAR2 (6)    NOT NULL,
MEM_ID  VARCHAR2 (5)   NOT NULL,
MESSAGE  CLOB    NOT NULL,
CONFIRMED    NUMBER(1,0),
CONSTRAINT BROADCAST_FK_MEMBER FOREIGN KEY(MEM_ID) REFERENCES MEMBER(MEM_ID),
CONSTRAINT MSG_ID_PK PRIMARY KEY (MSG_ID)

);
CREATE SEQUENCE MSG_ID_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

INSERT INTO BROADCAST (MSG_ID, MEM_ID, MESSAGE, CONFIRMED)
VALUES ('MSG'||LPAD(to_char(MSG_ID_SEQ.NEXTVAL),3,'0'), 'M001', '豬年行大運，凡是生肖屬豬的一律打88折，到3月底喔~', '0');
INSERT INTO BROADCAST (MSG_ID, MEM_ID, MESSAGE, CONFIRMED)
VALUES ('MSG'||LPAD(to_char(MSG_ID_SEQ.NEXTVAL),3,'0'), 'M001', '櫻花祭，搭車折返指定賞櫻地點可享88折', '0');
INSERT INTO BROADCAST (MSG_ID, MEM_ID, MESSAGE, CONFIRMED)
VALUES ('MSG'||LPAD(to_char(MSG_ID_SEQ.NEXTVAL),3,'0'), 'M001', '天氣忽冷忽熱，記得保暖衣物~', '0');
INSERT INTO BROADCAST (MSG_ID, MEM_ID, MESSAGE, CONFIRMED)
VALUES ('MSG'||LPAD(to_char(MSG_ID_SEQ.NEXTVAL),3,'0'), 'M001', '清明節返鄉優惠早鳥票開放售票', '0');


--
/* Create squence single order*/
CREATE SEQUENCE SEQ_SINGLE_ORDER
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    CACHE 10;

/* Create table single order*/
CREATE TABLE SINGLE_ORDER(
    ORDER_ID VARCHAR2(13) ,
    DRIVER_ID VARCHAR2(5),
    MEM_ID VARCHAR2(5),
    STATE NUMBER(1),
    START_TIME TIMESTAMP,
    END_TIME TIMESTAMP,
    START_LOC VARCHAR2(20CHAR),
    END_LOC VARCHAR2(20CHAR),
    START_LNG NUMBER(6, 3),
    START_LAT NUMBER(6, 3),
    END_LNG NUMBER(6, 3),
    END_LAT NUMBER(6, 3),
    TOTAL_AMOUNT NUMBER(5),
    ORDER_TYPE NUMBER(1),
    RATE NUMBER(1),
    NOTE VARCHAR2(20CHAR),
    LAUNCH_TIME TIMESTAMP,
    CONSTRAINT ORDER_ID_PK PRIMARY KEY (ORDER_ID),
    CONSTRAINT SINGLE_ORDER_MEMBER_FK FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT SINGLE_ORDER_DRIVER_FK FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER(DRIVER_ID));

INSERT INTO SINGLE_ORDER(
    ORDER_ID, DRIVER_ID, MEM_ID, 
    STATE, START_TIME, END_TIME,
    START_LOC, END_LOC, START_LNG,
    START_LAT, END_LNG, END_LAT,
    TOTAL_AMOUNT, ORDER_TYPE, LAUNCH_TIME) 

VALUES (
    SEQ_SINGLE_ORDER.NEXTVAL, 'D002', 'M001',
    5, TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'),
    '台北火車站', '台北101', 245.568, 245.568, 245.568, 245.568
, 100, 0, TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO SINGLE_ORDER(
    ORDER_ID, DRIVER_ID, MEM_ID, 
    STATE, START_TIME, END_TIME,
    START_LOC, END_LOC, START_LNG,
        START_LAT, END_LNG, END_LAT,
    TOTAL_AMOUNT, ORDER_TYPE, LAUNCH_TIME) VALUES (
    SEQ_SINGLE_ORDER.NEXTVAL, 'D001', 'M001',
    5, TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'),
    '中央大學', '中壢火車站', 245.568, 245.568, 245.568, 245.568,100,
    0, TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO SINGLE_ORDER(
    ORDER_ID, DRIVER_ID, MEM_ID, 
    STATE, START_TIME, END_TIME,
    START_LOC, END_LOC, START_LNG,
        START_LAT, END_LNG, END_LAT,
    TOTAL_AMOUNT, ORDER_TYPE, LAUNCH_TIME) VALUES (
    SEQ_SINGLE_ORDER.NEXTVAL, 'D002', 'M001',
    5, TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'),
    '台北火車站', '台北101', 245.568, 245.568, 245.568, 245.568, 100,
    0, TO_TIMESTAMP ('2019-02-14 05:20:00', 'YYYY-MM-DD HH24:MI:SS'));
--
-- 建立付款紀錄PAYMENT_RECORD的表格
CREATE TABLE PAYMENT_RECORD(
PAYMENT_ID  VARCHAR2(20)  NOT NULL,
DRIVER_ID   VARCHAR2(5)    NOT NULL,
PAY_AMOUNT  NUMBER(7,0)  NOT NULL,
PAY_TIME    DATE           NOT NULL,
--CONSTRAINT PAYMENT_DRIVER_ID_FK FOREIGN KEY(DRIVER_ID) REFERENCES DRIVER(DRIVER_ID),
--建立外來鑑參考司機的DRIVE_ID
CONSTRAINT PAYMENT_ID_PK PRIMARY KEY (PAYMENT_ID)
);


CREATE SEQUENCE PAY_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;
-- 建立付款紀錄PAYMENT_RECORD的假資料
INSERT INTO PAYMENT_RECORD VALUES (to_char(sysdate,'yyyymm')||'-'||LPAD(to_char(PAY_SEQ.NEXTVAL), 3, '0'), 'M003', 10000, SYSDATE);
INSERT INTO PAYMENT_RECORD VALUES (to_char(sysdate,'yyyymm')||'-'||LPAD(to_char(PAY_SEQ.NEXTVAL), 3, '0'), 'M004', 30600, SYSDATE);
--
--建立檢舉司機單TABLE--
CREATE TABLE DRIVER_REPORT(
    DREPORT_ID VARCHAR2(5) NOT NULL,
    MEM_ID VARCHAR2(5) NOT NULL,
    ADMIN_ID VARCHAR2(5) NOT NULL,
    ORDER_ID VARCHAR2(5) NOT NULL,
    CONTENT VARCHAR2(150) NOT NULL,
    TIME DATE NOT NULL,
    STATE NUMBER(1,0) NOT NULL,
    CONSTRAINT DRIVER_REPORT_PK PRIMARY KEY(DREPORT_ID),
    CONSTRAINT DRIVER_REPORT_FK_MEMBER FOREIGN KEY(MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT DRIVER_REPORT_FK_ADMIN FOREIGN KEY(ADMIN_ID) REFERENCES ADMIN(ADMIN_ID),
    CONSTRAINT DRIVER_REPORT_FK_SINGLE_ORDER FOREIGN KEY(ORDER_ID) REFERENCES SINGLE_ORDER(ORDER_ID)
);

CREATE SEQUENCE DREPORT_ID_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

INSERT INTO DRIVER_REPORT (DREPORT_ID, MEM_ID, ADMIN_ID, ORDER_ID, CONTENT, TIME, STATE)
VALUES ('DR'||LPAD(to_char(DREPORT_ID_SEQ.NEXTVAL),3,'0'), 'M001', 'A001', '1', '司機很無禮', '2019-02-14 07:30:00', '1');
INSERT INTO DRIVER_REPORT (DREPORT_ID, MEM_ID, ADMIN_ID, ORDER_ID, CONTENT, TIME, STATE)
VALUES ('DR'||LPAD(to_char(DREPORT_ID_SEQ.NEXTVAL),3,'0'), 'M001', 'A002', '2', '司機態度不佳', '2019-02-14 08:30:00', '1');
INSERT INTO DRIVER_REPORT (DREPORT_ID, MEM_ID, ADMIN_ID, ORDER_ID, CONTENT, TIME, STATE)
VALUES ('DR'||LPAD(to_char(DREPORT_ID_SEQ.NEXTVAL),3,'0'), 'M001', 'A001', '3', '司機態度不佳', '2019-02-14 09:30:00', '1');
-------------
--揪團
CREATE TABLE GROUP_BAND(
 GROUP_ID VARCHAR2 (5)  NOT NULL,
 CONTENT CLOB          NOT NULL,
 LAUNCH_TIME TIMESTAMP  NOT NULL,
 INTRODUCTION CLOB     NOT NULL,
 GROUP_STATUS NUMBER (1)   NOT NULL,
 CURRENT_NUM NUMBER (1)   NOT NULL,
 UPPER_LIMIT NUMBER (1)   NOT NULL,
 LOWER_LIMIT NUMBER (1)   NOT NULL,
 GROUP_NAME VARCHAR2 (60)   NOT NULL,
 GROUP_LEADER VARCHAR2 (5)   NOT NULL,
 START_LOC VARCHAR2 (20)   NOT NULL,
 END_LOC VARCHAR2 (20)   NOT NULL,
 PRIVATES NUMBER (1)   NOT NULL,
 PHOTO BLOB    ,
 GROUP_TYPE VARCHAR2 (30)   ,
 TOTAL_AMOUT NUMBER (5)   NOT NULL,
 START_TIME TIMESTAMP    ,
 RATE NUMBER (1)   ,
 NOTE VARCHAR2 (60),
 
  CONSTRAINT GROUP_BAND_FK_MEMBER FOREIGN KEY(GROUP_LEADER) REFERENCES MEMBER(MEM_ID),
 CONSTRAINT GROUP_ID_PK PRIMARY KEY (GROUP_ID)


);
CREATE SEQUENCE GROUP_BAND_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    CACHE 10;
    
INSERT INTO GROUP_BAND VALUES('G'||LPAD(to_char(GROUP_BAND_SEQ.NEXTVAL),3,'0'),EMPTY_CLOB(),to_timestamp('2019/02/04','yyyy/mm/dd'),EMPTY_CLOB(),1,1,2,4,'五月天演唱會','M001','桃園火車站','中壢火車站',1,EMPTY_BLOB(),'演唱會',5000,to_timestamp('2019/02/15','yyyy/mm/dd'),5,'不錯ㄟ');
INSERT INTO GROUP_BAND VALUES('G'||LPAD(to_char(GROUP_BAND_SEQ.NEXTVAL),3,'0'),EMPTY_CLOB(),to_timestamp('2019/02/05','yyyy/mm/dd'),EMPTY_CLOB(),1,1,2,4,'道地ㄟ美食','M001','台南火車站','高雄火車站',1,EMPTY_BLOB(),'美食',2500,to_timestamp ('2019/02/10','yyyy/mm/dd'),5,'好吃ㄟ');
--揪團成員
CREATE TABLE GROUP_MEM( 
GROUP_ID VARCHAR2 (5)  PRIMARY KEY  NOT NULL,
MEM_ID VARCHAR2 (5)    NOT NULL,
STATE NUMBER (1)        NOT NULL,
CONSTRAINT GROUP_ID_FK FOREIGN KEY (GROUP_ID) REFERENCES GROUP_BAND (GROUP_ID),
CONSTRAINT MEM_ID_FK FOREIGN KEY (MEM_ID) REFERENCES MEMBER (MEM_ID)
);
INSERT INTO GROUP_MEM VALUES('G001','M001',0);
INSERT INTO GROUP_MEM VALUES('G002','M002',0);
-----揪團訂單
CREATE TABLE GROUP_ORDER(
 GORDER_ID VARCHAR2 (8)    NOT NULL,
 DRIVER_ID VARCHAR2 (5)     ,
 MEM_ID    VARCHAR2 (5)       ,
 STATE NUMBER (1)   NOT NULL,
 TOTAL_AMOUT NUMBER (5)   NOT NULL,
 LAUNCH_TIME TIMESTAMP    NOT NULL,
 START_TIME TIMESTAMP    ,
 END_TIME TIMESTAMP    ,
 START_LNG NUMBER (6,3)   NOT NULL,
 START_LAT NUMBER (6,3)   NOT NULL,
 END_LNG NUMBER (6,3)   NOT NULL,
 END_LAT NUMBER (6,3)   NOT NULL,
 ORDER_TYPE NUMBER (1)   NOT NULL,
 RATE NUMBER (1)   ,
 NOTE VARCHAR2 (60)   ,
CONSTRAINT DRIVER_ID_FK FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER (DRIVER_ID),
CONSTRAINT MEM_ID FOREIGN KEY (MEM_ID) REFERENCES MEMBER (MEM_ID),
CONSTRAINT GORDER_ID_PK PRIMARY KEY (GORDER_ID)
) ;
CREATE SEQUENCE GODR_ID_SEQ
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

--
INSERT INTO GROUP_ORDER VALUES('GODR'||LPAD(to_char(GODR_ID_SEQ.NEXTVAL),3,'0')
,'D001','M001',0,1500,to_timestamp ('2019/02/5 15:05:20' , 'yyyy/mm/dd hh24:mi:ss'),to_timestamp('2019/02/08 09:20:25' , 'yyyy/mm/dd hh24:mi:ss'),to_timestamp('2019/2/08 09:50:25' , 'yyyy/mm/dd hh24:mi:ss') ,245.568,245.568,245.568,245.568,0,0,'無');
INSERT INTO GROUP_ORDER VALUES('GODR'||LPAD(to_char(GODR_ID_SEQ.NEXTVAL),3,'0')
,'D002','M002',0,500,to_timestamp ('2019/02/8 20:07:25' , 'yyyy/mm/dd hh24:mi:ss'),to_timestamp('2019/02/10 08:07:25' , 'yyyy/mm/dd hh24:mi:ss'),to_timestamp('2019/2/10 10:20:25' , 'yyyy/mm/dd hh24:mi:ss') ,245.568,245.568,245.568,245.568,0,0,'無');
--建立檢舉揪團TABLE--
CREATE TABLE GROUP_REPORT(
    GREPORT_ID VARCHAR2(5) NOT NULL,
    MEM_ID VARCHAR2(5) NOT NULL,
    GROUP_ID VARCHAR2(5) NOT NULL,
    ADMIN_ID VARCHAR2(5) NOT NULL,
    CONTENT VARCHAR2(150) NOT NULL,
    TIME DATE NOT NULL,
    STATE NUMBER(1,0) NOT NULL,
    CONSTRAINT GROUP_REPORT_PK PRIMARY KEY(GREPORT_ID),
    CONSTRAINT GROUP_REPORT_FK_MEMBER FOREIGN KEY(MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT GROUP_REPORT_FK_GROUP FOREIGN KEY(GROUP_ID) REFERENCES GROUP_BAND(GROUP_ID),
    CONSTRAINT GROUP_REPORT_FK_ADMIN FOREIGN KEY(ADMIN_ID) REFERENCES ADMIN(ADMIN_ID)
);

CREATE SEQUENCE GREPORT_ID_SEQ
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

INSERT INTO GROUP_REPORT (GREPORT_ID, MEM_ID, GROUP_ID, ADMIN_ID, CONTENT, TIME, STATE)
VALUES ('GR'||LPAD(to_char(GREPORT_ID_SEQ.NEXTVAL),3,'0'), 'M001', 'G001' , 'A001', '揪團內容怪怪的', '2019-02-14 07:30:00','1');
INSERT INTO GROUP_REPORT (GREPORT_ID, MEM_ID, GROUP_ID, ADMIN_ID, CONTENT, TIME, STATE)
VALUES ('GR'||LPAD(to_char(GREPORT_ID_SEQ.NEXTVAL),3,'0'), 'M001', 'G001' , 'A001', '揪團內容怪怪的', '2019-02-14 07:30:00','1');
INSERT INTO GROUP_REPORT (GREPORT_ID, MEM_ID, GROUP_ID, ADMIN_ID, CONTENT, TIME, STATE)
VALUES ('GR'||LPAD(to_char(GREPORT_ID_SEQ.NEXTVAL),3,'0'), 'M002', 'G001' , 'A001', '揪團內容怪怪的', '2019-02-14 07:30:00','1');

--COMMIT;



