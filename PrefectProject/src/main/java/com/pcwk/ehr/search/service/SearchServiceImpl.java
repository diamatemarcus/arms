package com.pcwk.ehr.search.service;

import java.sql.SQLException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.search.dao.SearchDao;
import com.pcwk.ehr.user.domain.UserVO;

@Service
public class SearchServiceImpl implements PcwkLogger, SearchService {
	
	final String NAMESPACE = "com.pcwk.ehr.search";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sql;
	
	@Autowired
	SearchDao searchEmailDao;

	@Override
	public int searchEmailCheck(UserVO inVO) throws SQLException {
		//10:ID 없음
		//20:비번이상
		//30:로그인
		int checkStatus = 0;
		
		//이름 Check
		int status = searchEmailDao.nameCheck(inVO);
		
		if(status==0) {
			checkStatus = 10;
			LOG.debug("10 nameCheck checkStatus:"+checkStatus);
			return checkStatus;
		}
		
		//아름,전화번호 Check
		status = searchEmailDao.nameTelCheck(inVO);
		if(status==0) {
			checkStatus = 20;
			LOG.debug("20 nameTelCheck checkStatus:"+checkStatus);
			return checkStatus;
		}
		
		checkStatus = 30;//id/비번 정상 로그인 
		LOG.debug("30 idPassCheck pass checkStatus:"+checkStatus);
		return checkStatus;
	}

	@Override
	public UserVO findEmail(UserVO inVO) throws SQLException, EmptyResultDataAccessException {
		
		UserVO  outVO = null;
		
		LOG.debug("입력값 :" + inVO.toString());
		String statement = NAMESPACE+DOT+"searchEmail";//실행쿼리문
		LOG.debug("쿼리문 :" + statement);
		outVO = sql.selectOne(statement, inVO);//입력값으로 쿼리문 실행 후 값 outVO에 저장
		if(null != outVO) { //outVO가 null 이 아니라면
			LOG.debug("결과 \n" + outVO.toString());
		}
		return outVO; //outVO값 반환
	}

	@Override
	public int emailCheckForPassword(UserVO inVO) throws SQLException {
		//10:ID 없음
		//20:비번이상
		//30:로그인
		int checkStatus = 0;
		
		//이름 Check
		int status = searchEmailDao.nameCheck(inVO);
		
		if(status==0) {
			checkStatus = 10;
			LOG.debug("10 nameCheck checkStatus:"+checkStatus);
			return checkStatus;
		}
		
		//아름,전화번호 Check
		status = searchEmailDao.emailCheck(inVO);
		if(status==0) {
			checkStatus = 20;
			LOG.debug("20 emailCheck checkStatus:"+checkStatus);
			return checkStatus;
		}
		
		checkStatus = 30;//id/비번 정상 로그인 
		LOG.debug("30 idPassCheck pass checkStatus:"+checkStatus);
		return checkStatus;
	}
	
}
