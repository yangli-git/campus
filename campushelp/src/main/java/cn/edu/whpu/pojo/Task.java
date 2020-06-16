package cn.edu.whpu.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class Task {
    private Integer taskId;

    private String publishUserId;

    private String publishUserName;

    private Integer publishSchoolId;

    private Integer acceptUserId;

    private Double reward;

    private Date addTime;

    private Date endTime;

    private String taskName;

    private String taskContext;

    private Integer state;
    
}