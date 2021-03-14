package cn.edu.whpu.controller;

import cn.edu.whpu.pojo.Admin;
import cn.edu.whpu.pojo.School;
import cn.edu.whpu.pojo.Task;
import cn.edu.whpu.pojo.User;
import cn.edu.whpu.service.AdminService;
import cn.edu.whpu.service.SchoolService;
import cn.edu.whpu.service.TaskService;
import cn.edu.whpu.service.UserService;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


/**
 * ****管理员功能**** 
 * ------- 
 * 管理员登录 . 
 * 管理员个人信息更新 . 
 * 密码更新 . 
 * 添加管理员 . 
 * ------ 
 * 获取任务列表 .
 * 关闭待解决任务. 
 * ------ 
 * 获取用户列表 . 
 * 读取一个用户. 
 * 添加用户余额. 
 * 解除用户限制 . 
 * 添加用户限制 . 
 * ---------- 
 * 获取学校列表.
 * 读取单个学校信息 . 
 * 更新学校信息 . 
 * 添加院校.
 * 
 * @author
 *
 */
@Controller
@SessionAttributes({ "nowAdmin" })
@RequestMapping(value = "admin/")
public class AdminController {

	@Resource(name = "adminService")
	public AdminService adminService;

	@Resource(name = "schoolService")
	public SchoolService schoolService;


	@Resource(name = "taskService")
	public TaskService taskService;

	@Resource(name = "userService")
	public UserService userService;

	// 登录
	@RequestMapping("adminLogin.do")
	public String adminLogin(String account, String password, Model model) {

		Admin admin = null;

		admin = adminService.login(account);

		if (admin == null) {
			model.addAttribute("msg", "登录账号不存在");
			return "login";
		}

		if (password.equals(admin.getPassword())) {
			model.addAttribute("nowAdmin", admin);
			return "adminIndex";
		} else {
			model.addAttribute("msg", "密码错误,请重现输入");
			return "login";
		}

	}

	// 更新
	@RequestMapping("update.do")
	public String update(HttpServletRequest request, Admin admin, Model model) {
		Admin oldAdmin = (Admin) request.getSession(false).getAttribute("nowAdmin");
		admin.setAId(oldAdmin.getAId());
		admin.setPassword(oldAdmin.getPassword());
		admin.setAddTime(oldAdmin.getAddTime());
		admin.setState(oldAdmin.getState());
		System.err.println(admin);
		int r = adminService.updateAdminInfo(admin);
		if (r > 0) {
			model.addAttribute("nowAdmin", admin);
			model.addAttribute("msg", "更新成功");
			return "adminIndex";
		}
		model.addAttribute("msg", "更新失败");
		return "adminUpdate";
	}

	// 更新
	@RequestMapping("updatePwd.do")
	public String updatePwd(HttpServletRequest request, String oldPassword, Admin admin, Model model) {
		Admin oldAdmin = (Admin) request.getSession(false).getAttribute("nowAdmin");
		if (!oldAdmin.getPassword().equals(oldPassword)) {
			model.addAttribute("msg", "原密码错误");
			return "adminPassword";
		}
		int r = adminService.updateAdminInfo(admin);
		if (r > 0) {
			model.addAttribute("msg", "修改成功，请重新登录");
			request.getSession(false).removeAttribute("nowAdmin");
			return "login";
		}
		model.addAttribute("msg", "修改失败");
		return "adminPassword";
	}

