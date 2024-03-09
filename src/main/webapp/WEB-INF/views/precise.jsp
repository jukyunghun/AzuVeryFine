<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>약제 투입 - SB Admin</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="/final/assets/css/styles.css" rel="stylesheet">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
                    <h1 class="mt-4" style="font-weight: bold;">약제 투입</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">약제 투입</li>
                    </ol>
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-syringe me-1"></i> 약제 투입 (단위 : cc)
                                </div>
                                <div class="card-body">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" id="medicationInput" placeholder="약제 양(cc)">
                                        <button class="btn btn-primary" type="button" onclick="injectMedication()">약제 투입</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="nav/footer.jsp"%>
        </div>
    </div>
    <script>
    function injectMedication() {
        var medicationInput = $("#medicationInput");
        var amountString = medicationInput.val();
        var amount = parseFloat(amountString);

        if (!isNaN(amount) && amount > 0 && !isNaN(amountString) && amountString.indexOf('.') === -1 && amountString.length < 10) {
            if (confirm(amount + "ml의 약제를 투입하시겠습니까?")) {
            	//ajax에 제어부 mcu의  주소를 입력 하여 amount값 보냄 혹은 RaspController에 return값으로 amount보냄
                $.ajax({
                    type: "POST",
                    url: "/final/depurativeInjection",
                    data: { amount: amount },
                    success: function(response) {
                        alert(amount + "ml의 약제가 투입되었습니다.");
                    },
                    error: function(xhr, status, error) {
                        alert("약제 투입에 실패했습니다. 상태 코드: " + xhr.status);
                    }
                });
            }
        } else {
            alert("올바른 약제 값을 입력하세요.");
        }
    }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/final/assets/js/scripts.js"></script>
</body>
</html>