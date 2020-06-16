package cn.edu.whpu.service;

import cn.edu.whpu.pojo.School;

import java.util.List;

public interface SchoolService {
	
	/**
	 * 读取全部
	 */
	List<School> getAllSchools();
	
	/**
	 * 读取全部,不含限制的,state=0
	 */
	List<School> getAllSchoolsNoState();
	
	/**
	 * 读取1个
	 */
	School getSchoolByID(Integer schoolId);
	
	/**
	 * 更新
	 */
	int updateSchool(School school);
	
	/**
	 * 添加
	 */
	int setSchool(School school);
	
}
