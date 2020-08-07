package com.mycompany.myapp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.dao.FriendDAOImpl;
import com.mycompany.myapp.dao.MemberDAOImpl;
import com.mycompany.myapp.model.FriendBean;


@Service
public class FriendServiceImpl {
	
	@Autowired
	private MemberDAOImpl memberDao;
	@Autowired
	private FriendDAOImpl friendDao;
	
	public int addFriend(Map m) throws Exception{
		
		return friendDao.addFriend(m);
	}
	
	public List<FriendBean> list(String email){
		return friendDao.list(email);
	}

	public int delFriend(FriendBean bean) throws Exception{
		
		return friendDao.delFriend(bean);
	}
	public int checkMemberEmail(String email) throws Exception{
		return memberDao.checkMemberEmail(email);
	}
}
