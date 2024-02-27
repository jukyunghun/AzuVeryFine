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
    <link href="css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
    <%@ include file="nav/navbar.jsp" %>
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <%@ include file="nav/sidebar.jsp" %>
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
                                    <i class="fas fa-syringe me-1"></i>
                                    약제 투입
                                </div>
                                <div class="card-body">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" id="medicationInput" placeholder="약제 양(ml)">
                                        <button class="btn btn-primary" type="button" onclick="injectMedication()">약제 투입</button>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar" role="progressbar" id="medicationGauge" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div id="remainingMedication" class="mt-3">남은 약제: 500ml</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="nav/footer.jsp" %>
        </div>
    </div>
    <script>
        function injectMedication() {
            var medicationInput = document.getElementById("medicationInput");
            var amount = parseFloat(medicationInput.value);
            if (!isNaN(amount) && amount > 0) {
                if (confirm(amount + "ml의 약제를 투입하시겠습니까?")) {
                    console.log(amount + "ml의 약제가 투입되었습니다.");
                    updateMedicationGauge(amount);
                    updateRemainingMedication(amount);
                }
            } else {
                alert("올바른 약제 값을 입력하세요.");
            }
        }

        function updateMedicationGauge(amount) {
            var gauge = document.getElementById("medicationGauge");
            var currentValue = parseFloat(gauge.style.width);
            var newValue = currentValue - (amount * 100) / 1000; // 가정 : 전체 약제량은 1000ml
            if (newValue < 0) {
                newValue = 0; // 음수 값이 되지 않도록 함
            }
            gauge.style.width = newValue + "%";
            gauge.setAttribute("aria-valuenow", newValue);
        }

        function updateRemainingMedication(amount) {
            var remainingMedication = document.getElementById("remainingMedication");
            var currentValue = parseFloat(remainingMedication.innerText.replace("남은 약제: ", "").replace("ml", ""));
            var newValue = currentValue - amount;
            if (newValue < 0) {
                newValue = 0; // 음수 값이 되지 않도록 함
            }
            remainingMedication.innerText = "남은 약제: " + newValue + "ml";
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
</body>
</html>