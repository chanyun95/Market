package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chat.dao.ChatMapper;
import kr.spring.chat.vo.ChatVO;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired
	ChatMapper chatMapper;
	

	@Override
	public void insertChat(ChatVO chatVO) {
		chatVO.setChat_num(chatMapper.selectChatNum());
		chatMapper.insertChat(chatVO);
	}

	@Override
	public List<ChatVO> selectChatDetail(Map<String, Long> map) {
		//읽은 채팅 기록 삭제
		chatMapper.deleteChatRead(map);
		return chatMapper.selectChatDetail(map);
	}

}
