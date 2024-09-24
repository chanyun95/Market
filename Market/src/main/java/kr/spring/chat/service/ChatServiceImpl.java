package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chat.dao.ChatMapper;
import kr.spring.chat.vo.ChatMemberVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;

@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired
	ChatMapper chatMapper;
	
	@Override
	public void insertChatRoom(ChatRoomVO chatRoomVO) {
		//기본키 값 생성
		chatRoomVO.setChatroom_num(chatMapper.selectChatRoomNum());
		//채팅방 생성
		chatMapper.insertChatRoom(chatRoomVO);
	}

	@Override
	public List<ChatMemberVO> selectChatMember(Long chatroom_num) {
		return chatMapper.selectChatMember(chatroom_num);
	}

	@Override
	public void insertChat(ChatVO chatVO) {
		chatVO.setChat_num(chatMapper.selectChatNum());
		chatMapper.insertChat(chatVO);
		//읽지 않은 메시지 정보 저장
		for(ChatMemberVO vo : chatMapper.selectChatMember(chatVO.getChatroom_num())) {
			chatMapper.insertChatRead(chatVO.getChatroom_num(),chatVO.getChat_num(),vo.getMem_num());
		}
	}

	@Override
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map) {
		return chatMapper.selectChatRoomList(map);
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return chatMapper.selectRowCount(map);
	}

	@Override
	public List<ChatVO> selectChatDetail(Map<String, Long> map) {
		//읽은 채팅 기록 삭제
		chatMapper.deleteChatRead(map);
		return chatMapper.selectChatDetail(map);
	}

}
