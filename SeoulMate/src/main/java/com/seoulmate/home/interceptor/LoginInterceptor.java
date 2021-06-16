package com.seoulmate.home.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		String userid = (String)req.getSession().getAttribute("logId");
		
		if(userid==null || userid.equals("")) {
			if(ajaxRequest(req)) {
				res.sendError(1000);
			}else {
				res.sendRedirect(req.getContextPath()+"/login");
			}
			return false;
		}else {
			return true;
		}
	}
	public void postHandle(HttpServletRequest rep, HttpServletResponse res, Object handler, 
			@Nullable ModelAndView modelAndView) throws Exception {
		
	}
	public void afterCompletion(HttpServletRequest req, HttpServletResponse res, Object handler, 
			@Nullable Exception ex) throws Exception{
		
	}
	private boolean ajaxRequest(HttpServletRequest req) {
		String header = req.getHeader("AJAX");
		if("true".equals(header)) {
			return true;
		}else {
			return false;
		}
	}
}
