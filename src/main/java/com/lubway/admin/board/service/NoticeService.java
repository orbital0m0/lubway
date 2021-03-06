package com.lubway.admin.board.service;

import java.util.List;

import com.lubway.admin.board.NoticeVO;
import com.lubway.admin.board.Pagination;

public interface NoticeService {

	// 관리자 CRUD 기능의 메소드 구현
	// 글 등록
	void insertNotice(NoticeVO vo);

	// 글 수정
	void updateNotice(NoticeVO vo);

	// 글 삭제
	void deleteNotice(NoticeVO vo);

	// 글 상세 조회
	NoticeVO getNotice(NoticeVO vo);

	// 글 목록 조회
	List<NoticeVO> getNoticeList(NoticeVO vo);
	
	//페이징 리스트
	List<NoticeVO> getPageList(Pagination pagination);
	
	//페이징처리 개수
	int getPageListCnt();

	//검색한 글 목록 개수
	int getSearchTitleCnt(String title);
	
	//검색한 글 페이징 리스트
	List<NoticeVO> getSearchPagingList(Pagination pagination);

}