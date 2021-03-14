package cn.edu.whpu.controller;

import cn.edu.whpu.pojo.User;
import cn.edu.whpu.pojo.Task;
import cn.edu.whpu.service.TaskService;
import cn.edu.whpu.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * ***********用户基本************** 
 * 用户登录 *
 * 用户注册*
 * 
 * 用户信息更新* 
 * 用户密码更新*
 *
 */
@Controller
@SessionAttributes({ "nowUser" })
@RequestMapping(value = "user/")
public class UserController {

	@Resource(name = "userService")
	public UserService userService;

	@Resource(name = "taskService")
	public TaskService taskService;

	// 登录
	@RequestMapping("login.do")
	public String login(String studentId, String password, Model model,
						@RequestParam(required=true,defaultValue="1") Integer page) {

		User user = null;

		user = userService.login(studentId);

		if (user == null) {
			model.addAttribute("msg", "登录失败--账号不存在");
			return "login";
		}

		if (password.equals(user.getPassword())) {

			//这段代码表示，程序开始分页了，page默认值是1，每页记录数（pageSize）默认是3，意思是从第1页开始，每页显示3条记录
			//每页记录数可以自定义
			PageHelper.startPage(page, 3);
			List<Task> list = taskService.getAllTask();
			PageInfo<Task> pageInfo = new PageInfo<Task>(list); //将集合封装到PageInfo
			//绑定数据，返回给页面
			model.addAttribute("p", pageInfo);
			model.addAttribute("nowUser", user);
//			model.addAttribute("loginFlag", "loginFlag");

			return "index";
		} else {
			model.addAttribute("msg", "登录失败--密码错误");
			return "login";
		}

	}

	// 注册
	@RequestMapping("register.do")
	public String register(User user, Model model) {
		// 检查学号账号重复
		int countNum = userService.getAccountCount(user.getStudentId());
		if (countNum > 0) {
			model.addAttribute("msg", "该学号已经注册");
			model.addAttribute("user", user);
			return "register";
		}
		user.setStuId(0);
		user.setRegisterTime(new Date());
		user.setMoney(0.00);
		user.setState(0);
		System.err.println(user);
		int result = userService.registerUser(user);

		if (result <= 0) {
			model.addAttribute("msg", "注册失败");
			model.addAttribute("user", user);
			return "register";
		}

		model.addAttribute("msg", "注册成功，请登录一下");

		return "login";
	}

	// 更新
	@RequestMapping("update.do")
	public String update(User user, Model model) {
		int r = userService.updateUserInfo(user);
		if (r > 0) {
			model.addAttribute("msg", "更新成功，请重新登录");
			model.addAttribute("flag", "更新成功，请重新登录");
			return "userUpdate";
		}
		model.addAttribute("msg", "更新失败");
		return "userUpdate";
	}

	// 更新
	@RequestMapping("updatePwd.do")
	public String updatePwd(HttpServletRequest request, String oldPassword, User user, Model model) {

		User oldUser = (User) request.getSession(false).getAttribute("nowUser");

		System.out.println(oldUser.getPassword());
		System.out.println(oldPassword);
		if (!oldUser.getPassword().equals(oldPassword)) {
			model.addAttribute("msg", "原密码错误");
			return "userPassword";
		}

		int r = userService.updateUserInfo(user);
		if (r > 0) {
			model.addAttribute("msg", "修改成功，请重新登录");
			model.addAttribute("flag", "更新成功，请重新登录");
			return "userPassword";
		}
		model.addAttribute("msg", "修改失败");
		return "userPassword";
	}

}
