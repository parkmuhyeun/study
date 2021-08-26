package com.hong.hakwon.common;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter{

	private Log	logger	= LogFactory.getLog(this.getClass());
	
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("===========================          START         ===========================");
		logger.info(" Request URI \t:  " + request.getRequestURI());
		//logger.info(" Request URL \t:  " + request.getRequestURL().toString());
		    Enumeration<String> paramNames = request.getParameterNames();
		    while (paramNames.hasMoreElements()) {
		      String key = (String) paramNames.nextElement();
		      String value = request.getParameter(key);
		      logger.info(" RequestParameter Data ==>  " + key + " : " + value + "");
		    }
		       
		String	uri	= request.getRequestURI();
		//String	url	= request.getRequestURL().toString();
		
		//this.setPathInfo(request);
		
		if (null == uri) {
			return super.preHandle(request, response, handler);
		}
		
		
		return super.preHandle(request, response, handler);

	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
}
