<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
	<div class="sb-sidenav-menu">
		<div class="nav">
			<div class="sb-sidenav-menu-heading">Core</div>
			<a class="nav-link" href="index">
				<div class="sb-nav-link-icon">
					<i class="fas fa-tachometer-alt"></i>
				</div> 오탁수 처리량
			</a>
			<div class="sb-sidenav-menu-heading">Control</div>
			<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
				data-bs-target="#collapseControl" aria-expanded="false"
				aria-controls="collapseControl">
				<div class="sb-nav-link-icon">
					<i class="fas fa-cogs"></i>
				</div> 기기 제어
				<div class="sb-sidenav-collapse-arrow">
					<i class="fas fa-angle-down"></i>
				</div>
			</a>
			<div class="collapse" id="collapseControl"
				aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
				<nav class="sb-sidenav-menu-nested nav">
					<a class="nav-link" href="power">배관 밸브 제어</a> <a
						class="nav-link" href="precise">약제 투입</a>
				</nav>
			</div>
			<div class="sb-sidenav-menu-heading">Profile</div>
			<a class="nav-link" href="profile">
				<div class="sb-nav-link-icon">
					<i class="fa fa-user-circle"></i>
				</div> 회원 정보 수정
			</a>
		</div>
	</div>
	<div class="sb-sidenav-footer">
		<div class="small">Logged in as:</div>
		Start Bootstrap
	</div>
</nav>