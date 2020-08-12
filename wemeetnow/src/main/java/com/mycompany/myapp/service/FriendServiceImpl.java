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
public class FriendServiceImpl implements FriendService {
	
	@Autowired
	private MemberDAOImpl memberDao;
	@Autowired
	private FriendDAOImpl friendDao;
	
	@Override
	public int addFriend(Map m) throws Exception{
		return friendDao.addFriend(m);
	}
	
	@Override
	public int checkFriend(Map m) throws Exception{
		return friendDao.checkFriend(m);
	}
	
	@Override
	public List<FriendBean> list(String email){
		return friendDao.list(email);
	}

	@Override
	public int delFriend(Map<String, String> m) throws Exception{
		return friendDao.delFriend(m);
	}
	
	@Override
	public int checkMemberEmail(String email) throws Exception{
		return memberDao.checkMemberEmail(email);
	}
	
	@Override
	public List<FriendConfirm> invite(String email){
		return friendDao.invite(email);
	}

	@Override
	public List<FriendConfirm> invited(String email) {
		return friendDao.invited(email);
	}

	@Override
	public int accept(FriendConfirm fc) {
		return friendDao.accept(fc);
	}
	@Override
	public int checkFriendConfirm(Map m) throws Exception {
		return friendDao.checkFriendConfirm(m);
	}

	@Override
	public List<FriendBean> recommend(String email) {
		return friendDao.recommend(email);
	}
}
