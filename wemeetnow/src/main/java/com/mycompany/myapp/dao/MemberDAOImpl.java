package com.mycompany.myapp.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mycompany.myapp.model.MemberBean;

@Repository
public class MemberDAOImpl {
	
	@Autowired
	private SqlSession sqlSession;

	//email duplicate check
//	@Transactional
	public int checkMemberEmail(String email) throws Exception {
//		getSession();
		int re = -1;	//id not exists
		MemberBean mb = (MemberBean) sqlSession.selectOne("memberns.login_check", email);
		if (mb != null)
			re = 1; 	//id exists
		return re;
	}	

//	//password find
////	@Transactional
//	public MemberBean findpwd(MemberBean pm) throws Exception {
////		getSession();
//		return (MemberBean) sqlSession.selectOne("memberns.pwd_find", pm);
//	}

	//member information save
//	@Transactional
	public void insertMember(MemberBean m) throws Exception {
//		getSession();
		sqlSession.insert("memberns.member_join", m);
	}

	//member verification
//	@Transactional
	public MemberBean userCheck(String email) throws Exception {
//		getSession();
		return (MemberBean) sqlSession.selectOne("memberns.login_check", email);
	}

	//member information update
//	@Transactional
	public void updateMember(MemberBean member) throws Exception {
//		getSession();
		sqlSession.update("memberns.member_edit", member);
	}

	//member deletion
//	@Transactional
	public void deleteMember(MemberBean delm) throws Exception {
//		getSession();
		sqlSession.delete("memberns.member_delete", delm);
	}
}
