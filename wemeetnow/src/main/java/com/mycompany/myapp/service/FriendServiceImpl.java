package com.mycompany.myapp.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.myapp.dao.FriendDAOImpl;
import com.mycompany.myapp.dao.MemberDAOImpl;
import com.mycompany.myapp.model.FriendBean;
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
	
	public List<FriendBean> list(String email){
		return friendDao.list(email);
	}

	public int delFriend(FriendBean bean) throws Exception{
		
		return friendDao.delFriend(bean);
	}
	public int checkMemberEmail(String email) throws Exception{
		return memberDao.checkMemberEmail(email);
	}
	
	public String[] frListSession(List<FriendBean> list) throws Exception {
		String[] str = new String[4];
		StringBuffer fr_email = new StringBuffer();
        StringBuffer fr_nick = new StringBuffer();
        StringBuffer fr_x = new StringBuffer();
        StringBuffer fr_y = new StringBuffer();
        for(FriendBean fb : list) {
        	MemberBean f = memberDao.userCheck(fb.getEmail2());
            fr_email.append(f.getEmail()).append("#");
            fr_nick.append(f.getNickname()).append("#");
            fr_x.append(f.getX_()).append("#");
            fr_y.append(f.getY_()).append("#");
        }
        str[0]=fr_email.toString();
        str[1]=fr_nick.toString();
        str[2]=fr_x.toString();
        str[3]=fr_y.toString();
		return str;
	}
}
