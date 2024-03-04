<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>연동 디바이스 관리 - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
    <link href="/final/assets/css/styles.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body class="sb-nav-fixed">
    <%@ include file="nav/navbar.jsp"%>
   <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <%@ include file="nav/sidebar.jsp"%>
        </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4" style="font-weight: bold;">연동 디바이스 관리</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">연동 디바이스 관리</li>
                    </ol>
                    <div class="row">
                        <div class="col-xl-12">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-cogs me-1"></i> 연동된 디바이스 목록
                                </div>
                                <div class="card-body">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>디바이스 이름</th>
                                                <th>위치</th>
                                                <th>연결 시간</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- 연동된 디바이스 목록을 표시하는 코드 -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <!-- 비연동 디바이스 목록 -->
            <div class="container-fluid px-4">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-cogs me-1"></i> 비연동된 디바이스 목록
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered" id="inactiveDataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>디바이스 이름</th>
                                            <th>위치</th>
                                            <th>연결 해제 시간</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- 비연동 디바이스 목록을 표시하는 코드 -->
                                    </tbody>
                                </table>
                                <!-- 사용자가 직접 디바이스를 추가할 수 있도록 입력란과 버튼 추가 -->
                                <div class="mb-3">
                                    <input type="text" id="deviceNameInput" class="form-control" placeholder="디바이스 이름을 입력하세요">
                                    <input type="text" id="deviceLocationInput" class="form-control mt-2" placeholder="위치를 입력하세요">
                                </div>
                                <button class="btn btn-primary" onclick="addDeviceManually()">디바이스 추가</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /비연동 디바이스 목록 -->
            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-between small">
                        <div class="text-muted">Copyright &copy; Your Website 2023</div>
                        <div>
                            <a href="#">Privacy Policy</a> &middot; <a href="#">Terms
                                &amp; Conditions</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/final/assets/js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="/final/assets/demos/chart-area-demo.js"></script>
    <script src="/final/assets/demos/chart-bar-demo.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="/final/assets/demos/datatables-simple-demo.js"></script>

    <script>
        // 사용자가 직접 디바이스를 추가하는 함수
        function addDevice() {
            var deviceName = prompt("디바이스 이름을 입력하세요:");
            if (deviceName) {
                // 새로운 행 생성
                var newRow = document.createElement('tr');
                // 디바이스 이름 셀 추가
                var deviceNameCell = document.createElement('td');
                deviceNameCell.innerText = deviceName;
                newRow.appendChild(deviceNameCell);
                // 연결 시간 셀 추가
                var connectionTimeCell = document.createElement('td');
                connectionTimeCell.innerText = getCurrentTime();
                newRow.appendChild(connectionTimeCell);
                // 상태 셀 추가
                var statusCell = document.createElement('td');
                statusCell.innerText = "활성";
                newRow.appendChild(statusCell);
                // 동작 셀 추가
                var actionCell = document.createElement('td');
                actionCell.innerHTML = '<button class="btn btn-danger" onclick="toggleConnection(this)">연결 해제</button> <button class="btn btn-warning d-none" onclick="removeDevice(this)">삭제</button>';
                newRow.appendChild(actionCell);

                // 연동된 디바이스 목록 테이블에 행 추가
                var activeDataTable = document.getElementById('dataTable').getElementsByTagName('tbody')[0];
                activeDataTable.appendChild(newRow);
            }
        }

        // 현재 시간을 반환하는 함수
        function getCurrentTime() {
            var now = new Date();
            var year = now.getFullYear();
            var month = String(now.getMonth() + 1).padStart(2, '0');
            var day = String(now.getDate()).padStart(2, '0');
            var hour = String(now.getHours()).padStart(2, '0');
            var minute = String(now.getMinutes()).padStart(2, '0');
            return year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
        }

        // 연결 상태 업데이트 함수
        function updateConnectionStatus(button, status) {
            var row = button.closest('tr');
            var statusCell = row.cells[2];
            statusCell.innerText = status;
        }

        // 비활성 디바이스 목록으로 이동하는 함수
        // 사용자가 직접 디바이스를 추가하는 함수
        function addDevice() {
            var deviceName = document.getElementById('deviceNameInput').value;
            var deviceLocation = document.getElementById('deviceLocationInput').value;
            if (deviceName && deviceLocation) {
                // 새로운 행 생성
                var newRow = document.createElement('tr');
                // 디바이스 이름 셀 추가
                var deviceNameCell = document.createElement('td');
                deviceNameCell.innerText = deviceName;
                newRow.appendChild(deviceNameCell);
                // 위치 셀 추가
                var deviceLocationCell = document.createElement('td');
                deviceLocationCell.innerText = deviceLocation;
                newRow.appendChild(deviceLocationCell);
                // 연결 시간 셀 추가
                var connectionTimeCell = document.createElement('td');
                connectionTimeCell.innerText = getCurrentTime();
                newRow.appendChild(connectionTimeCell);

                // 연동된 디바이스 목록 테이블에 행 추가
                var activeDataTable = document.getElementById('dataTable').getElementsByTagName('tbody')[0];
                activeDataTable.appendChild(newRow);
            }
        }

        // 사용자가 직접 디바이스를 추가하는 함수
        function addDeviceManually() {
            var deviceName = document.getElementById('deviceNameInput').value;
            var deviceLocation = document.getElementById('deviceLocationInput').value;
            if (deviceName && deviceLocation) {
                // 새로운 행 생성
                var newRow = document.createElement('tr');
                // 디바이스 이름 셀 추가
                var deviceNameCell = document.createElement('td');
                deviceNameCell.innerText = deviceName;
                newRow.appendChild(deviceNameCell);
                // 위치 셀 추가
                var deviceLocationCell = document.createElement('td');
                deviceLocationCell.innerText = deviceLocation;
                newRow.appendChild(deviceLocationCell);
                // 연결 시간 셀 추가
                var connectionTimeCell = document.createElement('td');
                connectionTimeCell.innerText = getCurrentTime();
                newRow.appendChild(connectionTimeCell);

                // 연동된 디바이스 목록 테이블에 행 추가
                var activeDataTable = document.getElementById('dataTable').getElementsByTagName('tbody')[0];
                activeDataTable.appendChild(newRow);
            }
        }

        // 현재 시간을 반환하는 함수
        function getCurrentTime() {
            var now = new Date();
            var year = now.getFullYear();
            var month = String(now.getMonth() + 1).padStart(2, '0');
            var day = String(now.getDate()).padStart(2, '0');
            var hour = String(now.getHours()).padStart(2, '0');
            var minute = String(now.getMinutes()).padStart(2, '0');
            return year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
        }

        window.addEventListener('DOMContentLoaded', event => {
            // Toggle the side navigation
            const sidebarToggle = document.body.querySelector('#sidebarToggle');
if (sidebarToggle) {
    sidebarToggle.addEventListener('click', event => {
        event.preventDefault();
        document.body.classList.toggle('sb-sidenav-toggled');
    });
}
        });

            // 비활성 디바이스 목록 테이블에 행 추가
            var inactiveDataTable = document.getElementById('inactiveDataTable').getElementsByTagName('tbody')[0];
            inactiveDataTable.appendChild(newRow);

            // 원래 테이블에서 행 제거
            row.remove();
        }

        // 연동된 디바이스 목록으로 이동하는 함수
        function moveDeviceToActiveList(row) {
            var deviceName = row.cells[0].innerText;
            var connectionTime = row.cells[1].innerText;

            // 새로운 행 생성
            var newRow = document.createElement('tr');
            // 디바이스 이름 셀 추가
            var deviceNameCell = document.createElement('td');
            deviceNameCell.innerText = deviceName;
            newRow.appendChild(deviceNameCell);
            // 연결 시간 셀 추가
            var connectionTimeCell = document.createElement('td');
            connectionTimeCell.innerText = connectionTime;
            newRow.appendChild(connectionTimeCell);
            // 상태 셀 추가
            var statusCell = document.createElement('td');
            statusCell.innerText = "활성";
            newRow.appendChild(statusCell);
            // 동작 셀 추가
            var actionCell = document.createElement('td');
            actionCell.innerHTML = '<button class="btn btn-danger" onclick="toggleConnection(this)">연결 해제</button> <button class="btn btn-warning d-none" onclick="removeDevice(this)">삭제</button>';
            newRow.appendChild(actionCell);

            // 연동된 디바이스 목록 테이블에 행 추가
            var activeDataTable = document.getElementById('dataTable').getElementsByTagName('tbody')[0];
            activeDataTable.appendChild(newRow);

            // 비활성 디바이스 목록에서 행 제거
            row.remove();
        }

        function toggleConnection(button) {
            var row = button.closest('tr');
            var connectionTimeCell = row.cells[1];
            var statusCell = row.cells[2];

            if (button.innerText === '연결 해제') {
                if (confirm('해당 디바이스와의 연결을 해제하시겠습니까?')) {
                    button.innerText = '연결';
                    button.classList.remove('btn-danger');
                    button.classList.add('btn-success');
                    // 연결 해제 작업 수행
                    // 이 곳에 연결 해제 동작에 관련된 코드를 추가
                    updateConnectionStatus(button, '비활성');
                    connectionTimeCell.innerText = getCurrentTime(); // 연결 시간 업데이트
                    moveDeviceToInactiveList(row); // 비활성 디바이스 목록으로 이동
                }
            } else {
                if (confirm('해당 디바이스와 연결 하시겠습니까?')) {
                    button.innerText = '연결 해제';
                    button.classList.remove('btn-success');
                    button.classList.add('btn-danger');
                    // 연결 작업 수행
                    // 이 곳에 연결 동작에 관련된 코드를 추가
                    updateConnectionStatus(button, '활성');
                    connectionTimeCell.innerText = getCurrentTime(); // 연결 시간 업데이트
                    moveDeviceToActiveList(row); // 연동된 디바이스 목록으로 이동
                }
            }
        }

        // 사용자가 직접 디바이스를 삭제하는 함수
        function removeDevice(button) {
            var row = button.closest('tr');
            if (confirm('해당 디바이스를 삭제하시겠습니까?')) {
                row.remove();
            }
        }

        window.addEventListener('DOMContentLoaded', event => {
            // Toggle the side navigation
            const sidebarToggle = document.body.querySelector('#sidebarToggle');
            if (sidebarToggle) {
                sidebarToggle.addEventListener('click', event => {
                    event.preventDefault();
                    document.body.classList.toggle('sb-sidenav-toggled');
                });
            }
        });
    </script>
</body>

</html>
