package com.lp.controller;

import com.alibaba.fastjson.JSONObject;
import com.lp.entity.CadInfo;
import com.lp.utils.Config;
import com.lp.utils.Constants;
import com.lp.utils.MD5;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by CPR161 on 2018-09-19.
 */
@Controller
public class IndexController {

    @RequestMapping("/index")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        String rootPath = Config.getString("default.path");


        File file = new File(rootPath);
        List list = new ArrayList<>();
        if(file.exists()) {
            list = this.getChildList(rootPath);
        }
        request.setAttribute("treeNodes",JSONObject.toJSONString(list));

        return "index";
    }

    @RequestMapping("/toSearchPage")
    public String toSearchPage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("file",Config.getString("default.path"));


        return "searchPage";
    }

    @RequestMapping("/demo")
    public String demo(HttpServletRequest request, HttpServletResponse response) {

        return "demo";
    }


    @RequestMapping("/showImg")
    public void showImg(HttpServletRequest request, HttpServletResponse response) throws IOException {

        //从数据库中获取流程图的二进制数据
        String id = request.getParameter("id");
        CadInfo catInfo = Constants.fileListMap.get(id);
        InputStream inputStream= new FileInputStream(catInfo.getPath());
        ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
        byte[] buff = new byte[100]; //buff用于存放循环读取的临时数据
        int rc = 0;
        //将输入流转换为字符数组输出流
        while ((rc = inputStream.read(buff, 0, 100)) > 0) {
            swapStream.write(buff, 0, rc);
        }
        byte[] img = swapStream.toByteArray(); //in_b为转换之后的结果
        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();
        os.write(img);
        os.flush();
        os.close();

    }

    @RequestMapping("/doSearch")
    @ResponseBody
    public List doSearch(HttpServletRequest request, HttpServletResponse response) {
        List list = new ArrayList<>();
        String keyValue = request.getParameter("keyValue").toLowerCase();
        // 搜索文件是否存在
        if(!Constants.fileListMap.isEmpty()){
            Iterator<String> keys = Constants.fileListMap.keySet().iterator();
            while (keys.hasNext()){
                String key = keys.next();
                CadInfo cadInfo = Constants.fileListMap.get(key);
                if(Boolean.valueOf(cadInfo.isDir())){
                    continue;
                }
                if(cadInfo.getName().toLowerCase().indexOf(keyValue)>-1){
                    list.add(cadInfo);
                }
            }
        }
        return list;
    }


    @RequestMapping("/getChild")
    @ResponseBody
    public List getChild(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String isDir = request.getParameter("isDir");
        String name = request.getParameter("name");

        String parentPath = "";
        if(StringUtils.isEmpty(id)){
            String rootPath = Config.getString("default.path");
            id = MD5.stringMD5(rootPath);
            CadInfo cInfo = new CadInfo();
            cInfo.setId(id);
            cInfo.setPath(rootPath);

            File rootFile = new File(rootPath);
            if(rootFile.exists()){
                cInfo.setName(rootFile.getName());
                Constants.fileListMap.put(id,cInfo);
            }
            parentPath = rootPath;
        }else{
            CadInfo cadInfo = Constants.fileListMap.get(id);
            parentPath = cadInfo.getPath();
        }

        List list = new ArrayList<>();
        File file = new File(parentPath);
        if(file.exists()) {
            list  = this.getChildList(parentPath);
        }
        return list;
    }

    @RequestMapping("/getCadInfo")
    @ResponseBody
    public CadInfo getCadInfo(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        CadInfo cadInfo = Constants.fileListMap.get(id);
        return cadInfo;
    }

    public List getChildList(String rootPath){
        File file = new File(rootPath);
        String [] files = file.list();
        List root = new ArrayList<>();
        for(String filePath:files){
            JSONObject child = new JSONObject();
            String realPath = rootPath + File.separator + filePath;
            File f = new File(realPath);
            boolean isDir = false;
            if(f.isDirectory()){
                isDir = true;
            }
            // 把文件路径散列为hash字符串存储
            String hashId = MD5.stringMD5(realPath);
            String pId = MD5.stringMD5(rootPath);

            CadInfo cInfo = new CadInfo();
            cInfo.setId(hashId);
            cInfo.setPath(realPath);
            cInfo.setName(f.getName());
            cInfo.setpId(pId);
            cInfo.setDir(isDir);

            Constants.fileListMap.put(hashId,cInfo);
            child.put("id",hashId);
            child.put("pId",pId);
            child.put("isParent",isDir);
            child.put("name",f.getName());
            root.add(child);
        }
        return  root;
    }


}
