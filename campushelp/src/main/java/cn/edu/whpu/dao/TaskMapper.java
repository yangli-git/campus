package cn.edu.whpu.dao;

import cn.edu.whpu.pojo.Task;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TaskMapper {
    int deleteByPrimaryKey(Integer taskId);

    int insert(Task record);

    int insertSelective(Task record);

    Task selectByPrimaryKey(Integer taskId);

    int updateByPrimaryKeySelective(Task record);

    int updateByPrimaryKey(Task record);
    
    /**
	 * 读取全部任务
	 * @return
	 */
	public List<Task> selectAllTask();
	
	/**
	 * 读取某用户发布的任务
	 * @return
	 */
	public List<Task> selectUserTask(Integer stuId);
	
	/**
	 * 读取某用户接受任务
	 * @return
	 */
	public List<Task> selectUserATask(Integer stuId);
	
	/**
     * selectTaskByKeys
     * @param 
     * @return
     */
    public List<Task> selectTaskByKeys(@Param("words") String words, @Param("schoolId") Integer schoolId);
    
    /**
     * selectTaskByKeysNoState
     * @param 
     * @return
     */
    public List<Task> selectTaskByKeysNoState(@Param("words") String words, @Param("schoolId") Integer schoolId);
}