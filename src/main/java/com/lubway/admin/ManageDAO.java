package com.lubway.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lubway.store.StoreInfoVO;
import com.lubway.user.UserVO;

@Repository
public class ManageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void insertStore(StoreVO vo) {
		System.out.println("ManageDAO - insertStore() 실행");
		sqlSessionTemplate.insert("StoreDAO.insertStore", vo);
	}
	
	public void insertStoreInfo(StoreInfoVO vo) {
		System.out.println("ManageDAO - insertStoreInfo() 실행");
		sqlSessionTemplate.insert("StoreInfoDAO.insertStoreInfo", vo);
	}
	
	public List<UserVO> getUserList(){
		System.out.println("ManageDAO - getUserList() 실행");
		return sqlSessionTemplate.selectList("AdminDAO.getUserList");
	}

	public void updateStatus(UserVO vo) {
		System.out.println("ManageDAO - updateStatus() 실행");
		sqlSessionTemplate.update("AdminDAO.updateStatus", vo);
	}

	public List<StoreVO> getStoreList() {
		System.out.println("ManageDAO - getStroeList() 실행");
		return sqlSessionTemplate.selectList("AdminDAO.getStoreList");
	}
	
}
