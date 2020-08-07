package com.mycompany.myapp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.myapp.model.FriendBean;





@Repository
public class FriendDAOImpl {
	
	@Autowired
	private SqlSession sqlSession;
	
	//member information save
//	@Transactional
	public int addFriend(Map m) throws Exception {
//		getSession();
		return sqlSession.insert("friendns.add_friend", m);
	}

	public List<FriendBean> list(String email) {
		return sqlSession.selectList("friendns.list", email) ;
	}
	
	public int delFriend(FriendBean bean) throws Exception {
		return sqlSession.delete("friendns.del_friend", bean);
	}


}
