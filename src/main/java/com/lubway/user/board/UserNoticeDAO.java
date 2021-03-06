package com.lubway.user.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lubway.user.UserPagination;

@Repository
public class UserNoticeDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int getUserPageListCnt() {
		return sqlSessionTemplate.selectOne("UserNoticeDAO.pagingCnt");
	}

	public int getSearchTitleCnt(String title) {
		return sqlSessionTemplate.selectOne("UserNoticeDAO.searchTitleCnt", title);
	}

	public List<UserNoticeVO> getUserSearchPagingList(UserPagination pagination) {
		return sqlSessionTemplate.selectList("UserNoticeDAO.searchPagingList", pagination);
	}

	// 사용자 공지사항
	public UserNoticeVO getUserNotice(UserNoticeVO vo) {
		System.out.println("DAO 실행");
		return sqlSessionTemplate.selectOne("UserNoticeDAO.getUserNotice", vo);
	}

	public List<UserNoticeVO> getUserPageList(UserPagination pagination) {
		return sqlSessionTemplate.selectList("UserNoticeDAO.getUserPageList", pagination);
	}

	public List<UserNoticeVO> getRightNoticeList(UserPagination pagination) {
		return sqlSessionTemplate.selectList("UserNoticeDAO.getRightNoticeList", pagination);
	}

}
