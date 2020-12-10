package com.example.admin.mapper;

import com.example.admin.config.mybatis.DefaultMapper;
import com.example.admin.entity.SystemAdmin;
import com.example.admin.service.SystemMenuInfo;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SystemAdminMapper extends DefaultMapper {
    int deleteByPrimaryKey(Integer adminId);

    int insert(SystemAdmin record);

    int insertSelective(SystemAdmin record);

    SystemAdmin selectByPrimaryKey(Integer adminId);

    int updateByPrimaryKeySelective(SystemAdmin record);

    int updateByPrimaryKey(SystemAdmin record);

    SystemAdmin findByAdminName(@Param(value = "adminName")String username);

    /**
     * 查询用户角色
     * @param adminId
     * @return
     */
    int findRoleIdByAdminId(@Param(value = "adminId")Integer adminId);

    List<SystemMenuInfo> selectSystemMenuInfoByRoleId(@Param(value = "roleId")Integer roleId);

    List<SystemMenuInfo> selectAllSystemMenuInfo();

}
