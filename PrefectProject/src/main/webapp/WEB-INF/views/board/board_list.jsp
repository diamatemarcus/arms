<%@page import="com.pcwk.ehr.cmn.StringUtil"%>
<%@page import="com.pcwk.ehr.board.domain.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="CP" value="${pageContext.request.contextPath}" scope="page" />     
<!DOCTYPE html>
<html> 
<head>
<link href="${CP}/resources/css/layout.css" rel="stylesheet" type="text/css">
<jsp:include page="/WEB-INF/cmn/header.jsp"></jsp:include>
<script>
document.addEventListener("DOMContentLoaded",function(){
	console.log("DOMContentLoaded");
	
	const moveToRegBTN  = document.querySelector("#moveToReg");
	const doRetrieveBTN = document.querySelector("#doRetrieve");//목록 버튼
	const searchDivSelect = document.querySelector("#searchDiv");//id 등록 버튼
    const boardForm = document.querySelector("#boardForm");
    const searchWordTxt = document.querySelector("#searchWord");
    const rows = document.querySelectorAll("#boardTable>tbody>tr");
    
    rows.forEach(function(row) {
        row.addEventListener('click', function(e) {
            let cells = row.getElementsByTagName("td");
            const seq = cells[5].innerText;  
            console.log('seq:' + seq);

            const div = document.querySelector("#div").value;
            console.log('div:'+div);
            
            window.location.href = "${CP}/board/doSelectOne.do?seq="+seq +"&div=" + div;   
        });
    });
	
	// 등록 이동 이벤트
    moveToRegBTN.addEventListener("click",function(e){
        console.log("moveToRegBTN click");
        
        const div = document.querySelector("#div").value;
        window.location.href = "${CP}/board/moveToReg.do?div=" + div;
        
    });
	
    searchWordTxt.addEventListener("keyup", function(e) {
        console.log("keyup:"+e.keyCode);
        if(13==e.keyCode){//
            doRetrieve(1);
        }
        //enter event:
    });
    
    //form submit방지
    boardForm.addEventListener("submit", function(e) {
        console.log(e.target)
        e.preventDefault();//submit 실행방지
        
    }); 
	

	
	 //목록버튼 이벤트 감지
    doRetrieveBTN.addEventListener("click",function(e){
        console.log("doRetrieve click");
        doRetrieve(1);
    });
	
    function doRetrieve(pageNo){
        console.log("doRetrieve pageNO:"+pageNo);
        
        let boardForm = document.boardForm;
        boardForm.pageNo.value = pageNo;
        boardForm.action = "/ehr/board/doRetrieve.do";
        console.log("doRetrieve pageNO:"+boardForm.pageNo.value);
        boardForm.submit();
    }
    
    //검색조건 변경!:change Event처리 
    searchDivSelect.addEventListener("change",function(e){
        console.log("change:"+e.target.value);
        
        let chValue = e.target.value;
        if(""==chValue){ //전체
           
            //input text처리
            let searchWordTxt = document.querySelector("#searchWord");
            searchWordTxt.value = "";
            
            //select값 설정
            let pageSizeSelect =  document.querySelector("#pageSize");
            pageSizeSelect.value = "10";    
        }
    });	

	
});//--DOMContentLoaded

function pageDoRerive(url,pageNo){
    console.log("url:"+url);
    console.log("pageNo:"+pageNo);
    
    let boardForm = document.boardForm;
    boardForm.pageNo.value = pageNo;
    boardForm.action = url;
    boardForm.submit();
}


</script>
<style>
    /* 테이블과 관련된 스타일 */
    .table th, .table td {
        padding: 0.5rem; /* 셀 내부의 padding을 조절합니다 */
    }

    /* 선택적으로 테이블의 너비를 조절합니다 */
    .table-responsive {
        margin: 0 auto; /* 상하 마진은 0, 좌우 마진은 자동으로 설정 */
    }

    /* 선택적으로 테이블 행의 높이를 조절합니다 */
    .table tr {
        height: auto; /* 필요에 따라 조절 */
    }
