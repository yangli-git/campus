package cn.edu.whpu.service;

import cn.edu.whpu.pojo.Task;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface TaskService {
	
	/**
	 * 读取全部任务
	 * @return
	 */
	public List<Task> getAllTask();
	
	/**
	 * 添加新任务
	 * @param task
	 * @return
	 */
	public int setNewTask(Task task);
	
	/**
	 * 读取某用户全部任务
	 * @return
	 */
	public List<Task> getUserTask(Integer stuId);
	
	/**
	 * 读取某用户接受任务
	 * @return
	 */
	public List<Task> getUserATask(Integer stuId);
	
	/**
	 * 读取1个任务
	 * @return
	 */
	public Task getTask(Integer tid);
	
	/**
	 * 更新任务
	 * @param task
	 * @return
	 */
	public int updateTask(Task task);
	
	/**
     * selectTaskByKeys
     * @param 
     * @return
     */
    public List<Task> getTaskByKeys(String words, Integer schoolId);
    
    /**
     * selectTaskByKeysNoState
     * @param 
     * @return
     */
    public List<Task> getTaskByKeysNoState(@Param("words") String words, @Param("schoolId") Integer schoolId);
	
}
