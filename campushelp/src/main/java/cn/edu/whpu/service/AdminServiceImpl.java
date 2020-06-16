package cn.edu.whpu.service;

import cn.edu.whpu.dao.AdminMapper;
import cn.edu.whpu.pojo.Admin;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Resource(name = "adminMapper")
    private AdminMapper adminMapper;

    @Override
    public int getAccountCount(String account) {
        return adminMapper.selectAccountCount(account);
    }

    @Override
    public Admin getAdminByAccount(String account) {
        return adminMapper.selectAdminByAccount(account);
    }

    @Override
    public int updateAdminInfo(Admin admin) {
        int result = 0;
        try {
            result = adminMapper.updateByPrimaryKeySelective(admin);
        } catch (Exception e) {

        }
        return result;
    }

    @Override
    public Admin login(String account) {
        Admin admin = null;
        admin = adminMapper.selectAdminByAccount(account);
        return admin;
    }

    @Override
    public int setAdmin(Admin admin) {
        int result = 0;
        try {
            result = adminMapper.insert(admin);
        } catch (Exception e) {
        }
        return result;
    }

    @Override
    public int deleteAdmin(int aId) {
        return  adminMapper.deleteByPrimaryKey(aId);
    }


    public void setAdminMapper(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }
}