</style>
</head>
<body> 
    <!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->
    

    <div class="container">
    <!-- 제목 -->
    <div class="row">
        <div class="col-lg-12">
        <br>
        <br>
            <h2 class="page-header" style="text-align: left;">${title}</h2>
        </div>
    </div>    
    <br>
    <br>
    <!--// 제목 ----------------------------------------------------------------->

    <!-- 검색 -->
    <form action="#" method="get" id="boardForm" name="boardForm">
      <input type="hidden" name="div"    id="div"  value="${paramVO.getDiv() }"/>
      <input type="hidden" name="pageNo" id="pageNo" />
      <div class="row g-1 justify-content-end ">
          <label for="searchDiv" class="col-auto col-form-label">검색조건</label>
          <div class="col-auto">
              <select class="form-select pcwk_select" id="searchDiv" name="searchDiv">
                     <option value="">전체</option>
                     <c:forEach var="vo" items="${boardSearch }">
                        <option value="<c:out value='${vo.detCode}'/>"  <c:if test="${vo.detCode == paramVO.searchDiv }">selected</c:if>  ><c:out value="${vo.detName}"/></option>
                     </c:forEach>
              </select>
          </div>    
          <div class="col-auto">
              <input type="text" class="form-control" id="searchWord" name="searchWord" maxlength="100" placeholder="검색어를 입력 하세요" value="${paramVO.searchWord}">
          </div>   
          <div class="col-auto"> 
               <select class="form-select" id="pageSize" name="pageSize">
                  <c:forEach var="vo" items="${pageSize }">
                    <option value="<c:out value='${vo.detCode }' />" <c:if test="${vo.detCode == paramVO.pageSize }">selected</c:if>  ><c:out value='${vo.detName}' /></option>
                  </c:forEach>
               </select>  
          </div>    
          <div class="col-auto "> <!-- 열의 너비를 내용에 따라 자동으로 설정 -->
            <input type="button" value="검색" class="button"  id="doRetrieve">
            <input type="button" value="글쓰기" class="button"  id="moveToReg">
          </div>              
      </div>
                           
    </form>
    <br>
    <br>
    <!--// 검색 ----------------------------------------------------------------->
    
    
    <!-- table -->
    <table class="table table-responsive" id="boardTable">
      <thead>
        <tr >
          <th scope="col" class="text-center col-lg-1  col-sm-1">NO</th>
          <th scope="col" class="text-center col-lg-5  col-sm-6">제목</th>
          <th scope="col" class="text-center col-lg-2  col-sm-1">등록일</th>
          <th scope="col" class="text-center col-lg-2  ">등록자</th>
          <th scope="col" class="text-center col-lg-1  ">조회수</th>
          <th scope="col" class="text-center" style="display: none;">SEQ</th>
        </tr>
      </thead>         
      <tbody>
        <c:choose>
            <c:when test="${ not empty list }">
              <!-- 반복문 -->
              <c:forEach var="vo" items="${list}" varStatus="status">
                <tr>
                  <td class="text-center col-lg-1  col-sm-1"><c:out value="${vo.no}" escapeXml="true"/> </th>
                  <td class="text-left   col-lg-5  col-sm-8" ><c:out value="${vo.title}" escapeXml="true"/></td>
                  <td class="text-center col-lg-2  col-sm-1"><c:out value="${vo.modDt}" escapeXml="true"/></td>
                  <td class="text-center col-lg-2 "><c:out value="${vo.modId}" /></td>
                  <td class="text-center col-lg-1 "><c:out value="${vo.readCnt}" /></td>
                  <td  style="display: none;"><c:out value="${vo.seq}" /></td>
                </tr>              
              </c:forEach>
              <!--// 반복문 -->      
            </c:when>
            <c:otherwise>
               <tr>
                <td colspan="99" class="text-center">조회된 데이터가 없습니다..</td>
               </tr>              
            </c:otherwise>
        </c:choose>
      </tbody>
    </table>
    <!--// table --------------------------------------------------------------> 
    
    <!-- 페이징 : 함수로 페이징 처리 
         총글수, 페이지 번호, 페이지 사이즈, bottomCount, url,자바스크립트 함수
    -->      
    <div class="container-fluid py-5">
	    <div class="container">
	        <div class="row">
	            <div class="col-lg-12">
	                <!-- Pagination -->
	                <div class="pagination d-flex justify-content-center mt-5">
	                    <nav>
				            ${pageHtml }
				        </nav>
	                </div>
	                <!-- End of Pagination -->
	            </div>
	        </div>
	    </div>
	</div>    
    <!--// 페이징 ---------------------------------------------------------------->
</div>
<br>
<jsp:include page="/WEB-INF/cmn/footer.jsp"></jsp:include>

</body>
</html>