<%@ page import="grails.util.Environment" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>
        <g:layoutTitle default="Case Management System"/>
    </title>
    <link rel="apple-touch-icon" sizes="76x76" href="/assets/images/apple-icon.png">
    <link rel="icon" type="image/png" href="/assets/images/favicon.png">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="nucleo-icons.css"/>
    <asset:stylesheet src="nucleo-svg.css"/>
    <asset:stylesheet src="select2.min.css"/>
    <asset:stylesheet src="select2-bootstrap-5-theme.min.css"/>
    <asset:stylesheet src="select2-bootstrap-5-theme.rtl.min.css"/>
    <script src="https://kit.fontawesome.com/f3ee9c17ff.js" crossorigin="anonymous"></script>
    <asset:stylesheet id="pagestyle" src="soft-ui-dashboard.css"/>


    <asset:javascript src="application.js"/>
    <asset:javascript src="bsts.js"/>

    <asset:stylesheet src="bootstrap-datetimepicker.css"/>


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

<body class="g-sidenav-show  bg-gray-100">

<g:set var="absolutePath" value="${Environment.isDevelopmentMode() ? "/" : "/ccm/"}"/>

<aside data-color="success" class="bg-white sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-2 fixed-start ms-3"
       id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href="${absolutePath}">
            <asset:image class="system-nav-dash-logo" src="logo.png" alt="main_logo"/>
            <span class="ms-1 font-weight-bold">Case Management</span>
        </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto  max-height-vh-100 h-100" id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "DASHBOARD" ? "active" : ""}" href="${absolutePath}dashboard">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-dashboard"></i>
                    </div>
                    <span class="nav-link-text ms-1">Dashboard</span>
                </a>
            </li>
            %{--<li class="nav-item">
                <a class="nav-link ${session.activeTab == "BOOK/SELL" ? "active" : ""}" href="/busTicketAdvance">
                    <div data-color="success" class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center me-2 d-flex align-items-center justify-content-center">
                        <svg width="12px" height="12px" viewBox="0 0 45 40" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <title>BOOK/SELL</title>
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g transform="translate(-1716.000000, -439.000000)" fill="#FFFFFF" fill-rule="nonzero">
                                    <g transform="translate(1716.000000, 291.000000)">
                                        <g transform="translate(0.000000, 148.000000)">
                                            <path class="color-background opacity-6" d="M46.7199583,10.7414583 L40.8449583,0.949791667 C40.4909749,0.360605034 39.8540131,0 39.1666667,0 L7.83333333,0 C7.1459869,0 6.50902508,0.360605034 6.15504167,0.949791667 L0.280041667,10.7414583 C0.0969176761,11.0460037 -1.23209662e-05,11.3946378 -1.23209662e-05,11.75 C-0.00758042603,16.0663731 3.48367543,19.5725301 7.80004167,19.5833333 L7.81570833,19.5833333 C9.75003686,19.5882688 11.6168794,18.8726691 13.0522917,17.5760417 C16.0171492,20.2556967 20.5292675,20.2556967 23.494125,17.5760417 C26.4604562,20.2616016 30.9794188,20.2616016 33.94575,17.5760417 C36.2421905,19.6477597 39.5441143,20.1708521 42.3684437,18.9103691 C45.1927731,17.649886 47.0084685,14.8428276 47.0000295,11.75 C47.0000295,11.3946378 46.9030823,11.0460037 46.7199583,10.7414583 Z"></path>
                                            <path class="color-background" d="M39.198,22.4912623 C37.3776246,22.4928106 35.5817531,22.0149171 33.951625,21.0951667 L33.92225,21.1107282 C31.1430221,22.6838032 27.9255001,22.9318916 24.9844167,21.7998837 C24.4750389,21.605469 23.9777983,21.3722567 23.4960833,21.1018359 L23.4745417,21.1129513 C20.6961809,22.6871153 17.4786145,22.9344611 14.5386667,21.7998837 C14.029926,21.6054643 13.533337,21.3722507 13.0522917,21.1018359 C11.4250962,22.0190609 9.63246555,22.4947009 7.81570833,22.4912623 C7.16510551,22.4842162 6.51607673,22.4173045 5.875,22.2911849 L5.875,44.7220845 C5.875,45.9498589 6.7517757,46.9451667 7.83333333,46.9451667 L19.5833333,46.9451667 L19.5833333,33.6066734 L27.4166667,33.6066734 L27.4166667,46.9451667 L39.1666667,46.9451667 C40.2482243,46.9451667 41.125,45.9498589 41.125,44.7220845 L41.125,22.2822926 C40.4887822,22.4116582 39.8442868,22.4815492 39.198,22.4912623 Z"></path>
                                        </g>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </div>
                    <span class="nav-link-text ms-1">BOOK/SELL</span>
                </a>
            </li>--}%
            %{--<li class="nav-item">
                <a data-bs-toggle="collapse" href="#ticketing" class="nav-link" aria-controls="ticketing" role="button" aria-expanded="false">
                    <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center d-flex align-items-center justify-content-center  me-2">
                        <svg width="12px" height="12px" viewBox="0 0 42 42" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <title>TICKETING</title>
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g transform="translate(-1869.000000, -293.000000)" fill="#FFFFFF" fill-rule="nonzero">
                                    <g transform="translate(1716.000000, 291.000000)">
                                        <g id="office" transform="translate(153.000000, 2.000000)">
                                            <path class="color-background" d="M12.25,17.5 L8.75,17.5 L8.75,1.75 C8.75,0.78225 9.53225,0 10.5,0 L31.5,0 C32.46775,0 33.25,0.78225 33.25,1.75 L33.25,12.25 L29.75,12.25 L29.75,3.5 L12.25,3.5 L12.25,17.5 Z" opacity="0.6"></path>
                                            <path class="color-background" d="M40.25,14 L24.5,14 C23.53225,14 22.75,14.78225 22.75,15.75 L22.75,38.5 L19.25,38.5 L19.25,22.75 C19.25,21.78225 18.46775,21 17.5,21 L1.75,21 C0.78225,21 0,21.78225 0,22.75 L0,40.25 C0,41.21775 0.78225,42 1.75,42 L40.25,42 C41.21775,42 42,41.21775 42,40.25 L42,15.75 C42,14.78225 41.21775,14 40.25,14 Z M12.25,36.75 L7,36.75 L7,33.25 L12.25,33.25 L12.25,36.75 Z M12.25,29.75 L7,29.75 L7,26.25 L12.25,26.25 L12.25,29.75 Z M35,36.75 L29.75,36.75 L29.75,33.25 L35,33.25 L35,36.75 Z M35,29.75 L29.75,29.75 L29.75,26.25 L35,26.25 L35,29.75 Z M35,22.75 L29.75,22.75 L29.75,19.25 L35,19.25 L35,22.75 Z"></path>
                                        </g>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </div>
                    <span class="nav-link-text ms-1">TICKETING</span>
                </a>
                <div class="collapse ${(session.activeTab == "DAILY TRIP" || session.activeTab == "BOOKED TICKETS" || session.activeTab == "HOLD TICKET") ? 'show' : ''}" id="ticketing">
                    <ul class="nav ms-4 ps-3">
                        <li class="nav-item">
                            <a class="nav-link ${session.activeTab == "DAILY TRIP" ? "active" : ""}" href="/busTicket">
                                <span class="nav-link-text ms-1">DAILY TRIP</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${session.activeTab == "BOOKED TICKETS" ? "active" : ""}" href="/purchasedTicket">
                                <span class="nav-link-text ms-1">BOOKED TICKET</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${session.activeTab == "HOLD TICKET" ? "active" : ""}" href="/holdTicket">
                                <span class="nav-link-text ms-1">HOLD TICKET</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>--}%
            %{--<li class="nav-item">
                <a data-bs-toggle="collapse" href="#tripSetting" class="nav-link" aria-controls="tripSetting" role="button" aria-expanded="false">
                    <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center d-flex align-items-center justify-content-center  me-2">
                        <svg width="12px" height="12px" viewBox="0 0 42 42" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <title>TRIP SETTING</title>
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g transform="translate(-1869.000000, -293.000000)" fill="#FFFFFF" fill-rule="nonzero">
                                    <g transform="translate(1716.000000, 291.000000)">
                                        <g id="office" transform="translate(153.000000, 2.000000)">
                                            <path class="color-background" d="M12.25,17.5 L8.75,17.5 L8.75,1.75 C8.75,0.78225 9.53225,0 10.5,0 L31.5,0 C32.46775,0 33.25,0.78225 33.25,1.75 L33.25,12.25 L29.75,12.25 L29.75,3.5 L12.25,3.5 L12.25,17.5 Z" opacity="0.6"></path>
                                            <path class="color-background" d="M40.25,14 L24.5,14 C23.53225,14 22.75,14.78225 22.75,15.75 L22.75,38.5 L19.25,38.5 L19.25,22.75 C19.25,21.78225 18.46775,21 17.5,21 L1.75,21 C0.78225,21 0,21.78225 0,22.75 L0,40.25 C0,41.21775 0.78225,42 1.75,42 L40.25,42 C41.21775,42 42,41.21775 42,40.25 L42,15.75 C42,14.78225 41.21775,14 40.25,14 Z M12.25,36.75 L7,36.75 L7,33.25 L12.25,33.25 L12.25,36.75 Z M12.25,29.75 L7,29.75 L7,26.25 L12.25,26.25 L12.25,29.75 Z M35,36.75 L29.75,36.75 L29.75,33.25 L35,33.25 L35,36.75 Z M35,29.75 L29.75,29.75 L29.75,26.25 L35,26.25 L35,29.75 Z M35,22.75 L29.75,22.75 L29.75,19.25 L35,19.25 L35,22.75 Z"></path>
                                        </g>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </div>
                    <span class="nav-link-text ms-1">TRIP SETTING</span>
                </a>
                <div class="collapse ${(session.activeTab == "TICKET SCHEDULE"  || session.activeTab == "Ticket Fare" || session.activeTab == "TRIP") ? 'show' : ''}" id="tripSetting">
                    <ul class="nav ms-4 ps-3">
                        <li class="nav-item">
                            <a class="nav-link ${session.activeTab == "TRIP" ? "active" : ""}" href="/trips">
                                <span class="nav-link-text ms-1">TRIP</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${session.activeTab == "TICKET SCHEDULE" ? "active" : ""}" href="/busTicketTemplate">
                                <span class="nav-link-text ms-1">TICKET SCHEDULE</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${session.activeTab == "Ticket Fare" ? "active" : ""}" href="/case">
                                <span class="nav-link-text ms-1">TICKET FARE</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>--}%
           %{-- <li class="nav-item">
                <a data-bs-toggle="collapse" href="#terminal" class="nav-link" aria-controls="terminal" role="button" aria-expanded="false">
                    <div class="icon icon-shape icon-sm shadow border-radius-md bg-white text-center d-flex align-items-center justify-content-center  me-2">
                        <svg width="12px" height="12px" viewBox="0 0 42 42" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <title>TERMINAL</title>
                            <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g transform="translate(-1869.000000, -293.000000)" fill="#FFFFFF" fill-rule="nonzero">
                                    <g transform="translate(1716.000000, 291.000000)">
                                        <g id="office" transform="translate(153.000000, 2.000000)">
                                            <path class="color-background" d="M12.25,17.5 L8.75,17.5 L8.75,1.75 C8.75,0.78225 9.53225,0 10.5,0 L31.5,0 C32.46775,0 33.25,0.78225 33.25,1.75 L33.25,12.25 L29.75,12.25 L29.75,3.5 L12.25,3.5 L12.25,17.5 Z" opacity="0.6"></path>
                                            <path class="color-background" d="M40.25,14 L24.5,14 C23.53225,14 22.75,14.78225 22.75,15.75 L22.75,38.5 L19.25,38.5 L19.25,22.75 C19.25,21.78225 18.46775,21 17.5,21 L1.75,21 C0.78225,21 0,21.78225 0,22.75 L0,40.25 C0,41.21775 0.78225,42 1.75,42 L40.25,42 C41.21775,42 42,41.21775 42,40.25 L42,15.75 C42,14.78225 41.21775,14 40.25,14 Z M12.25,36.75 L7,36.75 L7,33.25 L12.25,33.25 L12.25,36.75 Z M12.25,29.75 L7,29.75 L7,26.25 L12.25,26.25 L12.25,29.75 Z M35,36.75 L29.75,36.75 L29.75,33.25 L35,33.25 L35,36.75 Z M35,29.75 L29.75,29.75 L29.75,26.25 L35,26.25 L35,29.75 Z M35,22.75 L29.75,22.75 L29.75,19.25 L35,19.25 L35,22.75 Z"></path>
                                        </g>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </div>
                    <span class="nav-link-text ms-1">TERMINAL</span>
                </a>
                <div class="collapse ${(session.activeTab == "ROUTES"  || session.activeTab == "Counters") ? 'show' : ''}" id="terminal">
                    <ul class="nav ms-4 ps-3">
                        <li class="nav-item">
                            <a class="nav-link  ${session.activeTab == "ROUTES" ? "active" : ""}" href="/route">
                                <span class="nav-link-text ms-1">ROUTES</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link   ${session.activeTab == "Counters" ? "active" : ""} " href="/counter/index">
                                <span class="nav-link-text ms-1">COUNTERS</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>--}%

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "organisation" ? "active" : ""}" href="${absolutePath}org">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-city"></i>
                    </div>
                    <span class="nav-link-text ms-1">Organisation</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "Zone" ? "active" : ""}" href="${absolutePath}zone">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-city"></i>
                    </div>
                    <span class="nav-link-text ms-1">Zone</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "circle" ? "active" : ""}" href="${absolutePath}circle">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-location-arrow"></i>
                    </div>
                    <span class="nav-link-text ms-1">Circle</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "Case" ? "active" : ""}" href="${absolutePath}case">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-legal"></i>
                    </div>
                    <span class="nav-link-text ms-1">Case</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "Users" ? "active" : ""}" href="${absolutePath}user/index">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-users-cog"></i>
                    </div>
                    <span class="nav-link-text ms-1">Users</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "settings" ? "active" : ""}" href="${absolutePath}settings/index">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-gear"></i>
                    </div>
                    <span class="nav-link-text ms-1">Settings</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${session.activeTab == "Profile" ? "active" : ""}" href="${absolutePath}${UIHelper.userDetails()}">
                    <div class="border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="fa-solid fa fa-user"></i>
                    </div>
                    <span class="nav-link-text ms-1">Profile</span>
                </a>
            </li>

        </ul>
        %{--<div class="sidenav-footer mx-3 mt-3 pt-3">
            <div class="card card-background shadow-none card-background-mask-secondary" id="sidenavCard">
                <div class="full-background"></div>
                <div class="card-body text-start p-3 w-100">
                    <div class="docs-info">
                        <h6 class="text-white up mb-0">Need help?</h6>
                        <p class="text-xs font-weight-bold">Please check our docs</p>
                        <a href="#" target="_blank" class="btn btn-white btn-sm w-100 mb-0">Documentation</a>
                    </div>
                </div>
            </div>
        </div>--}%
    </div>

