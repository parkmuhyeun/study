
package com.hong.hakwon;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.channels.FileChannel;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hong.hakwon.dto.UserSaveDto;
import com.hong.hakwon.web.validation.RegisterValidator;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.hong.hakwon.common.CmMap;
import com.hong.hakwon.Beans.UserBean;
import com.hong.hakwon.UserDAOImpl;
import com.google.gson.Gson;
import com.google.gson.JsonObject;



/**
 * @author Seok-Hoon, Hong
 * @version 1.0
 * @lastEdit 2017. 9. 19
 */
@Controller
@SuppressWarnings("rawtypes")
public class MainController {
	
	private UserDAOImpl uService;
	
	private Log	logger	= LogFactory.getLog(this.getClass());
	
	private RegisterValidator registerValidator;

	@Autowired
	public MainController(UserDAOImpl uService, RegisterValidator registerValidator) {
		this.uService = uService;
		this.registerValidator = registerValidator;
	}


	/*
	 * 회원가입 페이지
	 */
	@RequestMapping(value="/join")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView("/join");
		mav.addObject("userSaveDto", new UserSaveDto());
		return mav;
	}

	/*
	 * 비밀번호 실시간 유효성
	 */
	@RequestMapping(value ="/join/pwCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean PwCheck(@RequestParam("password") String password) {

		boolean check =false;

		String pw_chk = "^[a-zA-Z0-9~!@#$%^&*()_+|<>?:{}]*$";

		Pattern passP = Pattern.compile(pw_chk);

		if(password.length() >= 8 && password.length() <= 15){
			Matcher matcher = passP.matcher(password);
			if(matcher.matches()){
				check = true;
			}
		}

		return check;
	}

	/*
	 * 회원가입 요청
	 */
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public ModelAndView join(@ModelAttribute UserSaveDto userSaveDto, BindingResult bindingResult) {
		registerValidator.validate(userSaveDto, bindingResult);

		if (bindingResult.hasErrors()) {
			ModelAndView mav = new ModelAndView("/join");
			return mav;
		}

		ModelAndView mav = new ModelAndView("/main");
		return mav;
	}

	/*
	 * 로그인 페이지
	 */
	@RequestMapping(value="/login")
	public ModelAndView login( @ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView	mav	= new ModelAndView("/login");
		return mav;
	}
	
	@RequestMapping(value = "/login_process",produces = "application/json") 
	@ResponseBody
	public CmMap login_process(@RequestBody CmMap reqVo, HttpServletRequest request, HttpServletResponse response) throws Exception{ 
		logger.info("reqVo : " + reqVo);
		return reqVo;
	}
	
	/*
	 * 메인 페이지
	 */
	@RequestMapping(value="/main")
	public ModelAndView main(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView	mav	= new ModelAndView("/main");
		mav.addObject("data", "데이터");
		return mav;
	}
	
	
