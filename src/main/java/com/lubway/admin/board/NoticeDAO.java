package com.lubway.admin.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	/** 관리자 공지사항 insert */
	public void insertNotice(NoticeVO vo) {
		System.out.println("insertNotice() 기능 처리");
		sqlSessionTemplate.insert("NoticeDAO.insertNotice", vo);
	}

	/** 관리자 공지사항 update */
	public void updateNotice(NoticeVO vo) {
		System.out.println("updateNotice() 기능 처리");
		sqlSessionTemplate.update("NoticeDAO.updateNotice", vo);
	}

	/** 관리자 공지사항 delete */
	public void deleteNotice(NoticeVO vo) {
		System.out.println("deleteNotice() 기능 처리");
		sqlSessionTemplate.delete("NoticeDAO.deleteNotice", vo);
	}

	/** 관리자 공지사항 상세페이지 */
	public NoticeVO getNotice(NoticeVO vo) {
		System.out.println("getNotice() 기능 처리");
		NoticeVO notice = sqlSessionTemplate.selectOne("NoticeDAO.getNotice", vo);
		System.out.println(notice.toString());
		return notice;
	}
	
	/** 관리자 공지사항 목록 페이지 */
	public List<NoticeVO> getNoticeList(NoticeVO vo) {
		System.out.println("getNoticeList() 기능 처리");
		return sqlSessionTemplate.selectList("NoticeDAO.getNoticeList", vo);
	}
	
	/** 관리자 공지사항 페이징처리 */
	public List<NoticeVO> getPageList(Pagination pagination){
		return sqlSessionTemplate.selectList("NoticeDAO.pagingList", pagination);
	}
	
	public int getPageListCnt() {
		return sqlSessionTemplate.selectOne("NoticeDAO.pagingCnt");
	}
	
	public int getSearchTitleCnt(String title) {
		return sqlSessionTemplate.selectOne("NoticeDAO.searchTitleCnt", title);
	}

	public List<NoticeVO> getSearchPagingList(Pagination pagination){
		return sqlSessionTemplate.selectList("NoticeDAO.searchPagingList", pagination);
	}


}
