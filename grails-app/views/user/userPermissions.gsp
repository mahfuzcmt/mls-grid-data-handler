
<div class="modal-header">
    <h5 class="modal-title" id="myModalLabel">
        <span class="col-md-10">
           Add User Permission - ${userName}
        </span>
    </h5>
    <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body" modal-type="normal">
   <g:form controller="user" action="saveUserPermission" method="post" role="form" data-modalprefix="my" class="form-horizontal user-access-form" >
        <input name="page" id="page" type="hidden" value="1">
        <input id="userId" name="userId" type="hidden" value="${userId}">

        <div class="table-responsive add-user-permission-wrapper">
            <table id="trainingTable" class="table table-default table-hover">
                <thead>
                <tr>
                    <th>
                        <label class="control-label required" >Key</label>
                    </th>
                    <th>
                        <label class="control-label required">Value</label>
                    </th>

                </tr>
                </thead>
                <tbody>
%{--                <tr>--}%
%{--                    <td>Sale Other Counter Ticket Permission</td>--}%
%{--                    <td>--}%
%{--                        <div>--}%
%{--                            <g:set var="saleOtherCounterTicketPermission" value="${UIHelper.getUserPermissionStatus(permissionKey: "saleOtherCounterTicketPermission", userId: userId)}"/>--}%
%{--                            <label class="control-label">--}%
%{--                                <input ${saleOtherCounterTicketPermission == "true" ? 'checked="checked"' : ''}  data-val="true" data-val-required="The Value field is required." name="permission.saleOtherCounterTicketPermission" type="radio" value="true">--}%
%{--                                <span class="radio-text">Yes</span>--}%
%{--                            </label>--}%
%{--                            <label class="control-label">--}%
%{--                                <input ${saleOtherCounterTicketPermission == "false" ? 'checked="checked"' : ''} name="permission.saleOtherCounterTicketPermission" type="radio" value="false">--}%
%{--                                <span class="radio-text">No</span>--}%
%{--                            </label>--}%
%{--                        </div>--}%
%{--                    </td>--}%
%{--                </tr>--}%
                <tr>
                    <td>Manage Organisation</td>
                    <td>
                        <div>
                            <g:set var="manageOrg" value="${UIHelper.getUserPermissionStatus(permissionKey: "manageOrg", userId: userId)}"/>
                            <label class="control-label">
                                <input data-val="true"${manageOrg == "true" ? 'checked="checked"' : ''}  data-val-required="The Value field is required." name="permission.manageOrg" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input ${manageOrg == "false" ? 'checked="checked"' : ''} name="permission.manageOrg" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Manage Users</td>
                    <td>
                        <div>
                            <g:set var="manageUser" value="${UIHelper.getUserPermissionStatus(permissionKey: "manageUser", userId: userId)}"/>
                            <label class="control-label">
                                <input ${manageUser == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.manageUser" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${manageUser == "false" ? 'checked="checked"' : ''}  name="permission.manageUser" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Manage Zone</td>
                    <td>
                        <div>
                            <g:set var="manageZone" value="${UIHelper.getUserPermissionStatus(permissionKey: "manageZone", userId: userId)}"/>
                            <label class="control-label">
                                <input ${manageZone == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.manageZone" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${manageZone == "false" ? 'checked="checked"' : ''}  name="permission.manageZone" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Manage Circle</td>
                    <td>
                        <div>
                            <g:set var="manageCircle" value="${UIHelper.getUserPermissionStatus(permissionKey: "manageCircle", userId: userId)}"/>
                            <label class="control-label">
                                <input ${manageCircle == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.manageCircle" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${manageCircle == "false" ? 'checked="checked"' : ''}  name="permission.manageCircle" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>Mange Settings</td>
                    <td>
                        <div>
                            <g:set var="manageSettings" value="${UIHelper.getUserPermissionStatus(permissionKey: "manageSettings", userId: userId)}"/>
                            <label class="control-label">
                                <input ${manageSettings == "true" ? 'checked="checked"' : ''} data-val="true" data-val-required="The Value field is required." name="permission.manageSettings" type="radio" value="true">
                                <span class="radio-text">Yes</span>
                            </label>
                            <label class="control-label">
                                <input  ${manageSettings == "false" ? 'checked="checked"' : ''}  name="permission.manageSettings" type="radio" value="false">
                                <span class="radio-text">No</span>
                            </label>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
   </g:form>

    <div class="modal-footer">
        <div id="saveBtnModalContainer">
            <button type="button" class="btn btn-dropbox" id="btnCommonModalSave" onclick="saveRecord(this, 'user-access-form');">Save</button>
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">Close</button>
        </div>
    </div>

</div>
<script>
    $("#saveBtnContainer").hide();
</script>
