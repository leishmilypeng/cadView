package com.lp.utils;

import com.lp.entity.CadInfo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.ResourceUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;

public class SystemInitUtil {

	static final Log LOG = LogFactory.getLog(SystemInitUtil.class);
	
	public void init(){

		if(!Constants.fileListMap.isEmpty()){
			LOG.info("====定时任务启动清空map===");
			Constants.fileListMap.clear();
		}

		LOG.info("====开始检索文件===");
		Timestamp begin = DateUtil.getCurrentTimestamp();
		//String rootPath = Config.getString("default.path");


		//Constants.DEFAULT_PATH = FileUtility.getClassPathResource("default.path.txt");
		File defaultPathFile = null;
		try {
			defaultPathFile = ResourceUtils.getFile("classpath:default.path.txt");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		BufferedReader buff = null;
		try {
			buff = new BufferedReader(new InputStreamReader(new FileInputStream(defaultPathFile),"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		String line=null;
		StringBuilder infoMsg=new StringBuilder();
		try {
			while((line=buff.readLine())!=null) {
                // 重复读取
                infoMsg.append(line).append("");
            }
		} catch (IOException e) {
			e.printStackTrace();
		}
		String rootPath = infoMsg.toString();
		if(rootPath.indexOf("=")>=0){
			int charIdx = rootPath.indexOf("=");
			rootPath = rootPath.substring(charIdx+1);
		}
		this.addFile(rootPath);
		Constants.DEFAULT_PATH = rootPath;
		Timestamp end = DateUtil.getCurrentTimestamp();
		long last = (end.getTime()-begin.getTime())/1000;
		LOG.info("====结束检索文件===,耗时："+last+"s,文件个数:"+Constants.fileListMap.size());
	}

	public void addFile(String parentFilePath) {
		File file = new File(parentFilePath);
		LOG.info("====检索目录===:"+parentFilePath);
		String [] files = file.list();
		for(String filePath:files){
			String realPath = parentFilePath + File.separator + filePath;
			File f = new File(realPath);
			boolean isDir = false;
			if(f.isDirectory()){
				isDir = true;
			}
			// 把文件路径散列为hash字符串存储
			String hashId = MD5.stringMD5(realPath);
			String pId = MD5.stringMD5(parentFilePath);

			CadInfo cInfo = new CadInfo();
			cInfo.setId(hashId);
			cInfo.setPath(realPath);
			cInfo.setName(f.getName());
			cInfo.setpId(pId);
			cInfo.setDir(isDir);

			Constants.fileListMap.put(hashId,cInfo);

			if(isDir){
				this.addFile(realPath);
			}
		}


	}

}
