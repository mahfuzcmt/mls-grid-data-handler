<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Bus Ticket Booking System"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>

    <script type="text/javascript">
        BSTS.baseURL = "${UIHelper.appBaseURL()}";
        <g:if test="${flash?.message && flash?.message?.info}">
        jQuery(document).ready(function () {
            BSTS.messageBox.showMessage(Boolean(${flash.message?.success}), "${flash.message?.info}");
        });
        </g:if>
    </script>

    <g:layoutHead/>
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark rounded">
        <a class="navbar-brand brand_name menu_font_detail home-logout" href="/">
            <span class=" nav-active ">DASHBOARD</span>
        </a>

        <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
            <ul class="navbar-nav dashboard_nav me-auto mb-2 mb-lg-0 menu_font_detail">
                <li class="nav-item">
                    <a class="nav-link menu_font_detail" aria-current="page" href="/coach">
                        <span class="">COACH</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link menu_font_detail" aria-current="page" href="/zone">
                        <span class="">SEAT MAP</span>
                    </a>
                </li>

                <li class="nav-item dropdown">
                    <UIHelper:systemServicesActionMenu/>
                </li>
                <li class="nav-item">
                    <a class="nav-link menu_font_detail" aria-current="page" href="/user-reports">
                        <span class="">USER REPORTS</span>
                    </a>
                </li>
            </ul>
        </div>

        <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse"
                data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        %{--User Action Menu--}%
        <ul class="navbar-nav ml-auto">
            <UIHelper:userActionMenu/>

        </ul>
    </nav>
</header>


<div class="container-fluid">
    <div class="row">
        <main role="main" class="list-view-container col-sm-9 ml-sm-auto col-md-10 pt-3">
            <g:layoutBody/>
        </main>
    </div>
</div>

</body>
</html>
