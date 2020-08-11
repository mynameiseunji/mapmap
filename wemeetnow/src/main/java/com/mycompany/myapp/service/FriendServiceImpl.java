package com.mycompany.myapp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.dao.FriendDAOImpl;
import com.mycompany.myapp.dao.MemberDAOImpl;
import com.mycompany.myapp.model.FriendBean;
import com.mycompany.myapp.model.FriendConfirm;
import com.mycompany.myapp.model.MemberBean;


@Service
public class FriendServiceImpl {
	
	@Autowired
	private MemberDAOImpl memberDao;
	@Autowired
	private FriendDAOImpl friendDao;
	
	public int addFriend(Map m) throws Exception{
		return friendDao.addFriend(m);
	}
	
	public int checkFriend(Map m) throws Exception{
		return friendDao.checkFriend(m);
	}
	
	public List<FriendBean> list(String email){
		return friendDao.list(email);
	}

	public int delFriend(Map<String, String> m) throws Exception{
		return friendDao.delFriend(m);
	}
	
	public int checkMemberEmail(String email) throws Exception{
		return memberDao.checkMemberEmail(email);
	}
	
	public List<FriendConfirm> invite(String email){
		return friendDao.invite(email);
	}

	public List<FriendConfirm> invited(String email) {
		return friendDao.invited(email);
	}

	public int accept(FriendConfirm fc) {
		return friendDao.accept(fc);
	}
	public int checkFriendConfirm(Map m) throws Exception {
		return friendDao.checkFriendConfirm(m);
	}

	public List<FriendBean> recommend(String email) {
		return friendDao.recommend(email);
	}
}
