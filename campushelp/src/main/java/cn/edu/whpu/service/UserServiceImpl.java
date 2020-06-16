package cn.edu.whpu.service;

import cn.edu.whpu.dao.UserMapper;
import cn.edu.whpu.pojo.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Service  默认bean名称userServiceImpl
 * @author Administrator
 */
@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource(name="userMapper")
	private UserMapper userMapper;
	
	@Override
	public int registerUser(User record) {
		int result = 0;
		try {
			result = userMapper.insert(record);
		} catch (Exception e) {
		}
		return result;
	}

	@Override
	public int getAccountCount(String account) {
		int result = 0;
		result = userMapper.selectAccountCount(account);
		return result;
	}

	@Override
	public User login(String account) {
		User user = null;
		user = userMapper.selectUserByAccount(account);
		return user;
	}

	@Override
	public int updateUserInfo(User user) {
		int result = 0;
		try {
			result = userMapper.updateByPrimaryKeySelective(user);
		} catch (Exception e) {
			
		}
		return result;
	}

	@Override
	public List<User> getByLikeNameAccount(String words) {
		List<User> list = null;
		list = userMapper.selectByLikeNameAccount(words);
		return list;
	}

	@Override
	public User getByUid(Integer uId) {
		User user = null;
		user = userMapper.selectByPrimaryKey(uId);
		return user;
	}
	
}
