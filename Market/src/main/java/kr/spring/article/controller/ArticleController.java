 package kr.spring.article.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.checkerframework.checker.units.qual.s;
import org.openqa.selenium.devtools.v100.page.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import kr.spring.article.dao.ArticleMapper;
import kr.spring.article.service.ArticleService;
import kr.spring.article.vo.ArticleVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
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
	@PostMapping("/shop/insertArticle")
	public String insertSubmit(@Valid ArticleVO articleVO,BindingResult result,
			@RequestParam("arti_upload") MultipartFile upload, HttpServletRequest request, Model model,HttpSession session)
														throws IOException{
		
		log.debug("<<상품등록>> : " + articleVO);
		
		//유효성 체크 결과 오류가 있으면 다시 폼으로 이동
		if (result.hasErrors()) {
			log.debug("<<등록 오류발생>>");
		    return insertForm(); // 오류가 있는 폼으로 리턴
		}
		//회원번호 처리
		MemberVO vo = (MemberVO)session.getAttribute("user");
		articleVO.setMem_num(vo.getMem_num());
		//이미지 업로드 처리
		articleVO.setArti_image(FileUtil.createFile(request, upload));
		//상품등록
		articleService.insertArticle(articleVO);
		
		model.addAttribute("message","상품등록이 완료되었습니다.");
		model.addAttribute("url",request.getContextPath()+"/shop/artiList");
		model.addAttribute("alertType","success");
		
		return "/common/resultAlert";
	}
	/*=============================
	 * 물품 목록
	 ============================*/
	@GetMapping("/shop/artiList")
	public String getArtiList(@RequestParam(defaultValue="1") int pageNum,
								@RequestParam(defaultValue="1") int order,
								@RequestParam(defaultValue="") String arti_category,
								String keyfield,String keyword,Model model) {
		
		log.debug("<<게시판 목록 - arti_category>> : " + arti_category);
		log.debug("<<게시판 목록 - order>> : " + order);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("arti_category", arti_category);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = articleService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,20,10,"artiList",
												"&arti_category="+arti_category+"&order="+order);
		List<ArticleVO> artiList = null;
		if(count > 0) {
			map.put("order", order);
			map.put("arti_category", arti_category);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			artiList = articleService.getArticleList(map);
		}
		model.addAttribute("count",count);
		model.addAttribute("artiList",artiList);
		model.addAttribute("page",page.getPage());
		
		return "artiList";
	}
	/*=============================
	 * 물품 상세
	 ============================*/
	@GetMapping("/shop/detail")
	public String detailArticle(long arti_num,Model model,HttpSession session) {
		
		log.debug("<<물품 상세 글>> : " + arti_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int count = articleService.selectRowCount(map);
		
		PagingUtil page = new PagingUtil(1,count,4,10,null);
		
		map.put("start", page.getStartRow());
		map.put("end", page.getEndRow());
		
		List<ArticleVO> artiList = articleService.getArticleList(map);
		
		articleService.updateHit(arti_num);
		
		ArticleVO article = articleService.selectAtricle(arti_num);
		article.setArti_name(StringUtil.useNoHTML(article.getArti_name()));
		article.setArti_content(StringUtil.useBrNoHTML(article.getArti_content()));
		
		model.addAttribute("artiList",artiList);
		model.addAttribute("article",article);
		
		return "artiDetail";
	}
	/*=============================
	 * 물품 정보 수정
	 ============================*/
	@GetMapping("/shop/update")
	public String updateArticle(long arti_num,Model model) {
		ArticleVO articleVO = articleService.selectAtricle(arti_num);
		
		model.addAttribute("articleVO",articleVO);
		
		return "updateArticle";
	}
	@PostMapping("/shop/update")
	public String updateArticleSubmit(@Valid ArticleVO articleVO,BindingResult result,
														Model model,HttpServletRequest request) 
														throws IllegalStateException, IOException {
		
		log.debug("<<ArticleVO>> : " + articleVO);
		
		//유효성 체크
		if(result.hasErrors()) {
			ArticleVO vo = articleService.selectAtricle(articleVO.getArti_num());
			articleVO.setArti_image(vo.getArti_image());
			return "updateArticle";
		}
		//DB에 저장된 파일 정보
		ArticleVO db_article = articleService.selectAtricle(articleVO.getArti_num());
		//파일명 셋팅(FileUtil.createFile에서 파일이 없으면 null 처리)
		articleVO.setArti_image(FileUtil.createFile(request, articleVO.getArti_upload()));
		
		articleService.updateArticle(articleVO);
		
		if(articleVO.getArti_upload()!=null && articleVO.getArti_upload().isEmpty()) {
			//수정 전 파일 삭제
			FileUtil.removeFile(request, db_article.getArti_image());
		}
		model.addAttribute("message","상품 정보 수정 완료");
		model.addAttribute("url",request.getContextPath()+"/shop/detail?arti_num="+articleVO.getArti_num());
		model.addAttribute("alertType","success");
		
		return "/common/resultAlert";
	}
	/*================
	 * 상품 삭제
	 *================*/
	@GetMapping("/shop/delete")
	public String deleteArticle(long arti_num,HttpServletRequest request) {
		
		log.debug("<<상품 삭제 : >> : " + arti_num);
		
		ArticleVO db_article = articleService.selectAtricle(arti_num);
		//상품 삭제
		articleService.deleteArticle(arti_num);
		if(db_article.getArti_image()!=null) {
			//사진이 있을 경우 글과 함께 데이터 삭제
			FileUtil.removeFile(request, db_article.getArti_image());
		}
		return "redirect:/shop/artiList";
	}
}
