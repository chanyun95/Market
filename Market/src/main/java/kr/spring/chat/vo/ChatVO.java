package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatVO {
	private long chat_num;
	private long chatroom_num;
	private long mem_num;
	private String message;
	private String chat_date;
	
	private int read_count;
	private String id;
}
