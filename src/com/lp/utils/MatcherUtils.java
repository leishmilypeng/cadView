package com.lp.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 常用正则表达式或类型判断类
 * 
 * @author CPR116
 *
 */
public class MatcherUtils {
	// 判断是否包含中文
	public static boolean isChineseCharacter(String chineseStr) {
		char[] charArray = chineseStr.toCharArray();
		for (int i = 0; i < charArray.length; i++) {
			if ((charArray[i] >= 0x4e00) && (charArray[i] <= 0x9fbb)) {
				return true;
			}
		}
		return false;
	}
	
	// 判断是否为数字字母及空格
	public static boolean isLetterOrNumberOrSpace(String str) {
		String rexp = "^[0-9a-zA-Z\\s?]+$";
		Pattern pat = Pattern.compile(rexp);
		Matcher mat = pat.matcher(str);
		return mat.matches();
	}
	
	// 判断是否为数字字母空格及特殊字符 (特殊字符包含- * + ( ) . / # ?)
		public static boolean isLetterOrNumberOrSpaceOrSpecial(String str) {
			String rexp = "^[0-9a-zA-Z\\-\\*\\+\\(\\)\\.\\/\\#\\?\\s?]+$";
			Pattern pat = Pattern.compile(rexp);
			Matcher mat = pat.matcher(str);
			return mat.matches();
		}
	
	
	
	// 判断是否为数字和字母
	public static boolean isLetterOrNumber(String str) {
		String rexp = "^[A-Za-z0-9]+$";
		Pattern pat = Pattern.compile(rexp);
		Matcher mat = pat.matcher(str);
		return mat.matches();
	}
	
	/**
	 * 判断数字是否超过长度
	 * @param num 数字字符串
	 * @param integer 整数部分长度
	 * @param decimal 小数部分长度
	 * @return
	 */
	public static boolean numberInRange(String num, int integer, int decimal) {
		if (num.contains(".")) {
			String[] numArr = num.split("\\.");
			if (numArr[0].length() > integer || numArr[1].length() > decimal) {
				return false;
			} else {
				return false;
			}
		} else {
			if (num.length() > integer) {
				return false;
			} else {
				return true;
			}
		}
	}
	
	// 判断是否为特殊字符
	public static boolean isSpecial(String str) {
		String rexp = "^([\\u4e00-\\u9fa5]+|[a-zA-Z0-9]+)$";
		Pattern pat = Pattern.compile(rexp);
		Matcher mat = pat.matcher(str);
		return mat.matches();
	}
	
	// 判断是否为数字
	public static boolean isNumber(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	/**
	 * 判斷是否是时间戳格式  "2015-05-05 23:59:59.000"
	 */
	public static boolean isTimestamp(String date) {
		String rexp = "^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8])))))\\s(((0?[1-9])|(1[0-9])|(2[0-3]))\\:([0-5][0-9])((\\s)|(\\:([0-5][0-9]))))(\\.([0-9]{0,3})))?$";

		Pattern pat = Pattern.compile(rexp);

		Matcher mat = pat.matcher(date);

		boolean dateType = mat.matches();

		return dateType;
	}

	public static void main(String[] args) {
		System.out.println(isTimestamp("2015-08-27 08:58:55.999"));
	}
}