	@RequestMapping("getAdmin.do")
	public String getAdmin(String aidstr, Model model) {
		int aid = 0;
		try {
			aid = Integer.parseInt(aidstr);
			if (aid == 0) {
				model.addAttribute("msg", "出现错误");
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
		}finally {
			return "adminIndex";
		}
	}

	@RequestMapping("addAdmin.do")
	public String addAdmin(String account, Model model) {

		// 检查账号重复
		int countNum = adminService.getAccountCount(account);
		if (countNum > 0) {
			model.addAttribute("msg", account + "   该账号已经被使用");
			return "adminAddAdmin";
		}
		Admin admin = new Admin(0, account, "123456", account, new Date(), 0);

		int result = adminService.setAdmin(admin);

		if (result <= 0) {
			model.addAttribute("msg", "注册失败");
			return "adminAddAdmin";
		}

		model.addAttribute("msg", "注册成功，可以登录。默认密码：123456");

		return "adminAddAdmin";
	}

	@RequestMapping("getTasks.do")
	public String getTasks(String words, @RequestParam(required = true, defaultValue = "-1") String schoolIdStr,
			Model model) {
		model.addAttribute("words", words);
		model.addAttribute("schoolIdStr", schoolIdStr);
		int schoolId = -1;
		if (!schoolIdStr.equals("-1")) {
			try {
				schoolId = Integer.parseInt(schoolIdStr);
			} catch (Exception e) {
				System.err.println("err");
			}
		}
		if (words != null) {
			words = "%" + words + "%";
		} else {
			words = "%%";
		}
		List<Task> list = taskService.getTaskByKeys(words, schoolId);
		model.addAttribute("list", list);
		return "adminTask";
	}

	// to1.管理员点击关闭删除取消
	@RequestMapping("taskClose.do")
	public String taskClose(String tidstr, String words,
			@RequestParam(required = true, defaultValue = "-1") String schoolIdStr, HttpServletRequest request,
			Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getTasks(words, schoolIdStr, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			return getTasks(words, schoolIdStr, model);
		}
		Admin admin = null;
		try {
			admin = (Admin) request.getSession(false).getAttribute("nowAdmin");
			int uid = 0;
			uid = admin.getAId();
			if (admin == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return getTasks(words, schoolIdStr, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}

		Task theTask = taskService.getTask(tid);

		theTask.setState(1);
		int r = taskService.updateTask(theTask);
		if (r > 0) {
			model.addAttribute("msg", "成功");
		} else {
			model.addAttribute("msg", "失败");
		}

		return getTasks(words, schoolIdStr, model);
	}

	// 获取用户信息
	@RequestMapping("getUsers.do")
	public String getUsers(String userstr, Model model) {
		model.addAttribute("keys", userstr);
		if (userstr != null) {
			userstr = "%" + userstr + "%";
		} else {
			userstr = "%%";
		}
		List<User> list = userService.getByLikeNameAccount(userstr);
		model.addAttribute("list", list);
		return "adminUser";
	}

	// 读取一个用户,添加余额时使用
	@RequestMapping("getUser.do")
	public String getUser(String stuIdStr, Model model) {
		int stuId = 0;
		try {
			stuId = Integer.parseInt(stuIdStr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		if (stuId == 0) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		User user = userService.getByUid(stuId);
		model.addAttribute("theUser", user);
		return "adminUserMoney";
	}

	// 添加用户余额
	@RequestMapping("addUserMoney.do")
	public String addUserMoney(String moneyStr, String stuIdStr, Model model) {
		double money = 0.00;
		try {
			money = Double.parseDouble(moneyStr);
		} catch (Exception e) {
			model.addAttribute("msg", "金额出现错误");
			return getUser(stuIdStr, model);
		}

		if (stuIdStr == null) {
			model.addAttribute("msg", "出现错误");
			return getUser(null, model);
		} else {
			if (stuIdStr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return getUser(stuIdStr, model);
			}
		}
		int stuId = 0;
		try {
			stuId = Integer.parseInt(stuIdStr);
			if (stuId == 0) {
				model.addAttribute("msg", "出现错误");
				return getUser(stuIdStr, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getUser(stuIdStr, model);
		}

		User theUser = userService.getByUid(stuId);
		theUser.setMoney(theUser.getMoney() + money);

		int r = userService.updateUserInfo(theUser);
		if (r > 0) {
			model.addAttribute("msg", "修改成功");
		} else {
			model.addAttribute("msg", "修改失败");
		}
		return getUser(stuIdStr, model);
	}

	// 解除用户限制
	@RequestMapping("userOpen.do")
	public String userOpen(String keys, String stuIdStr, Model model) {
		if (stuIdStr == null) {
			model.addAttribute("msg", "出现错误");
			return getUsers(keys, model);
		} else {
			if (stuIdStr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return getUsers(keys, model);
			}
		}
		int stuId = 0;
		try {
			stuId = Integer.parseInt(stuIdStr);
			if (stuId == 0) {
				model.addAttribute("msg", "出现错误");
				return getUsers(keys, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getUsers(keys, model);
		}

		User theUser = userService.getByUid(stuId);
		theUser.setState(0);

		int r = userService.updateUserInfo(theUser);
		if (r > 0) {
			model.addAttribute("msg", "修改成功");
		} else {
			model.addAttribute("msg", "修改失败");
		}
		return getUsers(keys, model);
	}

	// 限制用户
	@RequestMapping("userClose.do")
	public String userClose(String keys, String stuIdStr, Model model) {
		if (stuIdStr == null) {
			model.addAttribute("msg", "出现错误");
			return getUsers(keys, model);
		} else {
			if (stuIdStr.length() == 0) {
				model.addAttribute("msg", "出现错误");
				return getUsers(keys, model);
			}
		}
		int stuId = 0;
		try {
			stuId = Integer.parseInt(stuIdStr);
			if (stuId == 0) {
				model.addAttribute("msg", "出现错误");
				return getUsers(keys, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getUsers(keys, model);
		}

		User theUser = userService.getByUid(stuId);
		theUser.setState(1);

		int r = userService.updateUserInfo(theUser);
		if (r > 0) {
			model.addAttribute("msg", "修改成功");
		} else {
			model.addAttribute("msg", "修改失败");
		}
		return getUsers(keys, model);
	}

	// 读取全部院校
	@RequestMapping("getSchools.do")
	public String getSchools(Model model) {

		List<School> list = schoolService.getAllSchools();

		model.addAttribute("list", list);

		return "adminSchool";
	}

	// 读取一个院校信息
	@RequestMapping("getSchool.do")
	public String getSchool(String schoolIdStr, Model model) {
		System.err.println(schoolIdStr);
		if (schoolIdStr == null) {
			model.addAttribute("msg", "出现错误");
			return "adminSchoolSetting";
		}
//		else {
//			if (schoolIdStr.length() == 0) {
//				model.addAttribute("msg", "出现错误");
//				return "adminSchoolSetting";
//			}
//		}
		int schoolId = 0;
		try {
			schoolId = Integer.parseInt(schoolIdStr);
			if (schoolId == -1) {
				model.addAttribute("msg", "出现错误");
				return "adminSchoolSetting";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getSchools(model);
		}

		School theSchool = schoolService.getSchoolByID(schoolId);

		if (theSchool != null) {
			model.addAttribute("theSchool", theSchool);
		} else {
			model.addAttribute("msg", "读取失败");
		}
		return "adminSchoolSetting";
	}

	// 更新院校
	@RequestMapping("updateSchool.do")
	public String updateSchool(School school, Model model) {

		int r = 0;

		r = schoolService.updateSchool(school);

		if (r > 0) {
			model.addAttribute("msg", "修改成功-刷新页面重新加载显示");
		} else {
			model.addAttribute("msg", "修改失败");
		}

		School theSchool = schoolService.getSchoolByID(school.getSchoolId());

		model.addAttribute("theSchool", theSchool);

		return "adminSchoolSetting";
	}

	// 新添院校
	@RequestMapping("addSchool.do")
	public String addSchool(String name, Model model) {

		if (name == null) {
			model.addAttribute("msg", "添加失败");
			return "adminSchoolAdd";
		} else {
			if (name.length() == 0) {
				model.addAttribute("msg", "添加失败");
				return "adminSchoolAdd";
			}
		}

		School theSchool = new School(0, name, new Date(), 0);

		int r = 0;

		r = schoolService.setSchool(theSchool);

		if (r > 0) {
			model.addAttribute("msg", "添加成功");
			model.addAttribute("flag", "添加成功");
			return "adminSchoolAdd";
		} else {
			model.addAttribute("msg", "添加失败");
			return "adminSchoolAdd";
		}
	}

	// 注销账户
	@RequestMapping("adminCancel.do")
	public String adminCancel(Integer AId, Model model) {
		adminService.deleteAdmin(AId);
		model.addAttribute("msg","注销成功");
		return "login";
	}

	@org.springframework.web.bind.annotation.InitBinder
	public void InitBinder(ServletRequestDataBinder bin) {
		bin.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
	}

}