//	@RequestMapping(value ="/getSido")
//	@ResponseBody
//	public List<CmMap> getSido(@RequestBody CmMap reqVo, HttpServletRequest request, HttpServletResponse response) throws Exception{
//		List<CmMap> rtnList = uService.get_sido();
//		return rtnList;
//	}
//	
//	@RequestMapping(value ="/getSigungu")
//	@ResponseBody
//	public JSONArray getSigungu(@RequestBody CmMap reqVo, HttpServletRequest request, HttpServletResponse response) throws Exception{
//		
//		List<CmMap> result = uService.get_sido();
//		
//		JSONArray jsonArray = new JSONArray();
//
//		for (Map<String, Object> map : result) {
//			jsonArray.add(convertMapToJson(map));
//		}
//		
//		return jsonArray;
//	}
	
	
	 
	
//	/*
//	 * 학생 관리 페이지
//	 */
//	@RequestMapping(value="/mng_stdt")
//	public ModelAndView mng_stdt(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		ModelAndView	mav	= new ModelAndView("/mng_stdt");
//		
//		try {
//			
//			String stlv = (String) session.getAttribute("s_tlv");
//			if(!stlv.isEmpty() && stlv.equals("1")){//관리자
////				mav.addObject("sList",sService.get_list_mst());//학생 목록
//				
//				
//			}else{//일반 (본인것만불러온다)
////				mav.addObject("sList",sService.get_list((String)session.getAttribute("s_tcd")));//학생 목록
////				mav.addObject("cList",cService.get_list((String)session.getAttribute("s_tcd")));//학급 목록
//			}
//			
//			mav.addObject("tList",tService.get_list());//선생님 목록
//			
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "학생 목록을 불러오는중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return mav;
//	}
//	
//	/*
//	 * 선생님 관리 페이지 (mst)
//	 */
//	@RequestMapping(value="/mng_teacher")
//	public ModelAndView mng_teacher(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		ModelAndView	mav	= new ModelAndView("/mng_teacher");
//		
//		try {
//			
//			mav.addObject("tList",tService.get_list());//선생님 목록
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "선생님 목록을 불러오는중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return mav;
//	}
//	
//	/*
//	 * 학급 관리 페이지 (mst)
//	 */
//	@RequestMapping(value="/mng_class")
//	public ModelAndView mng_class(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		ModelAndView	mav	= new ModelAndView("/mng_class");
//		
//		try {
//			mav.addObject("cList",	cService.get_list_mst());//학급 전체 목록
//			mav.addObject("tList",	tService.get_list());//선생님 목록
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "학급 전체 목록을 불러오는중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return mav;
//	}
//
//	/*
//	 * 학생 등록(save)
//	 */
//	@RequestMapping(value="/reg_stdt")
//	public ModelAndView reg_stdt(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//			
//			UserBean sb = new UserBean();
//			
//			String v_sname = request.getParameter("v_sname");
//			String v_sschool = request.getParameter("v_sschool");
//			String v_sgrade = request.getParameter("v_sgrade");
//			String v_scontact = request.getParameter("v_scontact");
//			String v_tcd = request.getParameter("v_tcd");
//			String v_tname = request.getParameter("v_tname");
//			String v_ccd = request.getParameter("v_ccd");
//			String v_cname = request.getParameter("v_cname");
//			
////			String s_cd = "scd"+String.format("%05d", this.sService.get_cnt());
//			
////			sb.setV_scd(s_cd);
////			sb.setV_sname(v_sname);
////			sb.setV_tcd(v_tcd);
////			sb.setV_tname(v_tname);
////			sb.setV_ccd(v_ccd);
////			sb.setV_cname(v_cname);
////			sb.setV_sschool(v_sschool);
////			sb.setV_sgrade(v_sgrade);
////			sb.setV_scontact(v_scontact);
//			
////			this.sService.reg_student(sb);
//			
//			response.sendRedirect("mng_stdt");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "학생 등록중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return null;
//	}
//	
//	
//	/*
//	 * 학생 수정(mod)
//	 */
//	@RequestMapping(value="/mod_stdt")
//	public ModelAndView mod_stdt(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//			
//			UserBean sb = new UserBean();
//			
//			String v_sname = request.getParameter("v_sname");
//			String v_sschool = request.getParameter("v_sschool");
//			String v_sgrade = request.getParameter("v_sgrade");
//			String v_scontact = request.getParameter("v_scontact");
//			String v_tcd = request.getParameter("v_tcd");
//			String v_tname = request.getParameter("v_tname");
//			String v_ccd = request.getParameter("v_ccd");
//			String v_cname = request.getParameter("v_cname");
//			String v_scd = request.getParameter("v_scd");
//			String v_flag_del = request.getParameter("v_flag_del");
//			
////			sb.setV_scd(v_scd);
////			sb.setV_sname(v_sname);
////			sb.setV_tcd(v_tcd);
////			sb.setV_tname(v_tname);
////			sb.setV_ccd(v_ccd);
////			sb.setV_cname(v_cname);
////			sb.setV_sschool(v_sschool);
////			sb.setV_sgrade(v_sgrade);
////			sb.setV_scontact(v_scontact);
////			sb.setV_flag_del(v_flag_del);
////			this.sService.update_info(sb);
//			
//			response.sendRedirect("mng_stdt");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "학생 수정중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return null;
//	}
//	
//	
//	/*
//	 * 선생님 등록(save)
//	 */
//	@RequestMapping(value="/reg_teacher")
//	public ModelAndView reg_teacher(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//
//			TeacherBean tb = new TeacherBean();
//			
//			String t_id = request.getParameter("id");
//			String t_pw = request.getParameter("pw");
//			String t_name = request.getParameter("name");
//			String t_lv = request.getParameter("level");
//			
//			String t_cd = "tcd"+String.format("%05d", this.tService.get_cnt());
//			
//			tb.setV_tid(t_id);
//			tb.setV_tpassword(t_pw);
//			tb.setV_tname(t_name);
//			tb.setV_tlevel(t_lv);
//			tb.setV_tcd(t_cd);
//			
//			this.tService.reg_teacher(tb);
//			
//			logger.info(" == 선생님 등록 정보 == ");
//			logger.info("코드 : "+t_cd+"/ 이름 : "+t_name + "/ ID : " + t_id + "/ PW : " + t_pw + "/ 등급 : "+ t_lv);
//			
//			response.sendRedirect("mng_teacher");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "선생님 등록중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return null;
//	}
//	
//	/*
//	 * 선생님 수정(mod)
//	 */
//	@RequestMapping(value="/mod_teacher")
//	public ModelAndView mod_teacher(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//
//			TeacherBean tb = new TeacherBean();
//			
//			String t_cd = request.getParameter("v_tcd");
//			String t_id = request.getParameter("v_tid");
//			String t_pw = request.getParameter("v_tpassword");
//			String t_name = request.getParameter("v_tname");
//			String t_lv = request.getParameter("t_lv");
//			String t_flag_del = request.getParameter("t_flag_del");
//			
//			tb.setV_tcd(t_cd);
//			tb.setV_tid(t_id);
//			tb.setV_tpassword(t_pw);
//			tb.setV_tname(t_name);
//			tb.setV_tlevel(t_lv);
//			tb.setV_flag_del(t_flag_del);
//			
//			this.tService.update_info(tb);
//			
//			logger.info(" == 선생님 수정 정보 == ");
//			logger.info("코드 : "+t_cd+"/ 이름 : "+t_name + "/ ID : " + t_id + "/ PW : " + t_pw + "/ 등급 : "+ t_lv+"/ 삭제여부 : "+t_flag_del);
//			
//			response.sendRedirect("mng_teacher");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "선생님 수정중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return null;
//	}
//	
//	/*
//	 * 학급 등록(save)
//	 */
//	@RequestMapping(value="/reg_class")
//	public ModelAndView reg_class(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//
//			ClassBean cb = new ClassBean();
//			
//			String c_name = request.getParameter("v_cname");
//			String t_cd = request.getParameter("v_tcd");
//			String t_name = request.getParameter("v_tname");
//			
//			String c_cd = "ccd"+String.format("%05d", this.cService.get_cnt());
//
//			cb.setV_ccd(c_cd);
//			cb.setV_cname(c_name);
//			cb.setV_tcd(t_cd);
//			cb.setV_tname(t_name);
//			
//			this.cService.reg_class(cb);
//			
//			logger.info(" == 학급 등록 정보 == ");
//			logger.info("코드 : "+c_cd+"/ 학급 이름 : "+c_name + "/ 담당선생님 코드 : " + t_cd + "/ 담당선생님 이름  : " + t_name);
//			
//			response.sendRedirect("mng_class");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "학급 등록중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return null;
//	}
//	
//	/*
//	 * 학급 수정(mod)
//	 */
//	@RequestMapping(value="/mod_class")
//	public ModelAndView mod_class(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//
//			ClassBean cb = new ClassBean();
//			
//			String c_name = request.getParameter("v_cname");
//			String t_cd = request.getParameter("v_tcd");
//			String t_name = request.getParameter("v_tname");
//			String c_cd = request.getParameter("v_ccd");
//			String v_flag_del	= request.getParameter("v_flag_del");
//			
//			cb.setV_ccd(c_cd);
//			cb.setV_cname(c_name);
//			cb.setV_tcd(t_cd);
//			cb.setV_tname(t_name);
//			cb.setV_flag_del(v_flag_del);
//			
//			this.cService.update_class(cb);
//			
//			logger.info(" == 학급 수정 정보 == ");
//			logger.info("코드 : "+c_cd+"/ 학급 이름 : "+c_name + "/ 담당선생님 코드 : " + t_cd + "/ 담당선생님 이름  : " + t_name+"/ 삭제여부 : "+v_flag_del);
//			
//			response.sendRedirect("mng_class");
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "학급 수정중 에러가 발생했습니다.");
//			return view;
//		}
//		
//		return null;
//	}
//	
//	/*
//	 * 로그인 체크(set session)
//	 */
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value="/chk_login")
//	public ModelAndView chk_login(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//			Map idpw = new HashMap();
//			idpw.put("id", request.getParameter("id"));
//			idpw.put("pw", request.getParameter("pw")); 
//			
//			if(tService.chk_login(idpw) < 1){
//				response.sendRedirect("login");
//			}
//			else{
//				
//				String s_tcd = tService.get_info(request.getParameter("id")).getV_tcd();
//				String s_tid = tService.get_info(request.getParameter("id")).getV_tid();
//				String s_tname = tService.get_info(request.getParameter("id")).getV_tname();
//				String s_tlv = tService.get_info(request.getParameter("id")).getV_tlevel();
//				
//				session.setAttribute("s_tcd", s_tcd);
//				session.setAttribute("s_tid", s_tid);
//				session.setAttribute("s_tname", s_tname);
//				session.setAttribute("s_tlv", s_tlv);
//				
//				response.sendRedirect("main");
//				logger.info("Login succ : "+s_tid + "(" + s_tname + ")");
//			}
//			
//		} catch (Exception e1) {
//			e1.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "로그인 처리중 에러가 발생했습니다.");
//			logger.info("Login fail : "+request.getParameter("id") +  " / "+ request.getParameter("pw"));
//			return view;
//		}
//		return null;
//	}
//	
//	/*
//	 * 로그아웃 (remove session)
//	 */
//	@RequestMapping(value="/logout")
//	public ModelAndView logout(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		
//		try {
//			
//				String userid = (String) session.getAttribute("s_tid");
//			
//				session.removeAttribute("s_tcd");
//				session.removeAttribute("s_tid");
//				session.removeAttribute("s_tname");
//				session.removeAttribute("s_tlv");
//				
//				response.sendRedirect("login");
//			
//				logger.info("Logout succ : "+userid);
//				
//		} catch (Exception e1) {
//			e1.printStackTrace();
//			ModelAndView view = new ModelAndView("err/other_err");
//			view.addObject("msg", "로그아웃 처리중 에러가 발생했습니다.");
//			return view;
//		}
//		return null;
//	}
//		
//		@RequestMapping(value="/edit_answer")
//		public ModelAndView edit_answer(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/edit_answer");
//			try {
//			
//			String v_bcd = request.getParameter("v_bcd");
//			String unitCnt = request.getParameter("v_unit_cnt");
//			
//			mav.addObject("v_bcd", v_bcd);
//			mav.addObject("unitCnt", unitCnt);
//			mav.addObject( "bookList" , bService.get_book(v_bcd) );
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "실제 파일과 DB상의 파일이 불일치 할 수도 있습니다. 제작자에게 문의해주세요.");
//				return view;
//			}
//			return mav;
//		}
//		
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/view_answer")
//		public ModelAndView view_answer(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/view_answer");
//			try {
//			
//			String v_bcd = request.getParameter("v_bcd");
//			String unitCnt = request.getParameter("v_unit_cnt");
//			String unit = request.getParameter("v_unit");
//			
//			if( unit != null){
//				
//				System.out.println("몇과냐 : "+unit);
//				
//				Map bb = new HashMap();
//				
//				bb.put("bcd", v_bcd);
//				bb.put("unit", unit);
//				
//				mav.addObject( "qaList" , qService.get_q_list(bb) );
//			}
//			
//			
//			mav.addObject("v_bcd", v_bcd);
//			mav.addObject("unitCnt", unitCnt);
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "실제 파일과 DB상의 파일이 불일치 할 수도 있습니다. 제작자에게 문의해주세요.");
//				return view;
//			}
//			return mav;
//		}
//	
//	@RequestMapping(value="/reg_img")
//	public ModelAndView reg_img(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		ModelAndView	mav	= new ModelAndView("/reg_img");
//		
//		try {
//			
//			List<String> list = new ArrayList<String>();
//			String bookCd = request.getParameter("bookCd");
//			
//			String uploadMovePath	= session.getServletContext().getRealPath("/").replace("\\", "/")+"resources/UPLOAD/"+bookCd;
//			System.out.println(uploadMovePath);
//			File imgUploadPath = new File(uploadMovePath);
//			
//			if (!imgUploadPath.exists()){//디렉토리 생성
//				imgUploadPath.mkdir();
//			}
//			
//			File []fileList=imgUploadPath.listFiles();
//			
//				
//				int fileLength = fileList.length;
//				
//				for(int i=0; i<fileLength; i++) {
//					if(fileList[i].isFile()) {
//						String tempPath=fileList[i].getParent();
//						
//						//로컬
//						//String bb = tempPath.replace("\\", "/").split("wtpwebapps/hakwon")[1];
//						
//						//운영
//						String bb = tempPath.replace("\\", "/").split("webapps/ROOT")[1];
//						
//						if(fileList[i].getName().split("_")[0].equals(bookCd)){
//							
//							list.add(i, bb+"/"+fileList[i].getName());
//						}
//						
//					}
//				}
//				Collections.sort(list);
//				logger.info("AFTER SORT");
//				logger.info("해답 목록 : "+list);
//				
//				String s_tcd = (String) session.getAttribute("s_tcd");
//				mav.addObject( "bookList" , bService.get_list(s_tcd) );
//				
//				mav.addObject( "srcList" , list );
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "실제 파일과 DB상의 파일이 불일치 할 수도 있습니다. 제작자에게 문의해주세요.");
//				return view;
//			}
//			return mav;
//		}
//	
//		
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/delete_file")
//		public ModelAndView delete_file(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//				
//				List<String> list = new ArrayList<String>();
//				String[] arrDel =request.getParameterValues("arr_del");
//				String bookCd = arrDel[0].split("/resources/UPLOAD/")[1].split("/")[0];
//				
//				System.out.println(bookCd);
//				
//				
//				for(int z=0; z<arrDel.length; z++){
//					
//					//물리적 삭제[s]
//					File file = new File(session.getServletContext().getRealPath("/")+arrDel[z]);
//					System.out.println("삭제파일 경로 : "+session.getServletContext().getRealPath("/")+arrDel[z]);
//					if( file.exists() ){ //파일존재여부확인
//						
//						if(file.isDirectory()){ //파일이 디렉토리인지 확인
//							File[] files = file.listFiles();
//							for( int i=0; i<files.length; i++){
//								if( files[i].delete() ){
//									logger.info("폴더 삭제 성공 : "+files[i].getName());
//								}else{
//									logger.info("폴더 삭제 실패 : "+files[i].getName());
//								}
//							}
//						}
//						
//						if(file.delete()){
//							logger.info("파일삭제 성공");
//						}else{
//							logger.info("파일삭제 실패");
//						}
//						
//					}else{
//						logger.info("파일이 존재하지 않습니다.");
//					}
//					//물리적 삭제[e]
//				}
//				
//					response.sendRedirect("reg_img?bookCd="+bookCd);
//				
//				
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "파일 삭제중 에러가 발생했습니다.");
//				return view;
//			}
//			return null;
//		}
//		
//		@RequestMapping(value="/reg_answer")
//		public ModelAndView reg_answer(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/reg_answer");
//			
//			try {
//				
//			String tcd = (String) session.getAttribute("s_tcd");
//			String scd = request.getParameter("scd");
//			
//			mav.addObject("tcd", tcd);
//			mav.addObject("scd", scd);
//			System.out.println("################"+tcd);
//			mav.addObject( "bookList" , bService.get_list(tcd) );
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "도서 목록을 불러오는 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return mav;
//		}
//		
//		@RequestMapping(value="/mng_log")
//		public ModelAndView mng_log(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/mng_log");
//			
//			try {
//			
//			mav.addObject("lList",qService.get_print_log((String) session.getAttribute("s_tcd")));//로그목록
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "오답 이력 목록을 불러오는 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return mav;
//		}
//		
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/edit_log")
//		public ModelAndView edit_log(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/edit_log");
//			
//			try {
//			String lcd = request.getParameter("v_lcd");
//			String seqno = request.getParameter("v_seqno");
//			
//			if(seqno == null){
//				
//				mav.addObject("lList",qService.get_detail_log(lcd));//로그목록
//				mav.addObject("pList",qService.get_detail_log_print(lcd));//로그목록
//			}else{
//				Map map= new HashMap();
//				map.put("v_lcd", lcd);
//				map.put("v_seqno", seqno);
//				
//				mav.addObject("lList",qService.get_detail_log_seq(map));//로그목록
//				mav.addObject("pList",qService.get_detail_log_seq_print(map));//로그목록
//			}
//			
//			mav.addObject("v_lcd",lcd);
//			mav.addObject("seqList",qService.get_seqno(lcd));//로그목록
//			
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "오답 이력 상세를 불러오는 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return mav;
//		}
//		
//		/*
//		 * 책 등록(save)
//		 */
//		@RequestMapping(value="/reg_book")
//		public ModelAndView reg_book(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//
//				BookBean bb = new BookBean();
//				String s_tcd = (String) session.getAttribute("s_tcd");
//				
//				String v_share = request.getParameter("b_shareYn");
//				String v_bcd = request.getParameter("b_cd");
//				String v_bname = request.getParameter("b_name");
//				String v_unit_cnt = request.getParameter("b_unit");
//				
//				bb.setV_bcd(v_bcd);
//				bb.setV_bname(v_bname);
//				bb.setV_unit_cnt(v_unit_cnt);
//				bb.setV_share(v_share);
//				
//				this.bService.reg_book(bb);
//				
//				response.sendRedirect("reg_answer");
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "도서 등록 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return null;
//		}
//		
//		/*
//		 * 책 삭제(save)
//		 */
//		@RequestMapping(value="/delete_book")
//		public ModelAndView delete_book(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//
//				String v_bcd = request.getParameter("v_bcd");
//				
//				this.bService.delete_book(v_bcd);
//				
//				response.sendRedirect("reg_answer");
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "도서 삭제 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return null;
//		}
//		
//		/*
//		 * 로그 삭제(update)
//		 */
//		@RequestMapping(value="/delete_log")
//		public ModelAndView delete_log(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//
//				String v_lcd = request.getParameter("v_lcd");
//				System.out.println("V_LCD : "+v_lcd);
//				
//				this.qService.delete_log(v_lcd);
//				
//				response.sendRedirect("mng_log");
//				
//			} catch (Exception e) {
//				logger.error(e);
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "도서 삭제 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return null;
//		}
//		
//		/*
//		 * 답안과 함께 문제 삭제(save)
//		 */
//		@RequestMapping(value="/delete_question")
//		public ModelAndView delete_question(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//				String v_bcd = request.getParameter("v_bcd");
//				String v_unit_cnt = request.getParameter("v_unit_cnt");
//				
//				String[] arr_del =request.getParameterValues("arr_del");
//				
//				this.qService.delete_question(arr_del);
//				
//				response.sendRedirect("view_answer?v_bcd="+v_bcd+"&v_unit_cnt="+v_unit_cnt);
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "도서 삭제 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return null;
//		}
//		
//		/*
//		 * 답안 한개 수정
//		 */
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/edit_one_answer")
//		public ModelAndView edit_one_answer(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//
//				String v_file_path = request.getParameter("v_file_path");
//				String v_answer = request.getParameter("v_answer");
//				String returnUrl = request.getParameter("returnUrl");
//				
//				System.out.println(v_file_path+"/"+v_answer+"/"+returnUrl);
//				
//				Map bb = new HashMap();
//				
//				bb.put("v_file_path", v_file_path);
//				bb.put("v_answer", v_answer);
//				
//				this.qService.update_answer(bb);
//				
//				response.sendRedirect(returnUrl);
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "도서 등록 중 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return null;
//		}
//		
//		@RequestMapping(value="/question_list")
//		public ModelAndView question_list(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/question_list");
//			try {
//				String s_tcd = (String) session.getAttribute("s_tcd");
//				mav.addObject( "bookList" , bService.get_list(s_tcd) );
//				
//				String stlv = (String) session.getAttribute("s_tlv");
//				if(!stlv.isEmpty() && stlv.equals("1")){
//					mav.addObject("cList",cService.get_list_mst());//전체학급목록
//				}else{
//					mav.addObject("cList",cService.get_list((String)session.getAttribute("s_tcd")));//담당 학급 목록
//				}
//				
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "문제 목록 화면을 그리다가 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return mav;
//		}
//		
//		
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/question_list_ajax")
//		public ModelAndView question_list_ajax(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/ajax_book");
//			try {
//			
//				String v_bcd = request.getParameter("v_bcd");
//				String v_unit = request.getParameter("v_unit");
//				
//				Map bb = new HashMap();
//				bb.put("v_bcd", v_bcd);
//				bb.put("v_unit", v_unit);
//				
//				logger.info(v_bcd+"의 "+v_unit+"단원 문제 리스트를 ajax로 호출합니다");
//				mav.addObject( "qList" , this.qService.get_q_list_all(bb) );
//				
//				System.out.println(this.qService.get_q_list_all(bb));
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "해당 도서의 문제 목록을 가져오다가 에러가 발생했습니다.");
//				return view;
//			}
//			return mav;
//		}
//		
//		@RequestMapping(value="/class_list_ajax")
//		public ModelAndView class_list_ajax(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/ajax_class");
//			try {
//			
//				String v_tcd = request.getParameter("v_tcd");
//				logger.info(v_tcd+"의 학급들을 ajax로 호출합니다");
//				mav.addObject( "cList" , this.cService.get_list(v_tcd) );
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "해당 도서의 문제 목록을 가져오다가 에러가 발생했습니다.");
//				return view;
//			}
//			return mav;
//		}
//		
//		@RequestMapping(value="/stdt_list_ajax")
//		public ModelAndView stdt_list_ajax(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/ajax_stdt");
//			try {
//			
//				String v_ccd = request.getParameter("v_ccd");
//				logger.info(v_ccd+"의 학생들을 ajax로 호출합니다");
////				mav.addObject( "sList" , this.sService.get_list_c(v_ccd) );
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "학급별 학생 목록을 가져오다가 에러가 발생했습니다.");
//				return view;
//			}
//			return mav;
//		}
//		
//		@RequestMapping(value="/unit_list_ajax")
//		public ModelAndView unit_list_ajax(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/ajax_unit");
//			try {
//			
//				String v_bookcd = request.getParameter("v_bookcd");
//				logger.info(v_bookcd+"의 단원목록을 ajax로 호출합니다");
//				mav.addObject( "unitList" , this.qService.get_unit_list(v_bookcd) );
//				logger.info(this.qService.get_unit_list(v_bookcd));
//			
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "학급별 학생 목록을 가져오다가 에러가 발생했습니다.");
//				return view;
//			}
//			return mav;
//		}
//		
//		
//		@RequestMapping(value="/gen_img")
//		public ModelAndView gen_img(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/gen_img");
//			
//			List<String> qlist = new ArrayList<String>();//문제이미지
//			String v_bcd	= request.getParameter("v_bcd");
//			String v_tcd	= request.getParameter("v_tcd");
//			String[] arrImg =request.getParameterValues("hid");
//			String v_cover1 = request.getParameter("v_cover1");
//			String v_cover2 = request.getParameter("v_cover2");
//			String v_tname = request.getParameter("v_tname");
//			String v_cname = request.getParameter("v_cname");
//			String v_sname = request.getParameter("v_sname");
//			
//			String q_cnt = request.getParameter("q_cnt");
//			String show_num = request.getParameter("show_num");
//			String also_ans = request.getParameter("also_ans");
//			
//			String v_scd = request.getParameter("v_scd");
//			
//			try {
//				
////			mav.addObject("s_info", sService.get_info(v_scd));
//			
//			mav.addObject("q_cnt", q_cnt);
//			mav.addObject("show_num", show_num);
//			mav.addObject("also_ans", also_ans);
//			
//			mav.addObject("cnt", arrImg.length);
//			mav.addObject("v_tname", v_tname);
//			mav.addObject("v_sname", v_sname);
//			mav.addObject("v_cname", v_cname);
//			
//			mav.addObject("v_cover1", v_cover1);
//			mav.addObject("v_cover2", v_cover2);
//			
//			
//			//mav.setViewName("/"+prt_type);
//			
//			String filePath = session.getServletContext().getRealPath("/");
//			
//			filePath	= filePath.replace("\\", "/")+"resources/UPLOAD";
//			for( int i=0; i<arrImg.length; i++ ){
//				qlist.add(arrImg[i]);
//			}
//			
//			Collections.sort(qlist);
//			
//			mav.addObject( "queList" , qService.get_q_list_print(qlist));
//			logger.info("문제리스트");
//			logger.info(qService.get_q_list_print(qlist));
//			
//			Gson gson = new Gson();
//			String jsonStr = gson.toJson(qService.get_q_list_print_json(qlist));
//			
//			mav.addObject( "queListJson" , jsonStr );
//			
//			logger.info( "PRINT IN JSON : "+jsonStr );
//			
//			} catch(Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "이미지 출력화면을 그리다가 에러가 발생했습니다.");
//				return view;
//			}
//			
//			return mav;
//		}
//		
//		/*@SuppressWarnings("unchecked")
//		@RequestMapping(value="comm_image_fileupload")
//		public ModelAndView comm_image_fileupload(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session){
//		
//			try {
//				String s_tcd = (String) session.getAttribute("s_tcd");
//				String fileType = request.getParameter("fType");
//				String v_loc = request.getParameter("v_loc");
//				String bcd = request.getParameter("bcd");
//				System.out.println("v_loc:"+v_loc);
//				System.out.println("bcd:"+bcd);
//				
//				String uploadMovePath;
//				String realPath = session.getServletContext().getRealPath("/");
//				
//				String filePath 	 = null;
//				String fileRealName  = null;
//				
//				if(fileType.equals("q")){
//					
//					logger.info("== 문제등록중 ==");
//					
//					uploadMovePath	= realPath.replace("\\", "/")+"resources/UPLOAD"+v_loc;
//					File imgUploadPath = new File(uploadMovePath);
//					Map bb = new HashMap();
//					MultipartHttpServletRequest mpRequest = ( MultipartHttpServletRequest ) request;
//
//					List<MultipartFile> files = mpRequest.getFiles("manyfiles");
//					
//					for(int i=0; i<files.size(); i++){
//						
//						if(files.get(i).getSize() > 0){
//							if (!imgUploadPath.exists()){//디렉토리 생성
//								imgUploadPath.mkdir();
//							}
//
//							fileRealName = files.get(i).getOriginalFilename();//파일명
//							
//							filePath 	 = uploadMovePath+"/"+fileRealName;
//							System.out.println("옵로도패스"+uploadMovePath);
//							System.out.println("파일리얼내임"+fileRealName);
//							
//							System.out.println("진짜 파일패스"+filePath);
//							File file = new File(filePath);
//							files.get(i).transferTo(file);//파일이동
//						}//if[e]
//						
//						bb.put("v_bcd", bcd);
//						bb.put("v_fname", fileRealName);
//						bb.put("v_loc", v_loc);
//						
//						this.bService.reg_question(bb);
//						logger.info(i+1 +" : "+filePath);
//					}//for[e]
//					System.out.println("여기로 리다이렉트:"+"mng_question?v_loc="+v_loc+"&bcd="+bcd);
//					response.sendRedirect("mng_question?v_loc="+v_loc+"&bcd="+bcd);
//					
//				}else if(fileType.equals("a")){
//					
//					System.out.println("== 해답등록중 ==");
//					uploadMovePath	= realPath.replace("\\", "/")+"resources/UPLOAD"+v_loc+"/"+bcd+"_ans";
//					File imgUploadPath = new File(uploadMovePath);
//					Map bb = new HashMap();
//					MultipartHttpServletRequest mpRequest = ( MultipartHttpServletRequest ) request;
//
//					List<MultipartFile> files = mpRequest.getFiles("manyfiles");
//					
//					for(int i=0; i<files.size(); i++){
//						
//						if(files.get(i).getSize() > 0){
//							if (!imgUploadPath.exists()){//디렉토리 생성
//								imgUploadPath.mkdir();
//							}
//
//							fileRealName = files.get(i).getOriginalFilename();//파일명
//							
//							filePath 	 = uploadMovePath+"/"+fileRealName;
//							System.out.println("옵asdfasdf로도패스"+uploadMovePath);
//							System.out.println("파adsfasdf일리얼내임"+fileRealName);
//							
//							System.out.println("진짜 파일패스"+filePath);
//							File file = new File(filePath);
//							files.get(i).transferTo(file);//파일이동
//						}//if[e]
//						
//						bb.put("v_bcd", bcd);
//						bb.put("v_fname", fileRealName);
//						bb.put("v_loc", v_loc+"/"+bcd+"_ans/");
//						this.bService.reg_answer(bb);
//						logger.info(i+1 +" : "+filePath);
//					}//for[e]
//					response.sendRedirect("mng_answer?v_loc="+v_loc+"&bcd="+bcd);
//				}else{
//					logger.debug("Fatal Error !!");
//					return null;
//				}
//				
//			} catch (IOException e) {
//				e.printStackTrace();
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "중복 데이터를 업로드 했습니다.");
//				return view;
//
//
//			}
//			
//			return null;
//		}*/
//
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="comm_image_fileupload2")
//		public ModelAndView comm_image_fileupload2(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session){
//		
//			try {
//				
//				String uploadMovePath;
//				String realPath = session.getServletContext().getRealPath("/");
//				
//				String filePath 	 = null;
//				String fileRealName  = null;
//				
//				String bookCd = request.getParameter("bookCd");
//				
//				
//				uploadMovePath	= realPath.replace("\\", "/")+"resources/UPLOAD/"+bookCd;
//				File imgUploadPath = new File(uploadMovePath);
//				MultipartHttpServletRequest mpRequest = ( MultipartHttpServletRequest ) request;
//
//				List<MultipartFile> files = mpRequest.getFiles("manyfiles");
//				
//				for(int i=0; i<files.size(); i++){
//					
//					if(files.get(i).getSize() > 0){
//						if (!imgUploadPath.exists()){//디렉토리 생성
//							imgUploadPath.mkdir();
//						}
//						fileRealName = files.get(i).getOriginalFilename();//파일명
//						
//						filePath 	 = uploadMovePath+"/"+fileRealName;
//						File file = new File(filePath);
//						files.get(i).transferTo(file);//파일이동
//						
//						BufferedImage image1 = ImageIO.read(new File(filePath));
//						
//						if(image1.getWidth() < 550 || image1.getHeight() < 700){//폭이나 높이 둘중 하나만 작아도 변환
//							
//							BufferedImage image2 = ImageIO.read(new File("/home/hosting_users/dowkekd9576/tomcat/webapps/ROOT/resources/images/whitespace.png"));
//							
//							//세로 출력 문제 최적 사이즈
//							int width = 550;
//							int height = 700;
//							
//							BufferedImage mergedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
//							Graphics2D graphics = (Graphics2D) mergedImage.getGraphics();
//							
//							graphics.setBackground(Color.WHITE);
//							graphics.drawImage(image2, 0, 0, null);//배경을 먼저 그리고
//							graphics.drawImage(image1, 0, 0, null);//올리고자하는 이미지를 덮어씌운다
//							
//							ImageIO.write(mergedImage, "png", new File(filePath));
//						}
//						
//						
//					}//if[e]
//					
//					logger.info(i+1 +"번째 파일 : "+filePath);
//				}//for[e]
//				logger.info(uploadMovePath+"에 파일이 등록되었습니다.");
//				
//				response.sendRedirect("reg_img?bookCd="+bookCd);
//					
//			} catch (IOException e) {
//				e.printStackTrace();
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "중복 데이터를 업로드 했습니다.");
//				return view;
//
//
//			}
//			
//			return null;
//		}
//		/*
//		 * 프린트 로그남기기(??)
//		 */
//		@RequestMapping(value="/popup_print_log")
//		public ModelAndView popup_print_log(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			ModelAndView	mav	= new ModelAndView("/popup_print_log");
//			
//			try {
//				
//				mav.addObject("lList",qService.get_print_log(request.getParameter("scd")));//선생님 목록
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "학생의 문제 출력 로그를 조회하다가 에러가 발생했습니다.");
//				return view;
//			}
//			return mav;
//		}
//		
//		/*
//		 * 프린트 로그남기기(save)
//		 */
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/print_log")
//		public ModelAndView print_log(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//				Map bb = new HashMap();
//				String[] arrImg =request.getParameterValues("hid");
//				
//				String v_lcd = "lcd"+String.format("%05d", this.qService.get_cnt()+1);
//				int v_seqno = this.qService.get_seq(v_lcd);
//				for( int i=0; i<arrImg.length; i++ ){
//					bb.put("v_lcd", v_lcd);
//					bb.put("v_seqno", v_seqno);
//					bb.put("v_tcd", request.getParameter("v_tcd"));
//					bb.put("v_tname", request.getParameter("v_tname"));
//					bb.put("v_ccd", request.getParameter("v_ccd"));
//					bb.put("v_cname", request.getParameter("v_cname"));
//					bb.put("v_scd", request.getParameter("v_scd"));
//					bb.put("v_sname", request.getParameter("v_sname"));
//
//					bb.put("v_bcd", arrImg[i].split("/")[0]);
//					bb.put("v_filenm",arrImg[i].split("/")[1]);
//					bb.put("v_flag_corr", "");
//					
//					this.qService.insert_print_log(bb);
//				}
//				
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "학생의 문제출력 로그를 남기다가 에러가 발생했습니다.");
//				return view;
//			}
//			return null;
//		}
//		
//		/*
//		 * 프린트 로그남기기(save)
//		 */
//		@SuppressWarnings("unchecked")
//		@RequestMapping(value="/save_edit_log")
//		public ModelAndView save_edit_log(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//				String[] v_lcd = request.getParameterValues("v_lcd");
//				String[] v_seqno = request.getParameterValues("v_seqno");
//				String[] v_scd = request.getParameterValues("v_scd");
//				String[] v_sname = request.getParameterValues("v_sname");
//				String[] v_tcd = request.getParameterValues("v_tcd");
//				String[] v_tname = request.getParameterValues("v_tname");
//				String[] v_ccd = request.getParameterValues("v_ccd");
//				String[] v_cname = request.getParameterValues("v_cname");
//				String[] v_bcd = request.getParameterValues("v_bcd");
//				String[] v_bname = request.getParameterValues("v_bname");
//				String[] v_filenm = request.getParameterValues("v_filenm");
//				String[] v_flag_corr = request.getParameterValues("v_flag_corr");
//				String[] v_reg_dtm = request.getParameterValues("v_reg_dtm");
//				
//				LogBean lb = new LogBean();
//				
//				for(int i = 0; i<v_lcd.length; i++){
//					lb.setV_lcd(v_lcd[i]);
//					lb.setV_seqno(v_seqno[i]);
//					lb.setV_scd(v_scd[i]);
//					lb.setV_sname(v_sname[i]);
//					lb.setV_tcd(v_tcd[i]);
//					lb.setV_tname(v_tname[i]);
//					lb.setV_ccd(v_ccd[i]);
//					lb.setV_cname(v_cname[i]);
//					lb.setV_bcd(v_bcd[i]);
//					lb.setV_bname(v_bname[i]);
//					lb.setV_filenm(v_filenm[i]);
//					lb.setV_flag_corr(v_flag_corr[i]);
//					
//					this.qService.insert_print_log(lb);
//				}
//					
//				response.sendRedirect("mng_log");
//				
//			
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "학생의 문제출력 로그를 남기다가 에러가 발생했습니다.");
//				return view;
//			}
//			return null;
//		}
//		
//		/*
//		 * 문제랑 답이랑 DB등록
//		 */
//		@RequestMapping(value="/reg_question")
//		public ModelAndView reg_question(@ModelAttribute("reqMap") CmMap reqVo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//			
//			try {
//				
//				QuestionBean qb = new QuestionBean();
//				
//				String v_file_path;
//				
//				String v_bcd =request.getParameter("v_bcd");
//				String v_unit_cnt =request.getParameter("v_unit_cnt");
//				
//				String[] v_unit =request.getParameterValues("v_unit");
//				String[] v_num =request.getParameterValues("v_num");
//				String[] v_answer =request.getParameterValues("v_answer");
//				
//				for(int i=0; i<v_unit.length; i++){
//					
//					qb.setV_bcd(v_bcd);
//					qb.setV_unit(v_unit[i]);
//					qb.setV_num(String.format("%03d",Integer.parseInt(v_num[i])));
//					
//					v_file_path = v_bcd + "/" + v_bcd +"_"+ v_unit[i] +"_"+ String.format("%03d", Integer.parseInt(v_num[i]));
//					
//					qb.setV_file_path(v_file_path);
//					qb.setV_answer(v_answer[i]);
//					
//					this.bService.reg_question(qb);
//				}
//				
//				
//				response.sendRedirect("edit_answer?v_bcd="+v_bcd+"&v_unit_cnt="+v_unit_cnt);
//				
//			} catch (Exception e) {
//				e.printStackTrace();
//				ModelAndView view = new ModelAndView("err/other_err");
//				view.addObject("msg", "이미 존재하는 답안이 있습니다.");
//				return view;
//			}
//			
//			return null;
//		}
//	
	@SuppressWarnings({ "unchecked" })
	public static JSONObject convertMapToJson(Map<String, Object> map) {

		JSONObject json = new JSONObject();

		for (Map.Entry<String, Object> entry : map.entrySet()) {

			String key = entry.getKey();

			Object value = entry.getValue();

			// json.addProperty(key, value);

			json.put(key, value);

		}

		return json;

	}
}
