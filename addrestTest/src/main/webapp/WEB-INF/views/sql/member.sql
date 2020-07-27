
create table member (
	email varchar2(50),
	pwd	varchar2(20) not null,
	nickname varchar2(50) not null,
	addr1 varchar2(100) not null,
	addr2 varchar2(100),
	addr3 varchar2(100),
	constraint member_pk primary key(email)
);

create table friendship (
	email1 varchar2(50),
	email2 varchar2(50),
	constraint friendship_fk1 foreign key(email1) references member(email),
	constraint friendship_fk2 foreign key(email2) references member(email),
	constraint friendship_pk primary key(email1, email2)
);

select * from member;
select * from friendship;
select * from tab;

