
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../assets/img/favicon.png">
    <title>Case Management System</title>

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="nucleo-icons.css"/>
    <asset:stylesheet src="nucleo-svg.css"/>
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <asset:stylesheet id="pagestyle" src="soft-ui-dashboard.css"/>

</head>

<body class="bg-gray-100">
<!-- Extra details for Live View on GitHub Pages -->
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
<!-- Navbar -->
<nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent mt-4">

</nav>
<!-- End Navbar -->
<main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('/assets/srimty-shoudh.jpg'); background-size: auto;">
        <span class="mask bg-gradient-dark opacity-5"></span>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 text-center mx-auto">
                    <h1 class="text-white mb-2 mt-5">Welcome!</h1>
                    <p class="text-lead text-white">Use these forms to login in your system.</p>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row mt-lg-n10 mt-md-n11 mt-n10 justify-content-center">
            <div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
                <div class="card z-index-0">
                    <div class="card-header text-center pt-4">
                        <h5>Sign in</h5>
                    </div>
                    <div class="row px-xl-5 px-sm-4 px-3"> Please sign in to enjoy your day! </div>
                    <div class="card-body">

                      <g:form controller="authentication" action="doLogin" role="form" class="text-start">
                            <div class="mb-3">
                                <input name="email" type="email" class="form-control" placeholder="Email" aria-label="Email"  required="required">
                            </div>
                            <div class="mb-3">
                                <input  name="password" type="password" class="form-control" placeholder="Password" aria-label="Password" required="required">
                            </div>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <div class="text-center">
                                <button  type="submit" class="btn bg-gradient-info w-100 my-4 mb-2">Sign in</button>
                            </div>
                           %{-- <div class="text-center">
                                <g:link class="blue-text ml-1" controller="authentication" action="registration" >Sign Up</g:link>
                            </div>--}%
                      </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- -------- START FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
<footer class="footer py-5">
    <div class="container">
        <div class="row">
            <div class="col-8 mx-auto text-center mt-1">
                <p class="mb-0 text-secondary">
                    Copyright © <script>
                    document.write(new Date().getFullYear())
                </script> Software by <a href="https://bitSoft-bd.com" target="_blank">bitSoft</a>
                </p>
            </div>
        </div>
    </div>
</footer>

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

<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
        var options = {
            damping: '0.5'
        }
        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
</script>

<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
<asset:javascript src="soft-ui-dashboard.min.js"/>
</body>

</html>
