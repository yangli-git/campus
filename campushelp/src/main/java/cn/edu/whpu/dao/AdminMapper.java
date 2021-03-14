package cn.edu.whpu.dao;

import cn.edu.whpu.pojo.Admin;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.HashMap;

public interface AdminMapper {
    int deleteByPrimaryKey(Integer aId);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer aid);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
    
    /**
     * 查找账号个数
     * @param account
     * @return
     */
    public int selectAccountCount(@Param("account") String account);
    
    /**
     * 根据账号查找返回admin
     * @param account
     * @return
     */
    public Admin selectAdminByAccount(@Param("account") String account);
}