</aside>


<main class="main-content position-relative max-height-vh-100 h-100 mt-1 border-radius-lg ">
    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-2 shadow-none border-radius-xl mt-2" id="navbarBlur" navbar-scroll="true">
        <div class="container-fluid py-1 px-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">${session.activeTab}</li>
                </ol>
            </nav>
            <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">


                </div>
                <ul class="navbar-nav  justify-content-end">
                    <li class="nav-item d-flex align-items-center">
                        <a href="${UIHelper.userDetails()}" class="nav-link text-body font-weight-bold px-0">
                            <i class="fa fa-user me-sm-1"></i>
                            <span class="d-sm-inline d-none"><UIHelper:memberName/></span>
                        </a>
                        <input type="hidden" id="loggedUser" name="loggedUser" value="${UIHelper.userId()}">
                    </li>
                    <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                            </div>
                        </a>
                    </li>
                    <li class="nav-item px-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0"></a>
                    </li>
                    <li class="nav-item px-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0">
                            <i class="fa fa-address-book fixed-plugin-button-nav cursor-pointer"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown pe-2 d-flex align-items-center">
                        <a  data-bs-toggle="tooltip" data-bs-placement="top"  title="Logout" href="${absolutePath}authentication/logout" class="nav-link text-body p-0">
                            <i class="fa fa-sign-out fixed-plugin-button-nav cursor-pointer"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->
    <div class="container-fluid py-2">
       <g:layoutBody/>
    </div>
