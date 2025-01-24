%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="common-list-table-view-ui col-lg-13 mt-4 col-13">
    <div class="card mb-4">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Users</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Operate this section with the corresponding UI
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="user" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[name: 'NAME']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <g:textField placeholder="search here" name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="user" action="create" class="btn bg-gradient-success btn-sm pull-end"><g:message code="create"/></g:link>
                        <g:link controller="user" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
       %{-- <div class="card-body px-0 pb-2">
            <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Name</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Email</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Mobile</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No of assigned Circle</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${memberList}" var="info">
                        <tr>
                            <td class="text-sm">
                                <div class="d-flex px-2 py-1">
                                    <div>
                                        <asset:image class="avatar avatar-sm me-3" src="man-icon-person-logo-png-clipart.png" alt="man_logo"/>
                                    </div>
                                    <div class="d-flex flex-column justify-content-center">
                                        <h6 class="mb-0 text-sm">${info.firstName} ${info.lastName}</h6>
                                        <p class="text-xs text-secondary mb-0">${info.designation?.name}</p>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold"> ${info.email} </span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold"> ${info.mobile} </span></td>
                            <td class="text-center text-sm"><span class="">${info.circles.size()}</span></td>
                            <td class="text-center text-sm"><span class="badge badge-sm  ${info?.isActive ?  "bg-gradient-success" :  "bg-gradient-secondary"}">${info.isActive ? "Active" : "Inactive"}</span></td>
                            <td class="text-center">
                                <div class="btn-group">
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Details" controller="user" action="details" class="btn btn-secondary" id="${info.id}"><i class="fas fa-eye"></i></g:link>
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Edit" controller="user" action="edit" class="btn btn-secondary" id="${info.id}"><i class="fas fa-edit"></i></g:link>
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Delete" controller="user" action="delete" id="${info.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                                </div>
                                <div class="btn-group">
                                    <span class="btn btn-info btn-edd" title="Permission" onclick="createModal('/user/userPermissions?userId=${info.id}', '1', 'my');">
                                        <i class="fa fa-gears"></i>
                                        <span class="btn-icon-text"></span>
                                    </span>
--}%%{--                                    <span class="btn btn-info btn-edd" title="Access" onclick="createModal('/user/userAccess?userId=${info.id}', '1', 'my');">--}%%{--
--}%%{--                                        <i class="fa fa-gear"></i>--}%%{--
--}%%{--                                        <span class="btn-icon-text">--}%%{--
--}%%{--                                        </span>--}%%{--
--}%%{--                                    </span>--}%%{--
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Reset Password"   data-toggle="modal" data-target="#passResetModal" data-whatever="@getbootstrap"  id="${info.id}" class="btn btn-secondary"><i class="fa fa-user-secret"></i></g:link>

                                    <div class="modal fade" id="passResetModal" tabindex="-1" role="dialog" aria-labelledby="passResetModalLabel" aria-hidden="true">
                                        <div class="modal-dialog" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Change Password (${info?.firstName} ${info?.lastName})</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true"></span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                   <g:form controller="user" action="updatePassword">
                                                       <input name="id" type="hidden" value="${info?.id}">
                                                        <div class="form-group">
                                                            <input type="password" class="form-control is-valid" name="password" placeholder="Enter New Password" required>
                                                            <div class="invalid-feedback">Please fill out this field.</div>
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="password"  class="form-control is-valid" name="confirmPassword" placeholder="Confirm new password" required>
                                                            <div class="invalid-feedback">Please fill out this field.</div>
                                                        </div>
                                                       <div class="form-action-panel">
                                                           <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                           <g:submitButton class="btn bg-gradient-success pull-end" name="updatePassword" value="Change"/>

                                                       </div>
                                                   </g:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                 </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="paginate">
                    <g:paginate total="${total ?: 0}" />
                </div>
            </div>
        </div>--}%
    </div>
</div>
