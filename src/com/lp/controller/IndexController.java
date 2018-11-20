package com.lp.controller;

import com.alibaba.fastjson.JSONObject;
import com.lp.entity.CadInfo;
import com.lp.utils.Constants;
import com.lp.utils.FileUtility;
import com.lp.utils.MD5;
import com.lp.utils.ZipUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by CPR161 on 2018-09-19.
 */
@Controller
public class IndexController {

    @RequestMapping("/index")
    public String index(HttpServletRequest request, HttpServletResponse response) {
        String rootPath = Constants.DEFAULT_PATH;


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
        request.setAttribute("file",Constants.DEFAULT_PATH);
        request.setAttribute("_t","a");

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


    @RequestMapping("/showCad")
    @ResponseBody
    public String showCad(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fileName = "";
        String id = request.getParameter("key");
        CadInfo cadInfo = Constants.fileListMap.get(id);
        String realPath =  request.getRealPath("/");
        String dir = realPath +File.separator+"resource"+File.separator+"cad"+File.separator;
        String suffix = cadInfo.getName().substring(cadInfo.getName().lastIndexOf("."));
        fileName = cadInfo.getId()+suffix;
        FileUtility.moveFile(cadInfo.getPath(),dir,fileName,true);
        return fileName;
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

                int suffixIdx = cadInfo.getName().lastIndexOf(".");
                if(suffixIdx<0){
                    continue;
                }
                String suffix = cadInfo.getName().substring(suffixIdx+1);
                System.out.println("===文件后缀=="+suffix);
                // dwg,dxf,dwf
                if("dwg".equals(suffix.toLowerCase())||"dxf".equals(suffix.toLowerCase())||"dwf".equals(suffix.toLowerCase())){
                    if(cadInfo.getName().toLowerCase().indexOf(keyValue)>-1){
                        list.add(cadInfo);
                    }
                }else{
                    continue;
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
            String rootPath = Constants.DEFAULT_PATH;
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


    @RequestMapping("/doPackage")
    @ResponseBody
    public String doPackage(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String mapObjStr = request.getParameter("mapObj");
        JSONObject jsonObj =  JSONObject.parseObject(mapObjStr);
        Iterator<String> keys = jsonObj.keySet().iterator();
        List<String> list = new ArrayList<>();
        while(keys.hasNext()){
            list.add(keys.next());
        }
        // 按自然顺序排序
        Collections.sort(list);
        String zipName =  MD5.stringMD5(JSONObject.toJSONString(list));

        // 生成压缩文件
        String realPath =  request.getRealPath("/");
        String zipDir = realPath +"resource"+File.separator+"zip"+File.separator+zipName;
        File zipDirFile = new File(zipDir+File.separator);
        if(!zipDirFile.exists()){
            zipDirFile.mkdirs();
        }

        File zipFile = new File(zipDir+".zip");

        String zip = zipName+".zip";

        if(zipFile.exists()){
           return  zip;
        }else{
            for(int i=0;i<list.size();i++){
                String id = list.get(i);
                CadInfo cadInfo = Constants.fileListMap.get(id);
                FileUtility.moveFile(cadInfo.getPath(),zipDir+File.separator,cadInfo.getName(),false);
            }
            // 压缩
            FileOutputStream fos1 = new FileOutputStream(zipFile);
            ZipUtils.toZip(zipDir, fos1,true);
            //删除文件夹
            FileUtility.deleteDirectory(zipDir);
        }

        return zip;
    }

    @RequestMapping("/download")
    public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {

        byte[] buf = new byte[1024];
        int len;
        String zipFileName = request.getParameter("zipFileName");
        String realPath =  request.getRealPath("/");
        String zipDir = realPath +File.separator+"resource"+File.separator+"zip"+File.separator+zipFileName;
        File zipFile = new File(zipDir);
        //下载文件
        FileInputStream zipInput =new FileInputStream(zipFile);
        OutputStream out = response.getOutputStream();
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename="+zipFileName);
        while ((len=zipInput.read(buf))!= -1){
            out.write(buf,0,len);
        }
        zipInput.close();
        out.flush();
        out.close();

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


    /**
     * 进入管理员界面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/admin")
    public String admin(HttpServletRequest request, HttpServletResponse response) {


        return "admin";
    }


    @RequestMapping("/login")
    @ResponseBody
    public Map login(HttpServletRequest request, HttpServletResponse response) {
        Map<String,Object> result = new HashMap<>();
        result.put("success",false);
        result.put("msg","密码不正确！");

        String password = request.getParameter("password");
        String key = FileUtility.getClassPathResource("key");
        if(password.equals(key)){
            result.put("success",true);
            request.getSession().setAttribute("isAdmin",true);
        }

        return result;
    }


    /**
     * 进入管理员界面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/cadReplace")
    public String cadReplace(HttpServletRequest request, HttpServletResponse response) {
        // 判断是经过校验
        Boolean isAdmin = Boolean.valueOf(String.valueOf( request.getSession().getAttribute(Constants.IS_ADMIN))) ;
        if(!isAdmin){
            return "redirect:/admin.do";
        }

        request.setAttribute("_t","b");
        return "cadReplace";
    }

    @RequestMapping("/leave")
    public String leave(HttpServletRequest request, HttpServletResponse response) {
        // 判断是经过校验
        Boolean isAdmin = Boolean.valueOf((String) request.getSession().getAttribute(Constants.IS_ADMIN)) ;
        if(isAdmin){
            request.getSession().setAttribute("isAdmin",null);
        }

        return "redirect:/toSearchPage.do";
    }


    /**
     * 进入密码设置界面
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/setPassPage")
    public String setPassPage(HttpServletRequest request, HttpServletResponse response) {


        return "setPassPage";
    }


    @RequestMapping("/modifyPass")
    @ResponseBody
    public Map modifyPass(HttpServletRequest request, HttpServletResponse response) {
        Map<String,Object> result = new HashMap<>();
        result.put("success",false);
        result.put("msg","修改失败！");

        String passwordOld = request.getParameter("passwordOld");
        String passwordNew = request.getParameter("passwordNew");
        String passwordCheck = request.getParameter("passwordCheck");

        if(StringUtils.isEmpty(passwordOld)||StringUtils.isEmpty(passwordNew)||StringUtils.isEmpty(passwordCheck)){
            result.put("msg","修改信息不能为空！");
            return  result;
        }
        if(!passwordNew.equals(passwordCheck)){
            result.put("msg","确认密码和新密码不一致，请检查！");
            return  result;
        }

        String key = FileUtility.getClassPathResource("key");
        if(passwordOld.equals(key)){
            result.put("success",true);
            File file= null;
            try {
                file = ResourceUtils.getFile("classpath:key");
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
            FileUtility.writeFileText(file.getAbsolutePath(),passwordNew,false);
            // 修改密码后把session清空
            request.getSession().setAttribute(Constants.IS_ADMIN,null);
        }else{
            result.put("msg","原密码不输入不正确！");
        }

        return result;
    }

    // openUploadPage
    @RequestMapping("/openUploadPage")
    public String openUploadPage(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("id",request.getParameter("id"));
        return "upload";
    }


    @RequestMapping("/uploadSaveFiles")
    @ResponseBody
    public void uploadSaveFiles(HttpServletRequest request, @RequestParam MultipartFile[] multipartFile){

        String selectedKey = request.getParameter("id");
        String isReplaceAll = request.getParameter("isReplaceAll");
        CadInfo cadInfo = Constants.fileListMap.get(selectedKey);

        Map<String, Object> returnMap = new HashMap<>();
        boolean success = false;
        returnMap.put("success", success);
        if(multipartFile != null && multipartFile.length > 0){
            for(MultipartFile multiFile : multipartFile){
                String originalFileName = multiFile.getOriginalFilename();
                try {
                    String dstFilePath = cadInfo.getPath();
                    String fileName = cadInfo.getName();
                    File dstFile = new File(dstFilePath);
                    multiFile.transferTo(dstFile);
                    // 全局替换
                    if("1".equals(isReplaceAll)){
                       Set<String> keys = Constants.fileListMap.keySet();
                        int idx =0;
                       for(String key:keys){
                           idx++;
                           if(!key.equals(selectedKey)){
                               CadInfo tmpCi = Constants.fileListMap.get(key);
                               if(tmpCi.getName().equals(fileName)){
                                   //File dstFile2 = new File(tmpCi.getPath());
                                   //multiFile.transferTo(dstFile2);
                                   String destDir = Constants.fileListMap.get(tmpCi.getpId()).getPath()+File.separator;
                                   boolean replaceFlag = FileUtility.moveFile(dstFilePath,destDir,tmpCi.getName(),true);
                                   System.out.println("匹配文件【"+fileName+"】索引项：【"+idx+"】，源文件：【"+dstFilePath+"】目标文件【"+tmpCi.getPath()+"】，替换状态【"+replaceFlag+"】");
                               }
                           }
                       }
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            success = true;
        }
        returnMap.put("success", success);
       //return returnMap;
    }

}
