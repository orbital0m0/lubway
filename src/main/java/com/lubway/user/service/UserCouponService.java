package com.lubway.user.service;

import java.util.List;

import com.lubway.user.UserCouponVO;

public interface UserCouponService {

	List<UserCouponVO> getUserCouponList(UserCouponVO vo);
	
	int getCouponTotal();
	
	int getUseCouponTotal();
	
	int countUseCoupon(UserCouponVO vo);

	void insertUseCoupon(String couponCode, String id);
}