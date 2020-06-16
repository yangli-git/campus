package cn.edu.whpu.service;

import cn.edu.whpu.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface UserService {
	
	/**
	 * 用户注册
	 */
	int registerUser(User record);
	
	/**
	 * 账号个数
	 */
	int getAccountCount(String account);
	
	/**
	 * 登录
	 */
	User login(String account);
	
	/**
	 * 更新用户信息
	 */
	int updateUserInfo(User user);
	
	/**
     * 根据账号或昵称查找返回user
     */
    List<User> getByLikeNameAccount(@Param("words") String words);
    
    /**
     * 根据uid查找返回user
     */
    User getByUid(Integer uId);
	
}
