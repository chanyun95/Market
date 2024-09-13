package kr.spring.article.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.checkerframework.checker.units.qual.s;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.article.service.ArticleService;
import kr.spring.article.vo.ArticleVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ArticleAjaxController {
	@Autowired
	private ArticleService articleService;
	
	/*================
	 * 사진 삭제
	 *================*/
	@PostMapping("/shop/deleteImage")
	@ResponseBody
	public Map<String, Object> processImage(long arti_num,HttpSession session,
												HttpServletRequest request){
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			ArticleVO db_article = articleService.selectAtricle(arti_num);
			
			//회원번호 일치 여부 확인
			if(user.getMem_num() != db_article.getMem_num()) {
				mapJson.put("result", "wrongAccess");
			}else {
				articleService.deleteImage(arti_num);
				FileUtil.removeFile(request, db_article.getArti_image());
			
				mapJson.put("result", "success");
			}
		}
		return mapJson;
	}
	
}
