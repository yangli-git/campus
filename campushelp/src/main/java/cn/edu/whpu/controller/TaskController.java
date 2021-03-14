package cn.edu.whpu.controller;

import cn.edu.whpu.pojo.Task;
import cn.edu.whpu.pojo.User;
import cn.edu.whpu.service.TaskService;
import cn.edu.whpu.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * *****任务********
 * 用户发布新任务*
 * 用户读取自己发布的任务*
 * 用户读取自己接受的任务*
 * 用户确认任务完成*
 * 用户关闭未被人接受的任务*
 * 用户接受任务*
 * 读取任务的信息*
 * 搜索任务*
 * 
 * @author 
 *
 */

@Controller
@RequestMapping(value = "task/")
public class TaskController {

	@Resource(name = "taskService")
	public TaskService taskService;

	@Resource(name = "userService")
	public UserService userService;
	
	//发布新任务
	@RequestMapping("newTask.do")
	public String newTask(Task task, HttpServletRequest request, Model model) {
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowUser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}
		try {
			if (user == null || user.getStuId() == 0) {
				model.addAttribute("msg", "发布失败-请检查登录状况");
				return "userNewTask";
			}
		} catch (Exception e) {
			model.addAttribute("msg", "发布失败-请检查登录状况");
			return "userNewTask";
		}
		if (user.getState() > 0) {
			model.addAttribute("msg", "发布失败-用户状态受限");
			return "userNewTask";
		}

		if (user.getMoney()<task.getReward()) {
			model.addAttribute("msg", "发布失败-余额不足-请联系管理员添加余额");
			return "userNewTask";
		}

		Task task2 = new Task(0, user.getStuId() + "", user.getName(), user.getSchoolId(), 0, task.getReward(),
				new Date(), new Date(), task.getTaskName(), task.getTaskContext(), 0);

