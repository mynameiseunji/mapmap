package com.mycompany.myapp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.myapp.model.FriendBean;
import com.mycompany.myapp.model.MemberBean;

@Repository
public class FriendDAOImpl {

	@Autowired
	private SqlSession sqlSession;

	// member information save
//	@Transactional
	public int addFriend(Map m) throws Exception {
//		getSession();
		return sqlSession.insert("friendns.add_friend", m);
	}

	public int checkFriend(Map m) throws Exception {

		int re = 1;

		FriendBean fb = (FriendBean) sqlSession.selectOne("friendns.check_friend", m);

		if (fb != null)
			re = -1;
		return re;
		// return sqlSession.selectOne("friendns.check_friend", m);
	}

	public List<FriendBean> list(String email) {
		return sqlSession.selectList("friendns.list", email);
	}

	public int delFriend(FriendBean bean) throws Exception {
		return sqlSession.delete("friendns.del_friend", bean);
	}

}