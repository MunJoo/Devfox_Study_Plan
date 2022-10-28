package com.moon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.moon.domain.Criteria;
import com.moon.domain.ReplyVO;
import com.moon.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController //メソッドのリターンタイプで、ユーザが定義したクラスタイプを使用でき、これをJSONやXMLで自動的に処理できる
@Log4j
@AllArgsConstructor
public class ReplyController {
	@Setter(onMethod_ = @Autowired)
	private ReplyService service;
	
	//consumes:クライアントが送信するcontentタイプが明示したメディアタイプと同じでなければならない（入力される値がjsonかチェック）
	//producesに明示したメディアタイプと同じときに、そのタイプにレスポンスを送信する（処理されたデータをブラウザに送信するとき（response）、当該タイプが正しいか）
	//ResponseEntityは正常なデータなのか異常なデータなのかを区分し、データとともにhttpヘッダーの状態メッセージを一緒に伝達する(処理された状態の値を記憶)。
	//requestBodyはjsonデータを好きなタイプにバインディングする。 ほとんどのjsonデータをサーバに送信して希望するタイプのオブジェクトに変換する用途で使用（voに値が保存される）
	//コメントが追加された数字を確認してブラウザから200kもしくは500InternalserverErrorを返す

	//consumesは、入ってくるデータタイプを定義するときに使用
	// uriを呼び出す側では、ヘッダーに送るデータがjsonであることを明示しなければならない。
	// // Content-Type:application/json
	// producesは返すデータタイプを定義
	// // MediaType.APPLICATION_JSON_UTF8_VALUE
	// この場合、返却タイプがjsonに強制される
	
	
	//INSERT
	@PreAuthorize("isAuthenticated()") //ログインした人だけがコメントを書けるように
	@PostMapping(value="/new", consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("VO: "+vo);
		int insertCount = service.register(vo);
		log.info("reply insert count: "+insertCount);
		return insertCount == 1 ? new ResponseEntity<>("Comments has been registered.", HttpStatus.OK) : //success文字と状態値200リターン
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);//状態値500リターン
	}
	
	//SELECT
	@GetMapping(value="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, 
			MediaType.APPLICATION_JSON_UTF8_VALUE}) //直接処理したいデータをurl?uri?に受け取ることができる→REST
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") long rno){//@PathVariable: value値をタイプ変換してくれる
		log.info("get: "+rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	//MODIFY
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH}, value="/{rno}",
			 consumes = "application/json",//送信するデータタイプの確認(ajaxのcontentTypeと一致しなければならない)
			 produces = {MediaType.TEXT_PLAIN_VALUE})//送信するデータタイプの確認/リターンするデータタイプがメディアタイプと同じか？
	public ResponseEntity<String> modify (@RequestBody ReplyVO vo, @PathVariable("rno") long rno){
		vo.setRno(rno);
		log.info("modify: "+vo);
		return service.modify(vo) == 1 ? new ResponseEntity<>("Comments have been modified.", HttpStatus.OK) : 
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//REMOVE
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo, @PathVariable("rno") long rno){
		return service.remove(rno) == 1 ? new ResponseEntity<>("Comments have been deleted.", HttpStatus.OK) : //"success"を送るから<String>
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//LIST
	@GetMapping(value="/pages/{bno}/{page}", 
			produces = {MediaType.APPLICATION_ATOM_XML_VALUE, 
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page, @PathVariable("bno") long bno){
		Criteria cri = new Criteria(page, 10);
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	
}//
