/*
 * The MIT License
 *
 * Copyright 2013 jdmr.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.huanqiuyuncang.controller.wms.fileupload;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import com.huanqiuyuncang.util.FileUpload;
import com.huanqiuyuncang.util.ImageUtil;
import com.huanqiuyuncang.util.UuidUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;


/**
 *
 * @author jdmr
 */
@Controller
@RequestMapping
public class AttachmentController {
    @RequestMapping("/uploadPic.do")
    public void uploadPic(HttpServletRequest request, String fileName, PrintWriter out){
        MultipartHttpServletRequest mr = (MultipartHttpServletRequest) request;
        CommonsMultipartFile cfile = (CommonsMultipartFile) mr.getFile(fileName);
        String tfileName =UuidUtil.get32UUID();
        String suffix = "";
        String orgFileName = cfile.getOriginalFilename();
        suffix = orgFileName.substring(orgFileName.lastIndexOf("."));
       // tfileName =  tfileName+suffix;
        //String path = request.getRealPath("/")+"img";
        String uploadPath = ImageUtil.getImagePath(request);
        String newFileName = FileUpload.fileUp(cfile,uploadPath , tfileName);
        String image = ImageUtil.thumbnailImage(uploadPath+"/"+newFileName, 350, 350, true);
        Map<String,String> pd = new HashMap<>();
        pd.put("realPath","product_"+tfileName+suffix);
        String jsonStr = JSONObject.fromObject(pd).toString();
        out.write(jsonStr);

    }


}