</main>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered"
         style="width: 95% !important; max-width: 95%!important; height: auto; overflow-y: auto !important;max-height: 90% !important;">
        <div class="modal-content" id="myModalContent">


        </div>
    </div>
</div>


<div class="fixed-plugin">
    <div class="card shadow-lg ">
        <div class="card-header pb-0 pt-3 ">
            <div class="float-start">
                <h6 class="mt-3 mb-0">Active Users</h6>
            </div>
            <div class="float-end mt-4">
                <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
                    <i class="fa fa-close"></i>
                </button>
            </div>
        </div>
        <hr class="horizontal dark my-1">
        <div class="card-body pt-sm-3 pt-0">
            <ul class="control-sidebar-menu" id="active-chat-user-list">
                <UIHelper:activeUsersListUI/>
            </ul>
        </div>
    </div>
</div>


<asset:javascript src="bootstrap.min.js"/>
<asset:javascript src="popper.min.js"/>
<asset:javascript src="perfect-scrollbar.min.js"/>
<asset:javascript src="smooth-scrollbar.min.js"/>
<asset:javascript src="chartjs.min.js"/>
<asset:javascript src="bootstrap-notify.js"/>
<asset:javascript src="bsts.ajax.js"/>
<asset:javascript src="bsts.init.js"/>
<asset:javascript src="bsts.message.box.js"/>
<asset:javascript src="soft-ui-dashboard.js"/>
<asset:javascript src="select2.full.min.js"/>

