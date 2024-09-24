package kr.spring.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.chat.vo.ChatMemberVO;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;

@Mapper
public interface ChatMapper {
	//채팅방 번호 생성
	@Select("SELECT chatroom_seq.nextval FROM dual")
	public Integer selectChatRoomNum();
	//채팅방 생성
	@Insert("INSERT INTO chatroom (chatroom_num,basic_name) VALUES (#{chatroom_num},#{basic_name})")
	public void insertChatRoom(ChatRoomVO chatRoomVO);
	//채팅방 멤버 추가
	@Insert("INSERT INTO chat_member (chatroom_num,room_name,mem_num) VALUES (#{chatroom_num},#{room_name},#{mem_num})")
	public void insertChatRoomMember(@Param(value="chatroom_num") Long chat_num, @Param(value="room_name") String room_name,@Param(value="mem_num") Long mem_num);
	//채팅방 멤버 읽기
	public List<ChatMemberVO> selectChatMember(Long chatroom_num);
	//채팅 메시지 번호 생성
	@Select("SELECT chat_seq.nextval FROM dual")
	public Integer selectChatNum();
	//채팅 메시지 등록
	@Insert("INSERT INTO chat(chat_num,chatroom_num,mem_num,message) VALUES (#{chat_num},#{chatroom_num},#{mem_num},#{message})")
	public void insertChat(ChatVO chatVO);
	//채팅방 목록
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map);
	public Integer selectRowCount(Map<String, Object> map);
	//읽지 않은 채팅 기록
	@Insert("INSERT INTO chat_read(chatroom_num,chat_num,mem_num) VALUES(#{chatroom_num},#{chat_num},#{mem_num})")
	public void insertChatRead(@Param(value="chatroom_num") Long chatroom_num,@Param(value="chat_num") Long chat_num,@Param(value="mem_num") Long mem_num);
	//메시시 읽기
	public List<ChatVO> selectChatDetail(Map<String, Long> map);
	//읽은 채팅 기록 삭제
	@Delete("DELETE FROM chat_read WHERE chatroom_num=#{chatroom_num} AND mem_num=#{mem_num}")
	public void deleteChatRead(Map<String, Long> map);
}
