package com.lp.utils;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import java.sql.Timestamp;

public class TimeWebBindingInitializer implements WebBindingInitializer {
	@Override
	public void initBinder(WebDataBinder binder, WebRequest request) {
		binder.registerCustomEditor(Timestamp.class, new TimeStampEditor());
	}
}
