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
	public void updateUser(UserVO vo) {
		dao.updateUser(vo);
	}

	@Override
	public UserVO getUser(String id) {
		return dao.getUser(id);
	}

	@Override
	public String getId(String tel) {
		return dao.getId(tel);
	}
		
	public void deleteUser(UserVO vo) {
		dao.deleteUser(vo);	
	}

	@Override
	public void updatePwd(UserVO vo) {
		dao.updatePwd(vo);
	}

	@Override
	public int telCheck(String tel) {
		return dao.telCheck(tel);
	}

}
