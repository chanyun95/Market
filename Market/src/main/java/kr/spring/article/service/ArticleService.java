package kr.spring.article.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.article.vo.ArticleVO;
import kr.spring.member.vo.MemberVO;

public interface ArticleService {
	//물품 등록
	public void insertArticle(ArticleVO article);
	//물품 목록
	public List<ArticleVO> getArticleList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	//물품 상세 정보
	public ArticleVO selectAtricle(Long arti_num);
	//물품 정보 수정
	public void updateArticle(ArticleVO article);
	//물품 삭제
	public void deleteArticle(Long arti_num);
	public void deleteFile(Long arti_num);
	//조회수 증가
	public void updateHit(Long arti_num);
}
