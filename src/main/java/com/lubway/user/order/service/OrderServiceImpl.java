package com.lubway.user.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lubway.admin.board.EventVO;
import com.lubway.admin.board.Pagination;
import com.lubway.store.StoreInfoDAO;
import com.lubway.store.StoreInfoVO;
import com.lubway.user.menu.ToppingAddVO;
import com.lubway.user.menu.UserOptionDAO;
import com.lubway.user.order.OrderCodeVO;
import com.lubway.user.order.OrderDAO;
import com.lubway.user.order.OrderListVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	StoreInfoDAO dao;
	
	@Autowired
	UserOptionDAO userOptionDao;
	
	@Autowired
	OrderDAO orderDao;
	
	@Override
	public StoreInfoVO getStoreInfoByNo(String franchiseNo) {
		int no = Integer.parseInt(franchiseNo);
		return dao.getStoreInfoByNo(no);
	}

	@Override
	public ToppingAddVO getToppingByName(String t) {
		return userOptionDao.getToppingByName(t);
	}
	
	//MyWay 주문 내역 페이지//
	
	@Override
	public List<OrderCodeVO> orderCodeList(OrderCodeVO vo) {
		return orderDao.orderCodeList(vo);
	}
	
	@Override
	public List<OrderListVO> orderList(OrderListVO vo) {
		return orderDao.orderList(vo);
	}
	
	@Override
	public List<OrderCodeVO> selectHomeway(OrderCodeVO vo) {
		return orderDao.selectHomeway(vo);
	}

	@Override
	public List<OrderCodeVO> selectFastway(OrderCodeVO vo) {
		return orderDao.selectFastway(vo);
	}

	@Override
	public int countOrderList(OrderCodeVO vo) {
		return orderDao.countOrderList(vo);
	}

	@Override
	public void insertOrderCode(OrderCodeVO vo) {
		orderDao.insertOrderCode(vo);
	}
	
	@Override
	public void insertOrderList(OrderListVO vo) {
		orderDao.insertOrderList(vo);
	}

	//사용자 주문내역 상세
	@Override
	public OrderCodeVO getOrderListDetail(OrderCodeVO vo) {
		return orderDao.getOrderListDetail(vo);
	}
	
	@Override
	public List<OrderCodeVO> getOrderList(OrderCodeVO vo) {
		return orderDao.getOrderList(vo);
	}
	
	public List<OrderCodeVO> getOrderPageList(Pagination pagination){
		return orderDao.getOrderPageList(pagination);
	}
	
	@Override
	public int getOrderPageListCnt() {
		return orderDao.getOrderPageListCnt();

	}
}
