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
public class User {
    private Integer stuId;

    private String studentId;

    private String password;

    private Integer schoolId;

    private Integer sex;

    private String name;

    private Date registerTime;

    private Double money;

    private Integer state;
    
}