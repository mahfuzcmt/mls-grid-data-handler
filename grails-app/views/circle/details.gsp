%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="card card-body blur shadow-blur">
    <div class="row gx-4">
        <div class="col-auto">
            <div class="avatar avatar-xl position-relative">
                <asset:image class="w-100 border-radius-lg shadow-sm" src="man-icon-person-logo-png-clipart.png" alt="profile_image"/>
            </div>
        </div>
        <div class="col-auto my-auto">
            <div class="h-100">
                <h5 class="mb-1">
                    ${circle.name}
                </h5>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">
            <div class="nav-wrapper position-relative end-0">
                <ul class="nav nav-pills nav-fill p-1 bg-transparent" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link mb-0 px-0 py-1 active user-type" data-bs-toggle="tab" href="javascript:;" role="tab" aria-selected="true">
                            <span class="ms-1"> ${circle.commissioner?.firstName} ${circle.commissioner?.lastName}</span>
                        </a>
                    </li>
                    <div class="moving-tab position-absolute nav-link" style="padding: 0px; width: 138px; transform: translate3d(0px, 0px, 0px); transition: all 0.5s ease 0s;"><a class="nav-link mb-0 px-0 py-1 active " data-bs-toggle="tab" href="javascript:;" role="tab" aria-selected="true">-</a></div></ul>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid py-4">
    <div class="row">
        <div class="col-12 col-xl-4">
            <div class="card h-100">
                <div class="card-header pb-0 p-3">
                    <div class="row">
                        <div class="col-md-8 d-flex align-items-center">
                            <h6 class="mb-0">Circle Information</h6>
                        </div>
                        <div class="col-md-4 text-end">
                            <a href="${circle.id}">
                                <i class="fas fa-user-edit text-secondary text-sm" data-bs-toggle="tooltip" data-bs-placement="top" title="" aria-hidden="true" data-bs-original-title="Edit Profile" aria-label="Edit Profile"></i><span class="sr-only">Edit Profile</span>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="card-body p-3">
                    <hr class="horizontal gray-light my-4">
                </div>
            </div>
        </div>
    </div>
</div>

