package com.huanqiuyuncang.controller.wms.customer;

import com.huanqiuyuncang.controller.base.BaseController;
import com.huanqiuyuncang.entity.Page;
import com.huanqiuyuncang.entity.brand.BrandEntity;
import com.huanqiuyuncang.entity.customer.CustomerEntity;
import com.huanqiuyuncang.service.wms.customer.CustomerInterface;
import com.huanqiuyuncang.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lzf on 2017/4/12.
 */
@Controller
@RequestMapping("customer")
public class CustomerController extends BaseController {
    // 默认客户状态
    // 1.计算跨境速递费	是否外部商品转换	发货仓库
    // 2.按商品内部货值计算申报货值	收款状态	计算预计纸箱和包装及费用	计算运费 负仓出库

    public static final String CUSTOMERSTATUS = "1_1_1_1_1_1_1_1";

    String menuUrl = "customer/list.do"; //菜单地址(权限用)
    @Autowired
    private CustomerInterface customerService;
    /**保存
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/save")
    public ModelAndView save() throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"新增CustomerEntity");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        BeanMapUtil.setCreateUserInfo(pd);
        BeanMapUtil.setUpdateUserInfo(pd);
        CustomerEntity customerEntity = (CustomerEntity) BeanMapUtil.mapToObject(pd, CustomerEntity.class);
        customerEntity.setCustomerid(this.get32UUID());
        customerEntity.setCustomerstatus(CUSTOMERSTATUS);
        customerService.insertSelective(customerEntity);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }


    /**删除
     * @param out
     * @throws Exception
     */
    @RequestMapping(value="/delete")
    public void delete(PrintWriter out) throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"删除CustomerEntity");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
        PageData pd = this.getPageData();
        String customerid = pd.getString("customerid");
        Integer sum = checkTable("wms_customer","customerid", customerid);
        String msg = "success";
        if(sum >0){
            msg = "error";
        }else{
            customerService.deleteByPrimaryKey(customerid);
        }
        out.write(msg);
        out.close();
    }

    /**修改
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/edit")
    public ModelAndView edit() throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"修改CustomerEntity");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        BeanMapUtil.setUpdateUserInfo(pd);
        CustomerEntity customerEntity = (CustomerEntity) BeanMapUtil.mapToObject(pd,CustomerEntity.class);
        customerService.updateByPrimaryKeySelective(customerEntity);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }

    /**列表
     * @param page
     * @throws Exception
     */
    @RequestMapping(value="/list")
    public ModelAndView list(Page page) throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"列表CustomerEntity");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        page.setPd(pd);
        pd.put("createuser",Jurisdiction.getUsername());
        //判断是否据有查看所有客户权限
        Map<String, String> hc = Jurisdiction.getHC();
        if(hc.keySet().contains("customerlist")){
            pd.remove("createuser");
        }
        List<CustomerEntity> varList =   customerService.datalistPage(page);
        mv.setViewName("wms/customer/customer_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
        return mv;
    }

    /**去新增页面
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/goAdd")
    public ModelAndView goAdd()throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        mv.setViewName("wms/customer/customer_edit");
        mv.addObject("msg", "save");
        mv.addObject("pd", pd);
        return mv;
    }

    /**去修改页面
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/goEdit")
    public ModelAndView goEdit()throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String customerid = pd.getString("customerid");
        CustomerEntity customerEntity = customerService.selectByPrimaryKey(customerid);//根据ID读取
        mv.setViewName("wms/customer/customer_edit");
        mv.addObject("msg", "edit");
        mv.addObject("customer", customerEntity);
        mv.addObject("pd", pd);
        mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
        return mv;
    }

    @RequestMapping(value="/goStatus")
    public ModelAndView goStatus()throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String customerid = pd.getString("customerid");
        CustomerEntity customerEntity = customerService.selectByPrimaryKey(customerid);
        mv.setViewName("wms/customer/customer_statusview");
        mv.addObject("msg", "changestatus");
        mv.addObject("pd", pd);
        mv.addObject("customerid", customerid);
        mv.addObject("customerStatus", customerEntity.getCustomerstatus());
        return mv;
    }


    @RequestMapping(value="/changestatus")
    public ModelAndView changestatus() throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String str = "";
        for(int i = 0;i<9 ; i++){
            str = str + pd.getString(""+i)+"_";
        }
        str =  str.substring(0,str.length()-1);
        String customerid =  pd.getString("customerid");
        CustomerEntity customerEntity = customerService.selectByPrimaryKey(customerid);
        customerEntity.setCustomerstatus(str);
        customerService.updateByPrimaryKeySelective(customerEntity);
        mv.addObject("msg","success");
        mv.setViewName("save_result");
        return mv;
    }

    /**批量删除
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/deleteAll")
    @ResponseBody
    public Object deleteAll() throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"批量删除CustomerEntity");
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
        Map<String,Object> map = new HashMap<String,Object>();
        PageData pd = this.getPageData();
        List<PageData> pdList = new ArrayList<PageData>();
        String DATA_IDS = pd.getString("DATA_IDS");
        if(null != DATA_IDS && !"".equals(DATA_IDS)){
            String ArrayDATA_IDS[] = DATA_IDS.split(",");
            Integer sum = checkTable("wms_customer","customerid", ArrayDATA_IDS);
            if(sum > 0){
                map.put("msg","error");
                return AppUtil.returnObject(pd, map);
            }
            customerService.deleteAll(ArrayDATA_IDS);
            map.put("msg", "success");
        }else{
            map.put("msg","error");
        }
        return AppUtil.returnObject(pd, map);
    }

    @RequestMapping(value="/findCustomerByCode")
    @ResponseBody
    public Object findCustomerByCode(String customercode) throws Exception{
        CustomerEntity customerEntity = customerService.selectCustomerByCode(customercode);
        Map<String,String> map = new HashMap<String,String>();
        String errInfo = "success";
        if (customerEntity != null){
            errInfo = "error";
        }
        map.put("result", errInfo);				//返回结果
        return AppUtil.returnObject(new PageData(), map);
    }

    @RequestMapping(value="/findCustomerByName")
    @ResponseBody
    public Object findCustomerByName(String customername) throws Exception{
        CustomerEntity customerEntity = customerService.selectCustomerByName(customername);
        Map<String,String> map = new HashMap<String,String>();
        String errInfo = "success";
        if (customerEntity != null){
            errInfo = "error";
        }
        map.put("result", errInfo);				//返回结果
        return AppUtil.returnObject(new PageData(), map);
    }

}