<asset:stylesheet src="remote-idle-design.css"/>
<asset:stylesheet src="bootstrap-datetimepicker.css"/>
<asset:javascript src="moment.js"/>
<asset:javascript src="daterangepicker.js"/>
<asset:javascript src="bootstrap-datetimepicker.js"/>
<asset:javascript src="spin.js"/>
<asset:javascript src="remote-idle-app.js"/>
<asset:javascript src="sweetalert.js"/>
<asset:javascript src="jquery.validate.js"/>

<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-collapse-main')) {
        var options = {
            damping: '0.5'
        }
        Scrollbar.init(document.querySelector('#sidenav-collapse-main'), options);
    }

    $(".card-body select").select2();
    $(".advance-ticket-book-ui-header select").select2();



    var scheduleId = 0;

    $("#dtp_ScheduleEndDateStr").datetimepicker(
        {
            format: 'MMM DD, YYYY',
            minDate: moment().millisecond(0).second(0).minute(0).hour(0),
            defaultDate: ''
        });
    $("#dtp_ScheduleStartDateStr").datetimepicker(
        {
            format: 'MMM DD, YYYY',
            defaultDate: moment().millisecond(0).second(0).minute(0).hour(0)
        }).on("dp.hide", function(e) {
        if ($('#dtp_ScheduleEndDateStr').data('DateTimePicker') !== undefined) {
            $('#dtp_ScheduleEndDateStr').data('DateTimePicker').destroy();
        }
        $("#dtp_ScheduleEndDateStr").datetimepicker({ format: 'MMM DD, YYYY', minDate: e.date });
    });

</script>

<script async defer src="https://buttons.github.io/buttons.js"></script>
<asset:javascript src="soft-ui-dashboard.min.js"/>
</body>
</html>
