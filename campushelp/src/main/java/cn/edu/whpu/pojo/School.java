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
public class School {
    private Integer schoolId;

    private String name;

    private Date addTime;

    private Integer state;

    
}