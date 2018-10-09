package com.lp.utils;

import org.springframework.core.io.ClassPathResource;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

public final class FileUtility {
	private FileUtility() {

	}

	public static String getFileText(String strFileName) {
		java.io.FileReader reader = null;

		try {
			reader = new java.io.FileReader(strFileName);

			StringBuffer buffer = new StringBuffer();
			int iReadCount = 0;
			char[] temp = new char[1024];

			do {
				iReadCount = reader.read(temp);
				if (iReadCount > 0) {
					buffer.append(new String(temp, 0, iReadCount));
				}
			} while (iReadCount > 0);

			return buffer.toString();
		} catch (Exception err) {
			return "";
		} finally {
			try {
				if (reader != null) {
					reader.close();
				}
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
	}

    public static String getFileText(InputStream is) {
        InputStreamReader reader = null;

        try {
            reader = new InputStreamReader(is);

            StringBuffer buffer = new StringBuffer();
            int iReadCount = 0;
            char[] temp = new char[1024];

            do {
                iReadCount = reader.read(temp);
                if (iReadCount > 0) {
                    buffer.append(new String(temp, 0, iReadCount));
                }
            } while (iReadCount > 0);

            return buffer.toString();
        } catch (Exception err) {
            return "";
        } finally {
            try {
                if (reader != null) {
                    reader.close();
                }
            } catch (Exception err) {
                err.printStackTrace();
            }
        }
    }

	public static String getFileText(String strFileName, String strEncoding) {
		try {
			return getFileByteStream(strFileName).toString(strEncoding);
		} catch (Exception err) {
			return "";
		}
	}

	public static byte[] getFileBytes(String strFileName) {
		return getFileByteStream(strFileName).toByteArray();
	}

	public static ByteArrayOutputStream getFileByteStream(String strFileName) {
		ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
		FileInputStream file = null;

		try {
			file = new FileInputStream(strFileName);
			int iReadCount = 0;
			byte[] temp = new byte[1024];

			do {
				iReadCount = file.read(temp);
				if (iReadCount > 0) {
					buffer.write(temp, 0, iReadCount);
				}
			} while (iReadCount > 0);

		} catch (Exception err) {
			err.printStackTrace();
		} finally {
			try {
				if (file != null) {
					file.close();
				}
			} catch (Exception err) {
				err.printStackTrace();
			}
		}

		return buffer;
	}

	public static String getClassPathResource(String resource) {
		ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
		InputStream is = null;
		try {
			is = new ClassPathResource(resource).getInputStream();
			int iReadCount = 0;
			byte[] temp = new byte[1024];
			do {
				iReadCount = is.read(temp);
				if (iReadCount > 0) {
					buffer.write(temp, 0, iReadCount);
				}
			} while (iReadCount > 0);
			
			return buffer.toString();
		} catch (Exception err) {
		} finally {
			try {
				if (is != null) {
					is.close();
				}
			} catch (Exception err) {
			}
		}
		return null;
	}
	

	public static boolean writeFileText(String strFileName, String strContent,
										boolean isAppend) {
		FileWriter writer = null;

		try {
			writer = new FileWriter(strFileName, isAppend);
			writer.write(strContent);
			writer.flush();

			return true;
		} catch (Exception err) {
			err.printStackTrace();
			return false;
		} finally {
			try {
				if (writer != null) {
					writer.close();
				}
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
	}

	public static boolean writeFileText(String strFileName, String strContent) {
		return writeFileText(strFileName, strContent, false);
	}

	public static boolean appendFileText(String strFileName, String strContent) {
		return writeFileText(strFileName, strContent, true);
	}

	public static boolean writeFileText(String strFileName, String strContent,
										String strEncoding, boolean isAppend) {
		OutputStreamWriter writer = null;

		try {
			FileOutputStream stream = new FileOutputStream(strFileName,
					isAppend);

			writer = new OutputStreamWriter(stream, strEncoding);
			writer.write(strContent);
			writer.flush();

			return true;
		} catch (Exception err) {
			return false;
		} finally {
			try {
				if (writer != null) {
					writer.close();
				}
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
	}

	public static boolean writeFileText(String strFileName, String strContent,
										String strEncoding) {
		return writeFileText(strFileName, strContent, strEncoding, false);
	}

	public static boolean appendFileText(String strFileName, String strContent,
										 String strEncoding) {
		return writeFileText(strFileName, strContent, strEncoding, true);
	}

	public static boolean writeFileBytes(String strFileName, byte[] content,
										 boolean isAppend) {
		FileOutputStream writer = null;

		try {
			writer = new FileOutputStream(strFileName, isAppend);
			writer.write(content);
			writer.flush();

			return true;
		} catch (Exception err) {
			return false;
		} finally {
			try {
				if (writer != null) {
					writer.close();
				}
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
	}

	public static boolean writeFileBytes(String strFileName, byte[] content) {
		return writeFileBytes(strFileName, content, false);
	}

	public static boolean appendFileBytes(String strFileName, byte[] content) {
		return writeFileBytes(strFileName, content, true);
	}

	public static boolean deleteFile(String strFileName) {
		try {
			File file = new File(strFileName);
			return file.delete();
		} catch (Exception err) {
			return false;
		}
	}

	public static boolean deleteFile(String strFileName, String strNewFileName) {
		try {
			File file = new File(strFileName);
			File newFile = new File(strNewFileName);
			return file.renameTo(newFile);
		} catch (Exception err) {
			return false;
		}
	}

	public static boolean copyFile(String strFileName, String strDestFileName) {
		return writeFileBytes(strDestFileName, getFileBytes(strFileName));
	}

	public static boolean creatDir(String strDirName) {
		try {
			File file = new File(strDirName);
			if (file.exists() && file.isDirectory()) {
				return true;
			}
			return file.mkdir();
		} catch (Exception err) {
			return false;
		}
	}
	
	public static boolean creatDirs(String strDirName) {
		try {
			File file = new File(strDirName);
			if (file.exists() && file.isDirectory()) {
				return true;
			}
			return file.mkdirs();
		} catch (Exception err) {
			return false;
		}
	}	
	
	public static boolean creatDirNews(String strDirName) {
		try {
			File file = new File(strDirName);
			if (file.exists() && file.isDirectory()) {
				return true;
			}
			return file.mkdirs();
		} catch (Exception err) {
			return false;
		}
	}

	public static String[] getChildren(String strDirName) {
		try {
			File file = new File(strDirName);
			if (!(file.exists() && file.isDirectory())) {
				return null;
			}
			return file.list();
		} catch (Exception err) {
			return null;
		}
	}
	
  
    public static boolean deleteFolder(String sPath)
    {  
        boolean flag = false;  
        File file = new File(sPath);
        if (!file.exists()) 
        {  
            return flag;  
        } else {   
            if (file.isFile()) 
            {  
                return deleteFile(sPath);  
            } else {  
                return deleteDirectory(sPath);  
            }  
        }
    }
 
    public static boolean deleteDirectory(String sPath) {
        if (!sPath.endsWith(File.separator)) {
            sPath = sPath + File.separator;
        }
        File dirFile = new File(sPath);
        if (!dirFile.exists() || !dirFile.isDirectory()) {  
            return false;  
        }  
        boolean flag = true;  
        File[] files = dirFile.listFiles();
        for (int i = 0; i < files.length; i++) 
        {  
            if (files[i].isFile()) {  
                flag = deleteFile(files[i].getAbsolutePath());  
                if (!flag) break;  
            }
            else {  
                flag = deleteDirectory(files[i].getAbsolutePath());  
                if (!flag) break;  
            }  
        }
        if (!flag) return false;    
        if (dirFile.delete()) {  
            return true;  
        } else {  
            return false;  
        }  
    }
    
    public static long getFileSizes(File f)
    {
        long s=0;
        try
        {
	        if (f.exists())
	        {
	            FileInputStream fis = null;
	            fis = new FileInputStream(f);
	            s= fis.available();
	            fis.close();
	        }
        } catch(Exception e)
        {
        	e.printStackTrace();
        }
        return s;
    }
    
    /**
     * 
     * @param response
     * @param filePath 下载文件相对路径
     * @param realName 下载文件真实文件名
     */
    public static void downloadFile(HttpServletResponse response, String filePath, String realName){
    	if(Utility.isEmpty(realName)){
    		// 如果没有传真实文件名，则根据路径去获取
    		if(!Utility.isEmpty(filePath) && filePath.indexOf("/") >= 0){
    			realName = filePath.substring(filePath.lastIndexOf("/") + 1);
    		} else {
    			realName = filePath;
    		}
    	}
    	try{
    		response.setHeader("content-disposition", "attachment;filename=" + new String(realName.getBytes("gb2312"), "iso8859-1"));
        	Config config = new Config();
        	String uploadFilePath = config.getValue("upload.root.path");
        	FileInputStream fi = new FileInputStream(filePath);
        	OutputStream os = response.getOutputStream();
        	byte[] buffer = new byte[1024];
        	int len = 0;
        	while((len = fi.read(buffer)) > 0){
        		os.write(buffer, 0, len);
        	}
        	fi.close();
        	os.close();
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    }
    
    public static boolean exists(String strFileName) {
    	File file = new File(strFileName);
    	return file.exists();
    }

	/**
	 * 移动文件
	 * @param sourcePath		源文件
	 * @param targetDir		目标路径
	 * @param newName			新文件名
     * @return
     */
	public static boolean moveFile(String sourcePath,String targetDir,String newName,boolean isReplace) throws IOException {
		// 创建新文件
		File source = new File(sourcePath);
		File dest =  new File(targetDir+newName);
		if(dest.exists()&& !Boolean.valueOf(isReplace)){
				return true;
		}else{
			InputStream input=null;
			OutputStream output = null;
			try{
				input = new FileInputStream(source);
				output =new FileOutputStream(dest);
				byte[] buf = new byte[1024];
				int bytesRead;
				while((bytesRead=input.read(buf))>0){
					output.write(buf,0,bytesRead);
				}
			}finally{
				input.close();
				output.close();
			}
		}
		return true;
	}
    
}
