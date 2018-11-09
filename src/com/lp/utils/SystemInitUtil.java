package com.lp.utils;

import com.lp.entity.CadInfo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.File;
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
		Constants.DEFAULT_PATH = FileUtility.getClassPathResource("default.path");
		String rootPath = Constants.DEFAULT_PATH;
		this.addFile(rootPath);
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
