
create table member (
	email varchar2(50),
	pwd	varchar2(20) not null,
	nickname varchar2(50) not null,
	addr1 varchar2(100) not null,
	addr2 varchar2(100),
	addr3 varchar2(100),
	x_ varchar2(20) not null,
	y_ varchar2(20) not null,
	constraint member_pk primary key(email)
);
insert into friend_confirm values('kjs930703@naver.com','6@1.qq', 0)
create table friend_confirm(
	inviter varchar2(50) not null,
	invitee varchar2(50) not null,
	status number(10) default 0,
	constraint friend_confirm_fk1 foreign key(inviter) references member(email),
	constraint friend_confirm_fk2 foreign key(invitee) references member(email),
	constraint friend_confirm_pk1 primary key(inviter, invitee)
)

create table friendship (
	fno	number(20), 
	email1 varchar2(50),
	email2 varchar2(50),
	constraint friendship_fk1 foreign key(email1) references member(email),
	constraint friendship_fk2 foreign key(email2) references member(email),
	constraint friendship_pk primary key(fno)
);

insert into member values('3@1.qq','123','123','123','123','123','123','123');
insert into member values('4@1.qq','123','123','123','123','123','123','123');
insert into member values('5@1.qq','123','123','123','123','123','123','123');
insert into member values('6@1.qq','123','123','123','123','123','123','123');
insert into member values('7@1.qq','123','123','123','123','123','123','123');
insert into member values('8@1.qq','123','123','123','123','123','123','123');

insert into member values('2@1.qq','123','123','123','123','123','123','123')


delete FRIENDSHIP where email2 ='2@1.qq';
delete FRIENDSHIP where email2 ='1@1.qq';
create sequence friend_seq increment by 1 start with 1 nocache;

select * from member;
select * from friendship;
select * from FRIEND_CONFIRM
select * from tab;
select * from route;
SELECT * FROM ALL_TRIGGERS;
