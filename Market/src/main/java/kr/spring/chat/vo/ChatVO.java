package kr.spring.chat.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatVO {
	private long chat_num;
	private long mem_num;
	private Date chat_reg_date;
	
	//조인으로 생성
	private String mem_id;	//의사 이름 or 환자 이름

	
}

