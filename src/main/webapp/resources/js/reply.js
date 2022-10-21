var replyService = (function(){

      function add(reply, callback, error) {

      //javascriptcallback検索
	  //特定コードの演算が終わるまでコードの実行を止めずに次のコードを実行するジャワスクリプトの特性をいう
      console.log("add reply....................");
      
      
         $.ajax({
               type : 'post',
               url : '/replies/new',
               data  :JSON.stringify(reply), 
               contentType : "application/json; charset=utf-8",
               success : function(result, status, xhr) {
               if(callback) {
                  callback(result);
                  }
               },error : function(xhr, status, er) {
               if(error) {
                  error(er);
                  }
               }
            })
     }   
         
     //コールバック関数、$.getJSON学習(예짚 블로그)
     
     function getList(param, callback, error) {
     	var bno = param.bno;
     	var page = param.page; 
     	console.log(bno);
     	console.log(page);
     	$.getJSON("/replies/pages/"+bno+"/"+page+".json", function(data) { //$.getJSON: get方式に移行したjson形式のデータを要請する
     		if(callback){
     			callback(data);
     		}
     	}).fail(function(xhr, status, err) {
     		console.log("error");
     	});
    }  
    
    function get(rno, callback, error) {

		$.get("/replies/" + rno + ".json", function(result) {
		
		if (callback) {
		callback(result);
		}
		
		}).fail(function(xhr, status, err) {
		if (error) {
			error();
		}
		});
	}
    
	function update(reply, callback, error){
		$.ajax({
			type:"put",
			url:"/replies/"+reply.rno,
			data:JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			}, error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})//ajax
	}
	
	function remove(rno, replyer, callback, error){
		$.ajax({
			type: 'delete',
			url:'/replies/'+rno,
			data: JSON.stringify({rno:rno, replyer:replyer}),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
						callback(result);
					}
			},error:function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
 	return {add:add, getList:getList, get:get, update:update, remove:remove};
 	//関数は関数のリターン値としても使用できる
   })();
