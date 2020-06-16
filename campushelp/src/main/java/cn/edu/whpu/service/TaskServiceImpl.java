package cn.edu.whpu.service;

import cn.edu.whpu.dao.TaskMapper;
import cn.edu.whpu.pojo.Task;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("taskService")
public class TaskServiceImpl implements TaskService {

    @Resource(name = "taskMapper")
    private TaskMapper taskMapper;

    @Override
    public List<Task> getAllTask() {

        return taskMapper.selectAllTask();
    }

    @Override
    public int setNewTask(Task task) {
        return taskMapper.insert(task);
    }

    @Override
    public List<Task> getUserTask(Integer stuId) {
        return taskMapper.selectUserTask(stuId);
    }

    @Override
    public Task getTask(Integer tId) {
        return taskMapper.selectByPrimaryKey(tId);
    }

    @Override
    public int updateTask(Task task) {
        return taskMapper.updateByPrimaryKeySelective(task);
    }

    @Override
    public List<Task> getUserATask(Integer stuId) {
        return taskMapper.selectUserATask(stuId);
    }

    @Override
    public List<Task> getTaskByKeys(String words, Integer schoolId) {
        // TODO Auto-generated method stub
        return taskMapper.selectTaskByKeys(words, schoolId);
    }

    @Override
    public List<Task> getTaskByKeysNoState(String words, Integer schoolId) {
        // TODO Auto-generated method stub
        return taskMapper.selectTaskByKeysNoState(words, schoolId);
    }


}
