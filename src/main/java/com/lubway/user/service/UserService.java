package com.lubway.user.service;

import com.lubway.user.UserVO;

public interface UserService {

	int idCheck(String id);
	
	void insertUser(UserVO vo);
	
	void updateUser(UserVO vo);

	UserVO getUser(UserVO vo);
<<<<<<< HEAD
	
	String getId(String tel);
=======

	void deleteUser(UserVO vo);
>>>>>>> feature/myway
}