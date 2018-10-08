package com.lp.utils;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * 字母数字组合自增长
 * 
 */
public class AutoIncrement {

	public static String autoIncrement(String id, Integer length) {
		try{
			Long _id = Long.valueOf(id)+1;
			String result = String.valueOf(_id);
			if (result.length() > length) {
				throw new RuntimeException("长度超过限制");
			}
			return result;
		} catch(Exception e){}
		
		AutoIncrement tes = new AutoIncrement();
		if (StringUtils.isNotBlank(id)) {
			if (MatcherUtils.isChineseCharacter(id)) {
				id = "ZA01";//
			}
			String result = tes.addone(id.toLowerCase());
			if (result.length() > length) {
				throw new RuntimeException("长度超过限制");
			}
			return result.toUpperCase();
		}
		return "01";
	}
	

	public String addone(String strings) {
		int length = strings.length();
		char[] c = new char[length];
		boolean ifzzzz = true;// 表示全部为zzzz的字符串
		for (int i = 0; i < length; i++) {
			char tmp = strings.charAt(i);
			if (tmp != "z".charAt(0)) {
				ifzzzz = false;
			}
			c[i] = tmp;

		}
		if (ifzzzz) {
			strings = "1" + strings.replace("z", "0");
			return strings;
		}
		boolean carry = true;// 标识是否有进位
		int p = length;
		while (carry) {
			p--;
			char added = this.addone(c[p]);
			if (added == "0".charAt(0)) {
				c[p] = added;
				carry = true;
			} else {
				c[p] = added;
				carry = false;
			}
		}
		strings = new String(c);
		return strings;
	}

	public char addone(char chars) {
		if ((chars < 123 && 96 < chars) || (47 < chars && chars < 58)) {
			if (chars == 122) {
				chars = 48;
			} else if (chars == 57) {
				chars += 40;
			} else {
				chars++;
			}
		} else {
		}
		return chars;
	}

	public String addoneletters(String strings) {
		int length = strings.length();
		char[] c = new char[length];
		boolean ifzzzz = true;// 表示全部为zzzz的字符串
		for (int i = 0; i < length; i++) {
			char tmp = strings.charAt(i);
			if (tmp != "z".charAt(0)) {
				ifzzzz = false;
			}
			c[i] = tmp;

		}
		if (ifzzzz) {
			strings = "a" + strings.replace("z", "a");
			return strings;
		}
		boolean carry = true;// 标识是否有进位
		int p = length;
		while (carry) {
			p--;
			char added = this.addoneletters(c[p]);
			if (added == "a".charAt(0)) {
				c[p] = added;
				carry = true;
			} else {
				c[p] = added;
				carry = false;
			}
		}
		strings = new String(c);
		return strings;
	}

	public char addoneletters(char chars) {
		if ((chars < 123 && 95 < chars) || (47 < chars && chars < 58)) {
			if (chars == 122) {
				chars = 97;
			} else {
				chars++;
			}
		} else {
		}
		return chars;
	}
	
	/**
	 * 用于特定的code          
	 * @param prefix	
	 * @param currentCode   001  传入的code,如果字符中包含A~Z的字符，那么这些必须是高位的大于或等于低位，绝对不能有低位大于高位的字符穿入，否则生成有误（按照ASCII大小比较）
	 * @return
	 */
	public static String genarateSpecialCode(String prefix,String currentCode){
		//拆分currentCode为三部分，前缀，字母，数字
		return prefix + AutoIncrement.carryOverUpper(currentCode);
	}
	
	/**
	 * 向高位进位，依次生成下一个序列     000->999->A00->Z00->Z99->ZA0
	 * 进位规律 0->9->A->Z,Z属于最大位
	 * @param chars
	 * @return
	 */
	public static String carryOverUpper(String chars){
		if(StringUtils.isEmpty(chars)){
			return "";
		}
		
		char [] source = chars.toUpperCase().toCharArray();
		
		int len=chars.length();
		int topIndex = 0;
		for(char c : source){
			if(c=='Z'){
				topIndex++;
			}
		}
		if(len==topIndex){
			//万物归0
			for(int j=0;j<len;j++){
				source[j]='0';
			}
			return new String(source);
		}
		
		char[] targe = new char[len] ;
		//进位标志
		int [] arryFlag = new int[len];
		for(int i=0;i<len;i++){
			if(i==0){
				arryFlag[i]=1;
			}else{
				arryFlag[i]=0;
			}
		}
		
		int index = 0;
		for(int i=len-1;i>=0;i--){
			targe[index] = source[i];
			index++;
		}
		
		for(int i=0;i<len;i++){
			int flag = arryFlag[i];
			char currChar = targe[i];
			
			char newChar = (char)(currChar + flag);
			if(newChar>='0'&&newChar<='9'){
				targe[i] = newChar;
			}else if(newChar>'9'&&(newChar<'A'||newChar>'Z')){
				//此时要判断是否需要进位
				if(i+1==len){
					if(newChar>'9'){
						targe[i] = 'A';
					}
					if(newChar>'Z'){
						targe[i] = 'Z';
						targe[i-1] = 'A';
					}					
				}else{
					if(targe[i+1]=='Z'){
						targe[i] = 'A';
					}else{
						arryFlag[i+1]=1;				
						targe[i] = '0';
					}
				}
			}else if(newChar>='A'&&newChar<'Z'){
				targe[i] = newChar;
			}else{
				targe[i] = newChar;			
			}
		}
		
		String rtnStr = new String(targe);
		StringBuilder sb = new StringBuilder(rtnStr);
		
		String generateCode = sb.reverse().toString();
		System.out.println(generateCode);
		return generateCode;		
	}
	

	
	public static void main(String arg[]) {
		AutoIncrement tes = new AutoIncrement();
		// String n="9999";
		// for(;n.length()<5;n=tes.addone(n)){
		// System.out.println(n+"");
		// }
		String str = "000";
		for(int i=0;i<10000;i++){
			str = tes.carryOverUpper(str);
			if("0000".equals(str)){
				System.out.println(i);
				break;
			}				
		}
		//System.out.println(tes.genarateSpecialCode("E", "0001"));
	}
}