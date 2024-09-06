 package kr.spring.article.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.spring.article.service.ArticleService;
import kr.spring.article.vo.ArticleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ArticleController {
	@Autowired 
	ArticleService articleService;
	//로그 처리
	private static final Logger log = LoggerFactory.getLogger(ArticleController.class);
	
	@ModelAttribute
	public ArticleVO initCommand() {
		return new ArticleVO();
	}
	/*=============================
	 * 물품 등록
	 ============================*/
	@GetMapping("/shop/insertArticle")
	public String insertForm() {
		return "insertArticle";
	}
}