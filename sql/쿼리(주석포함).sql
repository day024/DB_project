--REGION TABLE---
-- 지역 정보를 담음 
-- 지역 ID, 이름 

DROP TABLE IF EXISTS REGION;

CREATE TABLE REGION (
REGION_ID int PRIMARY KEY,
REGION_NAME varchar(1024) NOT null
);

-- cvs import

SELECT * FROM REGION R;


--CENTER1 TABLE--
-- center 정보를 담음
-- 지역 ID, 센터 ID, 센터이름, 센터 종류, 센터 주소, 센터연락처, 센터 홈페이지, 센터 시간
-- 센터 ID는 

DROP TABLE IF EXISTS CENTER1;

CREATE TABLE CENTER1(
CENTER_ID int PRIMARY KEY,
REGION_ID int,
CENTER_NAME varchar(1024),
CENTER_TYPE varchar(1024),
CENTER_ADDRESS varchar(1024),
CENTER_HOMEPAGE varchar(1024),
CENTER_CONTACT varchar(1024),
CENTER_TIME varchar(1024),
FOREIGN KEY (REGION_ID) REFERENCES REGION(REGION_ID)
);

-- cvs import
SELECT * FROM CENTER1 C;

--CONFERENCE TABLE-- 
DROP TABLE IF EXISTS conference;

CREATE TABLE CONFERENCE(
CONFERENCE_ID INT PRIMARY KEY,
CENTER_ID INT,
CONFERENCE_NAME VARCHAR(1024),
CONFERENCE_TIME VARCHAR(1024),
CONFERENCE_AMOUNT VARCHAR(1024),
CONFERENCE_NUM VARCHAR(1024),
FOREIGN KEY (CENTER_ID) REFERENCES CENTER1(CENTER_ID)
);
-- cvs import

SELECT * FROM CONFERENCE CF;

-- PROGRAM TABLE --
DROP TABLE IF EXISTS PROGRAM;

CREATE TABLE PROGRAM(
PROGRAM_ID VARCHAR(1024) PRIMARY KEY,
CENTER_ID INT,
PROGRAM_NAME VARCHAR(1024),
PROGRAM_TIME VARCHAR(1024),
PROGRAM_CONTENT VARCHAR(1024),
PROGRAM_NUM VARCHAR(1024),
FOREIGN KEY (CENTER_ID) REFERENCES CENTER1(CENTER_ID)
);

SELECT * FROM PROGRAM P;

--MEMBER TABLE--
DROP TABLE IF EXISTS MEMBER;

CREATE TABLE MEMBER(
MEMBER_ID INT PRIMARY KEY NOT NULL,
REGION_ID INT,
MEMBER_NAME VARCHAR(1024),
PASSWORD VARCHAR(1024),
FOREIGN KEY (REGION_ID) REFERENCES REGION(REGION_ID)
);

--cvs import

SELECT * FROM MEMBER m;

-- REVIEW TABLE --
DROP TABLE IF EXISTS review;

CREATE TABLE review(
review_num int PRIMARY KEY NOT NULL,
center_id int,
MEMBER_id int,
review_content varchar(1024),
review_rate float,
FOREIGN KEY (CENTER_ID) REFERENCES CENTER1(CENTER_ID),
FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);


SELECT * FROM review r;

commit;

--센터의 운영요일/시간 검색
select 
 	c.*
FROM
	center1 c
WHERE
	C.center_time LIKE '%토%';


--특정 센터의 리뷰보기
SELECT
	c.center_id,
	c.center_name,
	
	r.review_content ,
	r.review_rate
FROM
	center1 c
INNER JOIN review r 
on
	c.center_id = r.center_id
WHERE 
	c.center_id = 83
	
;


-- 지역별로 센터보기 
select 
 	c.*
FROM
	center1 c
WHERE
	region_id = 6;
	

-- 지역별로 회의실보기  
SELECT
	c2.*
FROM
	center1 c2
INNER JOIN conference c3 
on
	c2.center_id = c3.center_id
	
where c2.region_id=6;




--center의 평점평균 내림차순으로 center에 대한 정보 함께보기
select
	r2.center_id,
	avg(r2.review_rate),	
	c4.center_name
FROM
	review r2
inner join center1 c4 
on c4.center_id =r2.center_id 

GROUP BY
	r2.center_id,
	r2.review_rate,
	c4.center_name

ORDER BY
	avg(r2.review_rate) desc nulls last

;

