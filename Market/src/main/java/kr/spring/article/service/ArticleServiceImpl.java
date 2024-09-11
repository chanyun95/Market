package kr.spring.article.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.article.dao.ArticleMapper;
import kr.spring.article.vo.ArticleVO;
 
@Service
@Transactional
public class ArticleServiceImpl implements ArticleService{
	@Autowired
	ArticleMapper articleMapper;

	@Override
	public void insertArticle(ArticleVO article) {
		articleMapper.insertArticle(article);
	}
	@Override
	public List<ArticleVO> getArticleList(Map<String, Object> map) {
		return articleMapper.getArticleList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return articleMapper.selectRowCount(map);
	}

	@Override
	public ArticleVO selectAtricle(Long arti_num) {
		return articleMapper.selectAtricle(arti_num);
	}

	@Override
	public void updateArticle(ArticleVO article) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteArticle(Long arti_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteFile(Long arti_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateHit(Long arti_num) {
		// TODO Auto-generated method stub
		
	}

}
