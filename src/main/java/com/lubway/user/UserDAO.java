package com.lubway.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int idCheck(String id) {
		System.out.println("ID 중복 검증");
		return sqlSessionTemplate.selectOne("UserDAO.idCheck", id);
	}
	
	public void insertUser(UserVO vo) {
		System.out.println("DB에 회원 등록");
		sqlSessionTemplate.insert("UserDAO.insertUser", vo);
	}
	
	public UserVO getUser(String id) {
		System.out.println("UserDAO - getUser() 실행");
		return sqlSessionTemplate.selectOne("UserDAO.getUser", id);
	}
	
	public String getId(String tel) {
		System.out.println("UserDAO - getId() 실행");
		return sqlSessionTemplate.selectOne("UserDAO.getId", tel);
	}
	
	public void updateUser(UserVO vo) {
		System.out.println("UserDAO - updateUser() 실행");
		sqlSessionTemplate.update("UserDAO.updateUser", vo);
	}

	public void deleteUser(UserVO vo) {
		System.out.println("UserDAO - deleteUser() 실행");
		sqlSessionTemplate.delete("UserDAO.deleteUser", vo);
	}
	
	public void updatePwd(UserVO vo) {
		System.out.println("UserDAO - updatePwd() 실행");
		sqlSessionTemplate.update("UserDAO.updatePwd", vo);
	}
}