		user.setMoney(user.getMoney()-task2.getReward());
		int rUser = userService.updateUserInfo(user);
		if (rUser> 0) {
			int r = taskService.setNewTask(task2);
			if (r > 0) {
				System.out.println("success");
				model.addAttribute("msg", "发布成功");
				return getUserTask(request, model);
			}else {
				model.addAttribute("msg", "余额已扣除-发布失败");
				return "userNewTask";
			}
		}else {
			model.addAttribute("msg", "发布失败");
			return "userNewTask";
		}

	}

	// 用户发布的
	@RequestMapping("getUserTask.do")
	public String getUserTask(HttpServletRequest request, Model model) {
		try {
			User user = (User) request.getSession(false).getAttribute("nowUser");
			System.out.println(user);
			int uid = user.getStuId();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return findTask("", "-1", 1, model);
			}

			List<Task> list = taskService.getUserTask(uid);
			model.addAttribute("list", list);
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return findTask("", "-1", 1, model);
		}
		return "userPTask";
	}

	// 用户接受的
	@RequestMapping("getUserATask.do")
	public String getUserATask(HttpServletRequest request, Model model) {
		try {
			User user = (User) request.getSession(false).getAttribute("nowUser");
			int uid = user.getStuId();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return findTask("", "-1", 1, model);
			}
			List<Task> list = taskService.getUserATask(uid);
			model.addAttribute("list", list);
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return findTask("", "-1", 1, model);
		}
		return "userATask";
	}

	// to3.发布者点击确认
	@RequestMapping("taskOk.do")
	public String taskOk(String tidstr, HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			System.out.println("11111111111");
			return getUserTask(request, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			System.out.println("22222222222222");
			return getUserTask(request, model);
		}
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowUser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}
		int uid = 0;
		try {
			uid = user.getStuId();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return getUserTask(request, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return getUserTask(request, model);
		}
		Task theTask = taskService.getTask(tid);
		if (!(uid + "").equals(theTask.getPublishUserId())) {
			model.addAttribute("msg", "出现错误");
			return getUserTask(request, model);
		}
		theTask.setState(3);
		User aUser = userService.getByUid(theTask.getAcceptUserId());
		aUser.setMoney(aUser.getMoney()+theTask.getReward());
		
		int rUser = userService.updateUserInfo(aUser);
		if (rUser>0) {
			int r = taskService.updateTask(theTask);
			if (r > 0) {
				model.addAttribute("msg", "成功");
			} else {
				model.addAttribute("msg", "失败");
			}
		} else {
			model.addAttribute("msg", "失败，奖励无法到账-请联系管理员");
		}
		
		List<Task> list = taskService.getUserTask(uid);
		model.addAttribute("list", list);
		return "userPTask";
	}

	// to1.发布者点击关闭删除取消
	@RequestMapping("taskClose.do")
	public String taskClose(String tidstr, HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getUserTask(request, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			return getUserTask(request, model);
		}
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowUser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return "login";
		}
		int uId = 0;
		try {
			uId = user.getStuId();
			if (user == null || uId == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return getUserTask(request, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return getUserTask(request, model);
		}
		Task theTask = taskService.getTask(tid);
		if (!(uId + "").equals(theTask.getPublishUserId())) {
			model.addAttribute("msg", "出现错误");
			return getUserTask(request, model);
		}
		theTask.setState(1);
		int r = taskService.updateTask(theTask);
		if (r > 0) {
			user.setMoney(user.getMoney()+theTask.getReward());
			int ruser = userService.updateUserInfo(user);
			if (ruser> 0) {
				model.addAttribute("msg", "成功");
			}else {
				model.addAttribute("msg", "已关闭-奖励未返回，请与管理员联系");
			}
		} else {
			model.addAttribute("msg", "失败");
		}
		List<Task> list = taskService.getUserTask(uId);
		model.addAttribute("list", list);
		return "userPTask";
	}

	// to2.to2.点击接受任务
	@RequestMapping("taskAccept.do")
	public String taskAccept(String tidstr, HttpServletRequest request, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidstr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return getTaskInfo(tidstr, model);
		}
		if (tid == 0) {
			model.addAttribute("msg", "出现错误");
			return getTaskInfo(tidstr, model);
		}
		User user = null;
		try {
			user = (User) request.getSession(false).getAttribute("nowUser");
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return getTaskInfo(tidstr,model);
		}
		int uid = 0;
		try {
			uid = user.getStuId();
			if (user == null || uid == 0) {
				model.addAttribute("msg", "请检查登录状况");
				return getTaskInfo(tidstr, model);
			}
		} catch (Exception e) {
			model.addAttribute("msg", "请检查登录状况");
			return getTaskInfo(tidstr, model);
		}
		Task theTask = taskService.getTask(tid);
		if ((uid + "").equals(theTask.getPublishUserId())) {
			model.addAttribute("msg", "不能接受自己的任务啊");
			return getTaskInfo(tidstr, model);
		}
		theTask.setAcceptUserId(uid);
		theTask.setState(2);
		int r = taskService.updateTask(theTask);
		if (r > 0) {
			model.addAttribute("msg", "成功");
		} else {
			model.addAttribute("msg", "失败");
		}
		return getTaskInfo(tidstr, model);
	}

	// 获取任务详细信息
	@RequestMapping("getTaskInfo.do")
	public String getTaskInfo(String tidStr, Model model) {
		int tid = 0;
		try {
			tid = Integer.parseInt(tidStr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "taskInfo";
		}
		Task theTask = taskService.getTask(tid);
		model.addAttribute("theTask", theTask);
		return "taskInfo";
	}

	/**
	 *   搜索任务
	 *   没有选择学校的时候就查询所有的
	 */

	@RequestMapping("list.do")
	public String findTask(String words, @RequestParam(required=true, defaultValue="-1") String schoolIdStr,
						   @RequestParam(required=true,defaultValue="1") Integer page , Model model) {

		model.addAttribute("words", words);
		model.addAttribute("schoolIdStr", schoolIdStr);

		Integer schoolId = null;
		if (!schoolIdStr.equals("-1")) {
			try {
				schoolId = Integer.parseInt(schoolIdStr);
			} catch (Exception e) {
				// todo
			}
		}
		if (words!=null) {
			words="%"+words+"%";
		}

		//这段代码表示，程序开始分页了，page默认值是1，每页记录数（pageSize）默认是3，意思是从第1页开始，每页显示3条记录
		//每页记录数可以自定义
		PageHelper.startPage(page, 3);
		List<Task> list = taskService.getTaskByKeysNoState(words, schoolId);
		PageInfo<Task> pageInfo = new PageInfo<Task>(list); //将集合封装到PageInfo
		//绑定数据，返回给页面
		model.addAttribute("p", pageInfo);
		
		return "index";
	}

}
