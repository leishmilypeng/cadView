package com.lp.utils;

import com.lp.entity.CadInfo;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class Constants {


    public static Map<String,CadInfo> fileListMap = new ConcurrentHashMap<>();

    public static final String IS_ADMIN = "isAdmin";

    public  static String DEFAULT_PATH =null;
}