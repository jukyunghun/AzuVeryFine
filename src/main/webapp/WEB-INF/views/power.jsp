<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
    content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>기기 전원 관리 - SB Admin</title>
<link
    href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
    rel="stylesheet" />
<link href="/final/assets/css/styles.css" rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        
.lock {
      width: 100%;
      height: 100%;
      background-image: url(/final/assets/images/lock.jpg);
      background-size: cover;
      background-position: center;
      transition: background-image 0.3s ease-in-out;
      display: flex;
    }

    .lock.off {
      background-image: url(/final/assets/images/unlock.jpg);
    display: flex;
    }
    
   
    </style>


</head>
<body class="sb-nav-fixed">
    <jsp:include page="nav/navbar.jsp" />
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <%@ include file="nav/sidebar.jsp"%>
        </div>
        <div id="layoutSidenav_content">
        <main>
    <div class="container-fluid px-4">
        <div class="d-flex justify-content-center align-items-center flex-column" style="min-height: auto;">
            <h1 class="mt-4 text-center" style="font-weight: bold;">배관 밸브 제어</h1>
            <img id="valveImage" src="/final/assets/images/lock.jpg" class="lock my-4" alt="Lock" style="width: auto; height: 200px;">
            <div class="row justify-content-center">
                <div class="col-lg-50">
                    <div class="card mb-2">
                        <div class="card-header">
                            <i class="fas fa-wrench me-1"></i> 배관 밸브 제어
                        </div>
                        <div class="card-body">
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="valveSwitch" onchange="toggleValve()"> 
                                <label class="form-check-label" for="valveSwitch">
                                    배관 밸브 열기/닫기
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
    <div>
      <%@ include file="nav/footer.jsp"%>
    </div>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="/final/assets/js/scripts.js"></script>
    
    <script>
    
    window.onload = function () {
    	
    	
    	$.ajax({
            url: '/final/valveGetStatus',
            type: 'GET',
            success: function(valveStatus) {
            	console.log(valveStatus);
                // 요청이 성공한 경우 실행될 코드
                var valveSwitch = $('#valveSwitch');
                valveSwitch.prop('checked', valveStatus === '1');
                updateValveImage(valveStatus);
            },
            error: function(xhr, textStatus, errorThrown) {
                // 요청이 실패한 경우 실행될 코드
                console.error('밸브 상태를 가져오는 중 오류 발생:', errorThrown);
            }
        });
    	

    };
    

 // toggleValve 함수 정의
    function toggleValve() {
            var valveSwitch = document.getElementById("valveSwitch");
            var valveStatus = valveSwitch.checked ? "1" : "0"; // 밸브 스위치 상태에 따라 1 또는 0 설정

            var requestOptions = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'valveStatus=' + valveStatus // 밸브 상태를 서버로 전송
            };

            fetch('power', requestOptions)
                .then(response => {
                    if (response.ok) {
                        console.log("밸브 상태 변경에 성공했습니다.");
                        // 밸브 상태가 변경되었으므로 이미지 업데이트
                        updateValveImage(valveStatus);
                    } else {
                        console.error("밸브 상태 변경에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error("밸브 상태 변경 중 오류 발생:", error);
                });
        }
    
        // 밸브 이미지 업데이트 함수
        function updateValveImage(valveStatus) {
            var valveImage = document.getElementById("valveImage");
            if (valveStatus === "1") {
                valveImage.src = "/final/assets/images/lock.jpg"; // 밸브가 닫혀있는 상태의 이미지 경로
            } else {
                valveImage.src = "/final/assets/images/unlock.jpg"; // 밸브가 열려있는 상태의 이미지 경로
            }
        }
    </script>
    
</body>
</html>
