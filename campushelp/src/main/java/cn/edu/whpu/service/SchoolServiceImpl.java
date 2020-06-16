package cn.edu.whpu.service;

import cn.edu.whpu.dao.SchoolMapper;
import cn.edu.whpu.pojo.School;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("schoolService")
public class SchoolServiceImpl implements SchoolService {
	
	@Resource(name="schoolMapper")
	private SchoolMapper schoolMapper;

	@Override
	public List<School> getAllSchools() {
		
		return schoolMapper.selectAllSchools();
	}

	@Override
	public School getSchoolByID(Integer schoolId) {
		return schoolMapper.selectByPrimaryKey(schoolId);
	}

	@Override
	public int updateSchool(School school) {
		return schoolMapper.updateByPrimaryKeySelective(school);
	}

	@Override
	public List<School> getAllSchoolsNoState() {
		return schoolMapper.selectAllSchoolsNoState();
	}

	@Override
	public int setSchool(School school) {
		
		return schoolMapper.insert(school);
	}
	
	
}
