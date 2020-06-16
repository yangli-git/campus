package cn.edu.whpu.service;

import cn.edu.whpu.pojo.Admin;
import org.apache.ibatis.annotations.Param;


public interface AdminService {
	
	/**
     * 查找账号个数
     * @param account
     * @return
     */
    int getAccountCount(@Param("account") String account);
    
    /**
     * 根据账号查找返回admin
     * @param account
     * @return
     */
    Admin getAdminByAccount(@Param("account") String account);
    
    /**
	 * 更新信息
	 * @param admin
	 * @return
	 */
	int updateAdminInfo(Admin admin);
	
	/**
	 * 登录
	 * @param account
	 * @return
	 */
	Admin login(String account);
	
	/**
	 * 添加管理员
	 * @return
	 */
     int setAdmin(Admin admin);

     int deleteAdmin(int aId);

}
