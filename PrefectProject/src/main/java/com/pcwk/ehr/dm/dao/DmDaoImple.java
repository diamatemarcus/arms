package com.pcwk.ehr.dm.dao;

import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;

import com.pcwk.ehr.cmn.PcwkLogger;
import com.pcwk.ehr.dm.domain.DmVO;
@Repository
public class DmDaoImple implements DmDao,PcwkLogger {
	
	final String NAMESPACE = "com.pcwk.ehr.dm";
	final String DOT       = ".";
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int doSend(DmVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doSend                            │");
		LOG.debug("│ DmVO                              │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doSend");
		//com.pcwk.ehr.board.doSave
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.insert(NAMESPACE+DOT+"doSend", inVO);
	}

	@Override
	public int updateReadChk(DmVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ updateReadChk                          │");
		LOG.debug("│ DmVO                              │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"updateReadChk");
		LOG.debug("└───────────────────────────────────┘");		
		return sqlSessionTemplate.update(NAMESPACE+DOT+"updateReadChk", inVO);
	}

	@Override
	public int doDelete(DmVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ doDelete                          │");
		LOG.debug("│ BoardVO                           │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"doDelete");
		LOG.debug("└───────────────────────────────────┘");		
		
		return sqlSessionTemplate.delete(NAMESPACE+DOT+"doDelete", inVO);
	}

	@Override
	public DmVO recentMessage(DmVO inVO) throws SQLException, EmptyResultDataAccessException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ recentMessage                     │");
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"recentMessage");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"recentMessage");
	}

	@Override
	public List<DmVO> contentsList(DmVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ contentsList                      │");
		LOG.debug("│ DmVO                              │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"contentsList");
		LOG.debug("└───────────────────────────────────┘");			
		List flag = sqlSessionTemplate.selectList(NAMESPACE+DOT+"contentsList", inVO);
		LOG.debug("│ flag                           │"+flag);
		return flag;
		
	}

	@Override
	public int getDmSeq() throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ getBoardSeq                       │");
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"getDmSeq");
		LOG.debug("└───────────────────────────────────┘");	
		return sqlSessionTemplate.selectOne(NAMESPACE+DOT+"getDmSeq");
	}

	@Override
	public List<DmVO> receiverList(DmVO inVO) throws SQLException {
		LOG.debug("┌───────────────────────────────────┐");
		LOG.debug("│ receiverList                      │");
		LOG.debug("│ DmVO                              │"+inVO);
		LOG.debug("│ statement                         │"+NAMESPACE+DOT+"receiverList");
		LOG.debug("└───────────────────────────────────┘");			
		return sqlSessionTemplate.selectList(NAMESPACE+DOT+"receiverList", inVO);
	}

}
