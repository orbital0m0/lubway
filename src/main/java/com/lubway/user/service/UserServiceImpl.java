package com.lubway.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lubway.user.UserDAO;
import com.lubway.user.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO dao;
	
	@Override
	public int idCheck(String id) {
		return dao.idCheck(id);
	}
	
	@Override
	public void insertUser(UserVO vo) {
		dao.insertUser(vo);
	}

	@Override
	public UserVO getUser(UserVO vo) {
		return dao.getUser(vo);
	}

}