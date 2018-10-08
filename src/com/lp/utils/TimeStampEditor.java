package com.lp.utils;

import java.beans.PropertyEditorSupport;
import java.sql.Timestamp;

public class TimeStampEditor extends PropertyEditorSupport {
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		Timestamp timestamp = null;
		if(!Utility.isEmpty(text)){
			try {
				if(text.length() > 10){
					timestamp = DateUtil.stringToTimestamp(text, "yyyy-MM-dd HH:mm:ss");
				} else {
					timestamp =  DateUtil.stringToTimestamp(text, "yyyy-MM-dd");
				}
			} catch (Exception e) {
				timestamp =  DateUtil.stringToTimestamp(text, "yyyy-MM-dd");
			}
		}
		setValue(timestamp);
	}
}
