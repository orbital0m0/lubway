package com.lubway.admin.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lubway.admin.board.NoticeDAO;
import com.lubway.admin.board.NoticeVO;
import com.lubway.admin.board.Pagination;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAO noticeDAO;
	
	@Override
	public void insertNotice(NoticeVO vo) {
		noticeDAO.insertNotice(vo);
	}

	@Override
	public void updateNotice(NoticeVO vo) {
		noticeDAO.updateNotice(vo);
	}

	@Override
	public void deleteNotice(NoticeVO vo) {
		noticeDAO.deleteNotice(vo);
	}

	@Override
	public NoticeVO getNotice(NoticeVO vo) {
		return noticeDAO.getNotice(vo);
	}

	@Override
	public List<NoticeVO> getNoticeList(NoticeVO vo) {
		return noticeDAO.getNoticeList(vo);
		
	}
	
	public List<NoticeVO> getPageList(Pagination pagination){
		return noticeDAO.getPageList(pagination);
	}
	
	@Override
	public int getPageListCnt() {
		return noticeDAO.getPageListCnt();

	}

	@Override
	public int getSearchTitleCnt(String title) {
		return noticeDAO.getSearchTitleCnt(title);
	}

	@Override
	public List<NoticeVO> getSearchPagingList(Pagination pagination) {
		return noticeDAO.getSearchPagingList(pagination);
		
	}
	
	// 사용자 공지사항
	@Override
	public NoticeVO getUserNotice(NoticeVO vo) {
		return noticeDAO.getUserNotice(vo);
	}

	@Override
	public List<NoticeVO> getUserNoticeList(NoticeVO vo) {
		return noticeDAO.getNoticeList(vo);
	}

}