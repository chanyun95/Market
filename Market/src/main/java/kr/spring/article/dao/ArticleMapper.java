package kr.spring.article.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.article.vo.ArticleVO;

@Mapper
public interface ArticleMapper {
	//물품 등록
	public void insertArticle(ArticleVO article);
	//물품 목록
	public List<ArticleVO> getArticleList(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	//물품 상세 정보
	@Select("SELECT * FROM article JOIN member USING(mem_num) WHERE arti_num=#{arti_num}")
	public ArticleVO selectAtricle(Long arti_num);
	//물품 정보 수정
	public void updateArticle(ArticleVO article);
	//물품 삭제
	@Delete("DELETE FROM article WHERE arti_num=#{arti_num}")
	public void deleteArticle(Long arti_num);
	@Update("UPDATE article SET arti_image = '' WHERE arti_num=#{arti_num}")
	public void deleteImage(Long arti_num);
	//조회수 증가
	@Update("UPDATE article SET arti_hit=arti_hit+1 WHERE arti_num=#{arti_num}")
	public void updateHit(Long arti_num);
	
}
