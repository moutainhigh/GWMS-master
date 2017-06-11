package com.huanqiuyuncang.service.wms.kuwei.impl;

import com.huanqiuyuncang.dao.kuwei.ShangPinKuWeiDAO;
import com.huanqiuyuncang.entity.Page;
import com.huanqiuyuncang.entity.kuwei.BaoGuoKuWeiEntity;
import com.huanqiuyuncang.entity.kuwei.ShangPinKuWeiEntity;
import com.huanqiuyuncang.service.wms.kuwei.ShangPinKuWeiInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lzf on 2017/6/11.
 */
@Service
public class ShangPinKuWeiService implements ShangPinKuWeiInterface {
    @Autowired
    private ShangPinKuWeiDAO shangPinKuWeiDAO;
    @Override
    public int deleteByPrimaryKey(String id) {
        return shangPinKuWeiDAO.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(ShangPinKuWeiEntity record) {
        return shangPinKuWeiDAO.insert(record);
    }

    @Override
    public int insertSelective(ShangPinKuWeiEntity record) {
        return shangPinKuWeiDAO.insertSelective(record);
    }

    @Override
    public ShangPinKuWeiEntity selectByPrimaryKey(String id) {
        return shangPinKuWeiDAO.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(ShangPinKuWeiEntity record) {
        return shangPinKuWeiDAO.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(ShangPinKuWeiEntity record) {
        return shangPinKuWeiDAO.updateByPrimaryKey(record);
    }

    @Override
    public List<ShangPinKuWeiEntity> datalistPage(Page page) {
        return shangPinKuWeiDAO.datalistPage(page);
    }

    @Override
    public void deleteAll(String[] arrayDATA_ids) {
        for (String id : arrayDATA_ids) {
            shangPinKuWeiDAO.deleteByPrimaryKey(id);
        }
    }
}