package cn.edu.whpu.controller;

import cn.edu.whpu.pojo.School;
import cn.edu.whpu.pojo.User;
import cn.edu.whpu.service.SchoolService;
import cn.edu.whpu.service.UserService;
import cn.edu.whpu.util.JsonUtil;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


/**
 * 注销登录*
 * 异步读取院校列表*
 * 读取一个用户信息*
 * @author 
 *
 */
@Controller
@SessionAttributes({ "nowUser","nowAdmin"})
@RequestMapping(value = "common/")
public class CommonController {


	@Resource(name = "schoolService")
	public SchoolService schoolService;


	@Resource(name = "userService")
	public UserService userService;
	
	// 注销
	@RequestMapping("logout.do")
	public String logout(HttpServletRequest request, Model model) {
		model.addAttribute("msg", "已退出");
		request.getSession(false).removeAttribute("nowUser");
		request.getSession(false).removeAttribute("nowAdmin");
		return "login";
	}
	
	@RequestMapping("getAllSchools.do")
	public void getAllSchools(HttpServletResponse response) throws IOException{
		List<School> list = schoolService.getAllSchoolsNoState();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		String list_String = JsonUtil.list2json(list);
		PrintWriter out = response.getWriter();
		out.println(list_String);
		out.flush();
		out.close();
	}
	
	@RequestMapping("getUser.do")
	public String getUser(String stuIdStr,Model model) {
		int stuId = 0;
		try {
			stuId = Integer.parseInt(stuIdStr);
		} catch (Exception e) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		if (stuId==0) {
			model.addAttribute("msg", "出现错误");
			return "userInfo";
		}
		User user = userService.getByUid(stuId);
		model.addAttribute("theUser", user);
		return "userInfo";
	}
	
	
	
}
