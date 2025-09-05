package com.smhrd.web.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.smhrd.web.domain.Cloudtest;

@Repository
public interface CloudtestRepository extends JpaRepository<Cloudtest, Long> {
	
	// JpaRepository<테이블을 대표하는 자료형, 테이블의 pk 자료형>
	// interface이지만, 일종의 자료형태를 정하는 개념으로 봐서 extends로 상속받음
	// !!!특이케이스!!!
	
	// 메소드명을 기준으로 sql 구문을 생성
	// Java는 기본적으로 이름을 지어줄 때, 카멜 케이스를 따름
	Cloudtest findByIdAndName(Long Id, String name);
	// select * from cloudtest where id = ? and name = ?
	
}
