package com.mycompany.myapp.service;

import java.util.List;
import java.util.Map;

import com.mycompany.myapp.model.FriendBean;
import com.mycompany.myapp.model.FriendConfirm;

public interface FriendService {

	int addFriend(Map m) throws Exception;

	int checkFriend(Map m) throws Exception;

	List<FriendBean> list(String email);

	int delFriend(Map<String, String> m) throws Exception;

	int checkMemberEmail(String email) throws Exception;

	List<FriendConfirm> invite(String email);

	List<FriendConfirm> invited(String email);

	int accept(FriendConfirm fc);

	int checkFriendConfirm(Map m) throws Exception;

	List<FriendBean> recommend(String email);

	int reject(FriendConfirm fc);

}