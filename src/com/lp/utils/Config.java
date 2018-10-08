
package com.lp.utils;

import org.apache.commons.configuration.PropertiesConfiguration;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;


public class Config {
    private Hashtable ht = new Hashtable();
    private static PropertiesConfiguration config = null;
    static {
        try {
            config = new PropertiesConfiguration("config.properties");
        } catch (Exception e) {
        }
    }
    public Config()
    {
        _Config("config");
    }

    public Config(String configName)
    {
        _Config(configName);
    }

    private void _Config(String configFileName)
    {
        try {
            ResourceBundle resources = ResourceBundle.getBundle(configFileName, Locale.getDefault());
            Enumeration enumeration = resources.getKeys();
            while (enumeration.hasMoreElements()) {
                String key = (String)enumeration.nextElement();
                String value = resources.getString(key).trim();
                ht.put(key, value);
            }
        } catch (MissingResourceException e) {
            e.printStackTrace();
            throw e;
        } catch (NullPointerException e) {
            e.printStackTrace();
            throw e;
        }
    }


    public String getValue(String key)
    {
        return (String)ht.get(key);
    }

    public Object getObject(String key) {
        return ht.get(key);
    }

    public Hashtable getConfig()
    {
        return ht;
    }
    
    public static String getString(String key) {
    	if(config.containsKey(key)){
    		return config.getString(key);
    	}
        return null;
    }
    
    public static boolean getBoolean(String key) {
    	if(config.containsKey(key)){
    		return config.getBoolean(key);
    	}
    	return false;
        
    }
    
    public static boolean constainsKey(String key){
    	return config.containsKey(key);
    }
    
    public static void main(String[] args)
    {
    }
}
