package com.lubway.store;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StoreDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
}