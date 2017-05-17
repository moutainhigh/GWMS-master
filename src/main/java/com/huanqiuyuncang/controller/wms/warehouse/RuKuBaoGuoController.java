package com.huanqiuyuncang.controller.wms.warehouse;

import com.huanqiuyuncang.controller.base.BaseController;
import com.huanqiuyuncang.dao.warehouse.RuKuBaoGuoDAO;
import com.huanqiuyuncang.entity.Page;
import com.huanqiuyuncang.entity.warehouse.ChuKuShangPinEntity;
import com.huanqiuyuncang.entity.warehouse.PackageWarehouseEntity;
import com.huanqiuyuncang.entity.warehouse.ProductWarehouseEntity;
import com.huanqiuyuncang.entity.warehouse.RuKuBaoGuoEntity;
import com.huanqiuyuncang.service.wms.warehouse.PackageWarehouseInterface;
import com.huanqiuyuncang.service.wms.warehouse.RuKuBaoGuoInterface;
import com.huanqiuyuncang.util.AppUtil;
import com.huanqiuyuncang.util.Jurisdiction;
import com.huanqiuyuncang.util.PageData;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;
import java.util.*;

/**
 * Created by lzf on 2017/5/13.
 */
@Controller
@RequestMapping(value="/rukubaoguo")
public class RuKuBaoGuoController extends BaseController {
    String menuUrl = "rukubaoguo/list.do";
    @Autowired
    private RuKuBaoGuoInterface ruKuBaoGuoService;

    @Autowired
    private PackageWarehouseInterface packageWarehouseService;

    /**列表
     * @param page
     * @throws Exception
     */
    @RequestMapping(value="/list")
    public ModelAndView list(Page page) throws Exception{
        logBefore(logger, Jurisdiction.getUsername()+"列表Product");
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        page.setPd(pd);
        List<RuKuBaoGuoEntity> varList = ruKuBaoGuoService.datalistPage(page);
        mv.setViewName("wms/warehouse/rukubaoguo_list");
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
        mv.setViewName("wms/warehouse/rukubaoguo_edit");
        mv.addObject("msg", "save");
        mv.addObject("pd", pd);
        return mv;
    }

    /**去扫码页面
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/goSaoma")
    public ModelAndView goSaoma()throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String rukubaoguoid = pd.getString("rukubaoguoid");
        RuKuBaoGuoEntity ruKuBaoGuoEntity = ruKuBaoGuoService.selectByPrimaryKey(rukubaoguoid);//根据ID读取
        mv.setViewName("wms/warehouse/baoguo_saoma");
        mv.addObject("msg", "updatecangku");
        mv.addObject("rukubaoguo", ruKuBaoGuoEntity);
        mv.addObject("pd", pd);
        return mv;
    }


    @RequestMapping(value="/updatecangku")
    public ModelAndView updatecangku() throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String username = Jurisdiction.getUsername();
        Date date = new Date();
        String saomiaobaoguo = pd.getString("saomiaobaoguo");
        String saomiaocangwei = pd.getString("saomiaocangwei");
        String rukubaoguoid = pd.getString("rukubaoguoid");
        RuKuBaoGuoEntity ruKuBaoGuoEntity = ruKuBaoGuoService.selectByPrimaryKey(rukubaoguoid);//根据ID读取
        if(saomiaobaoguo.equals(ruKuBaoGuoEntity.getBaoguodanhao())){
            ruKuBaoGuoEntity.setRukuzhuangtai("orderStatus_yidabao");
            String cangwei = ruKuBaoGuoEntity.getCangwei();
            cangwei =  StringUtils.isBlank(cangwei)?saomiaocangwei:cangwei;
            PackageWarehouseEntity packageWarehouse = packageWarehouseService.selectByRuKuBaoGuo(ruKuBaoGuoEntity);
            if(packageWarehouse == null){
                PackageWarehouseEntity packageW = new PackageWarehouseEntity();
                packageW.setPackagewarehouseid(this.get32UUID());
                packageW.setCangwei(cangwei);
                packageW.setUpdatetime(date);
                packageW.setUpdateuser(username);
                packageW.setCreatetime(date);
                packageW.setCreateuser(username);
                packageW.setShuliang("1");
                packageWarehouseService.insert(packageW);
            }else {
                Integer sum = Integer.parseInt(packageWarehouse.getShuliang());
                sum = sum+1;
                packageWarehouse.setShuliang(Integer.toString(sum));
                packageWarehouseService.updateByPrimaryKeySelective(packageWarehouse);
            }
            mv.addObject("msg","success");
        }else{
            mv.addObject("msg","error");
        }

        mv.setViewName("save_result");
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
        String rukubaoguoid = pd.getString("rukubaoguoid");
        RuKuBaoGuoEntity ruKuBaoGuoEntity = ruKuBaoGuoService.selectByPrimaryKey(rukubaoguoid);//根据ID读取
        mv.setViewName("wms/warehouse/rukubaoguo_edit");
        mv.addObject("msg", "edit");
        mv.addObject("rukubaoguo", ruKuBaoGuoEntity);
        mv.addObject("pd", pd);
        return mv;
    }

    /**保存
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/save")
    public ModelAndView save(RuKuBaoGuoEntity ruKuBaoGuoEntity) throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
        ModelAndView mv = this.getModelAndView();
        String username = Jurisdiction.getUsername();
        Date date = new Date();
        ruKuBaoGuoEntity.setRukubaoguoid(this.get32UUID());
        ruKuBaoGuoEntity.setCreateuser(username);
        ruKuBaoGuoEntity.setUpdateuser(username);
        ruKuBaoGuoEntity.setCreatetime(date);
        ruKuBaoGuoEntity.setUpdatetime(date);
        ruKuBaoGuoService.insertSelective(ruKuBaoGuoEntity);
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
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
        PageData pd = this.getPageData();
        String rukubaoguoid = pd.getString("rukubaoguoid");
        ruKuBaoGuoService.deleteByPrimaryKey(rukubaoguoid);
        out.write("success");
        out.close();
    }

    /**修改
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/edit")
    public ModelAndView edit(RuKuBaoGuoEntity ruKuBaoGuoEntity) throws Exception{
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
        ModelAndView mv = this.getModelAndView();
        ruKuBaoGuoService.updateByPrimaryKeySelective(ruKuBaoGuoEntity);
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
        if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
        Map<String,Object> map = new HashMap<String,Object>();
        PageData pd = this.getPageData();
        List<PageData> pdList = new ArrayList<PageData>();
        String DATA_IDS = pd.getString("DATA_IDS");
        if(null != DATA_IDS && !"".equals(DATA_IDS)){
            String ArrayDATA_IDS[] = DATA_IDS.split(",");
            ruKuBaoGuoService.deleteAll(ArrayDATA_IDS);
            pd.put("msg", "ok");
        }else{
            pd.put("msg", "no");
        }
        pdList.add(pd);
        map.put("list", pdList);
        return AppUtil.returnObject(pd, map);
    }

}