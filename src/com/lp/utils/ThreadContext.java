package com.lp.utils;

import javax.persistence.EntityManager;

public class ThreadContext {
    Object object;
    EntityManager manager;
	boolean isWrite;
	
	public ThreadContext()
    {
		manager = null;
    	isWrite = false;
    }
	
    public EntityManager getManager() {
		return manager;
	}

	public void setManager(EntityManager manager) {
		this.manager = manager;
	}

	public boolean isWrite() {
		return isWrite;
	}

	public void setWrite(boolean isWrite) {
		this.isWrite = isWrite;
	}

	public Object getObject() {
        return object;
    }
    
    public void setObject(Object object) {
        this.object = object;
    }
    
    
    

}
