package cn.edu.whpu.pojo;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Admin {
    private Integer aId;

    private String account;

    private String password;

    private String name;

    private Date addTime;

    private Integer state;

}