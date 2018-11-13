package com.lp.utils;

import com.lp.entity.CadInfo;

import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;

public class Constants {


    public static Map<String,CadInfo> fileListMap = new ConcurrentHashMap<>();

    public static final String IS_ADMIN = "isAdmin";

    public  static String DEFAULT_PATH =null;

    public static Queue queueList = new ConcurrentLinkedQueue();
}