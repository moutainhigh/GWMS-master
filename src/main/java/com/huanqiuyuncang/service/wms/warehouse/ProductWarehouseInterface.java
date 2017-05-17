package com.huanqiuyuncang.service.wms.warehouse;

import com.huanqiuyuncang.entity.Page;
import com.huanqiuyuncang.entity.warehouse.ChuKuShangPinEntity;
import com.huanqiuyuncang.entity.warehouse.PackageWarehouseEntity;
import com.huanqiuyuncang.entity.warehouse.ProductWarehouseEntity;

import java.util.List;

public interface ProductWarehouseInterface {
    int deleteByPrimaryKey(String productwarehouseid);

    int insert(ProductWarehouseEntity record);

    int insertSelective(ProductWarehouseEntity record);

    ProductWarehouseEntity selectByPrimaryKey(String productwarehouseid);

    int updateByPrimaryKeySelective(ProductWarehouseEntity record);

    int updateByPrimaryKey(ProductWarehouseEntity record);

    List<ProductWarehouseEntity> datalistPage(Page page);

    void deleteAll(String[] arrayDATA_ids);


    ProductWarehouseEntity selectByChuKuShangPin(ChuKuShangPinEntity chuKuShangPinEntity);
}