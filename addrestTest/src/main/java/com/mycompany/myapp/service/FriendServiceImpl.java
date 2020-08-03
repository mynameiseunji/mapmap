package com.mycompany.myapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.dao.FriendDAOImpl;
import com.mycompany.myapp.dao.MemberDAOImpl;


@Service
public class FriendServiceImpl {
	
	@Autowired
	private MemberDAOImpl memberDao;
	private FriendDAOImpl friendDao;
	
	public int checkMemberEmail(String email) throws Exception{
		return memberDao.checkMemberEmail(email);
	}
}
