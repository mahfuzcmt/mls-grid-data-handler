<div class="modal-header">
  <h5 class="modal-title" id="myModalLabel">
    <span class="col-md-10">
      Add  User Access
    </span>
  </h5>
  <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body" modal-type="normal">
  <form class="form-horizontal" id="saveAppAccessForm" method="post" data-modalprefix="my" role="form" action="/Admin/AppAccess/Save" novalidate="novalidate">


    <div class="validation-summary text-danger validation-summary-valid" data-valmsg-summary="true"><ul><li style="display:none"></li>
    </ul></div>
    <input id="hasValue" name="hasValue" type="hidden" value="True">
    <input name="page" id="page" type="hidden" value="1">
    <input name="isSaveAndAdd" id="isSaveAndAdd" type="hidden" value="False">
    <input name="isSaveAndEdit" id="isSaveAndEdit" type="hidden" value="False">
    <input id="isModal" name="isModal" type="hidden" value="True">

    <div class="table-responsive">
      <table id="userAccessTable" class="table table-bordered table-hover">
        <thead>
        <tr>
          <th class="align-center">Menu</th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkFullAll" class="header ckbHeader">Full Permission
            </label>
          </th>


          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkListViewAll" class="header ckbHeader">&nbsp;List View
            </label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;"><input type="checkbox" id="chkAddAll" class="header ckbHeader">&nbsp;Add</label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkEditAll" class="header ckbHeader">&nbsp;Edit
            </label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkDeActiveAll" class="header ckbHeader" value="value" checked="'checked'">&nbsp;DeActive
            </label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkDeleteAll" class="header ckbHeader">&nbsp;Delete
            </label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkDetailsAll" class="header ckbHeader">&nbsp;Details
            </label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkReportAll" class="header ckbHeader">&nbsp;Report
            </label>
          </th>
          <th class="align-center">
            <label class="control-label" style="cursor: pointer;">
              <input type="checkbox" id="chkActiveAll" class="header ckbHeader">&nbsp; Active
            </label>
          </th>
        </tr>
        </thead>
        <tbody>
        <tr class="dataItem" data-tr-id="1" data-tr-parent-id="">

          <td class="align-left">

            <span class="glyphicon glyphicon-folder-open" aria-hidden="true">&nbsp;</span>
            <input id="z0__Id" name="[0].Id" type="hidden" value="6117b4c4c12c522a039748f7">
            <input data-val="true" data-val-required="The AccessId field is required." id="z0__AccessId" name="[0].AccessId" type="hidden" value="35618">
            BOOK/SELL
            <input data-val="true" data-val-required="The MenuId field is required." id="z0__MenuId" name="[0].MenuId" type="hidden" value="1">
            <input data-val="true" data-val-required="The MenuOrder field is required." id="z0__MenuOrder" name="[0].MenuOrder" type="hidden" value="1">
            <input data-val="true" data-val-required="The MenuType field is required." id="z0__MenuType" name="[0].MenuType" type="hidden" value="SubModule">
            <input id="z0__UserId" name="[0].UserId" type="hidden" value="35618">
            <input data-val="true" data-val-required="The RoleId field is required." id="z0__RoleId" name="[0].RoleId" type="hidden" value="13">
            <input data-val="true" data-val-required="The AccessLevel field is required." id="z0__AccessLevel" name="[0].AccessLevel" type="hidden" value="User">
            <input data-val="true" data-val-required="The AccessType field is required." id="z0__AccessType" name="[0].AccessType" type="hidden" value="Menu">
            <input id="z0__BranchId" name="[0].BranchId" type="hidden" value="4">
            <input data-val="true" data-val-required="The ModuleId field is required." id="z0__ModuleId" name="[0].ModuleId" type="hidden" value="Ticketing">

          </td>

          <td class="align-center">
            <input checked="checked" class="chkFullAll submodule" data-id="1" data-parent-id="" data-type="Full" data-val="true" data-val-required="The IsFull field is required." id="z0__IsFull" name="[0].IsFull" type="checkbox" value="true">
          </td>
          <td class="align-center">
          <input checked="checked" class="chkListViewAll submodule" data-id="1" data-parent-id="" data-type="View" data-val="true" data-val-required="The IsList field is required." id="z0__IsList" name="[0].IsList" type="checkbox" value="true">
        </td>
          <td class="align-center">
            <input checked="checked" class="chkAddAll submodule" data-id="1" data-parent-id="" data-type="Add" data-val="true" data-val-required="The IsAdd field is required." id="z0__IsAdd" name="[0].IsAdd" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkEditAll submodule" data-id="1" data-parent-id="" data-type="Edit" data-val="true" data-val-required="The IsEdit field is required." id="z0__IsEdit" name="[0].IsEdit" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDeActiveAll submodule" data-id="1" data-parent-id="" data-type="DeActive" data-val="true" data-val-required="The IsDeActive field is required." id="z0__IsDeActive" name="[0].IsDeActive" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDeleteAll submodule" data-id="1" data-parent-id="" data-type="Delete" data-val="true" data-val-required="The IsDelete field is required." id="z0__IsDelete" name="[0].IsDelete" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDetailsAll submodule" data-id="1" data-parent-id="" data-type="Details" data-val="true" data-val-required="The IsDetail field is required." id="z0__IsDetail" name="[0].IsDetail" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkReportAll submodule" data-id="1" data-parent-id="" data-type="Report" data-val="true" data-val-required="The IsReport field is required." id="z0__IsReport" name="[0].IsReport" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkActiveAll submodule" data-id="1" data-parent-id="" data-type="Active" data-val="true" data-val-required="The IsActive field is required." id="z0__IsActive" name="[0].IsActive" type="checkbox" value="true">
          </td>
        </tr>

        <tr class="dataItem" data-tr-id="2" data-tr-parent-id="">

          <td class="align-left">

            <span class="glyphicon glyphicon-folder-open" aria-hidden="true">&nbsp;</span>
            <input id="z1__Id" name="[1].Id" type="hidden" value="6117b4c4c12c522a039748f9">
            <input data-val="true" data-val-required="The AccessId field is required." id="z1__AccessId" name="[1].AccessId" type="hidden" value="35618">
            Ticketing
            <input data-val="true" data-val-required="The MenuId field is required." id="z1__MenuId" name="[1].MenuId" type="hidden" value="2">
            <input data-val="true" data-val-required="The MenuOrder field is required." id="z1__MenuOrder" name="[1].MenuOrder" type="hidden" value="2">
            <input data-val="true" data-val-required="The MenuType field is required." id="z1__MenuType" name="[1].MenuType" type="hidden" value="SubModule">
            <input id="z1__UserId" name="[1].UserId" type="hidden" value="35618">
            <input data-val="true" data-val-required="The RoleId field is required." id="z1__RoleId" name="[1].RoleId" type="hidden" value="13">
            <input data-val="true" data-val-required="The AccessLevel field is required." id="z1__AccessLevel" name="[1].AccessLevel" type="hidden" value="User">
            <input data-val="true" data-val-required="The AccessType field is required." id="z1__AccessType" name="[1].AccessType" type="hidden" value="Menu">
            <input id="z1__BranchId" name="[1].BranchId" type="hidden" value="4">
            <input data-val="true" data-val-required="The ModuleId field is required." id="z1__ModuleId" name="[1].ModuleId" type="hidden" value="None">

          </td>

          <td class="align-center">
            <input checked="checked" class="chkFullAll submodule" data-id="2" data-parent-id="" data-type="Full" data-val="true" data-val-required="The IsFull field is required." id="z1__IsFull" name="[1].IsFull" type="checkbox" value="true">

          </td><td class="align-center">
          <input checked="checked" class="chkListViewAll submodule" data-id="2" data-parent-id="" data-type="View" data-val="true" data-val-required="The IsList field is required." id="z1__IsList" name="[1].IsList" type="checkbox" value="true">
        </td>
          <td class="align-center">
            <input checked="checked" class="chkAddAll submodule" data-id="2" data-parent-id="" data-type="Add" data-val="true" data-val-required="The IsAdd field is required." id="z1__IsAdd" name="[1].IsAdd" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkEditAll submodule" data-id="2" data-parent-id="" data-type="Edit" data-val="true" data-val-required="The IsEdit field is required." id="z1__IsEdit" name="[1].IsEdit" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDeActiveAll submodule" data-id="2" data-parent-id="" data-type="DeActive" data-val="true" data-val-required="The IsDeActive field is required." id="z1__IsDeActive" name="[1].IsDeActive" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDeleteAll submodule" data-id="2" data-parent-id="" data-type="Delete" data-val="true" data-val-required="The IsDelete field is required." id="z1__IsDelete" name="[1].IsDelete" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDetailsAll submodule" data-id="2" data-parent-id="" data-type="Details" data-val="true" data-val-required="The IsDetail field is required." id="z1__IsDetail" name="[1].IsDetail" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkReportAll submodule" data-id="2" data-parent-id="" data-type="Report" data-val="true" data-val-required="The IsReport field is required." id="z1__IsReport" name="[1].IsReport" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkActiveAll submodule" data-id="2" data-parent-id="" data-type="Active" data-val="true" data-val-required="The IsActive field is required." id="z1__IsActive" name="[1].IsActive" type="checkbox" value="true">
          </td>
        </tr>

        <tr class="dataItem" data-tr-id="3" data-tr-parent-id="2">
          <td class="align-left">

            <span style="padding-left: 30px;" class="glyphicon glyphicon-link" aria-hidden="true">&nbsp;</span>
            <input id="z2__Id" name="[2].Id" type="hidden" value="6117b4c4c12c522a039748fb">
            <input data-val="true" data-val-required="The AccessId field is required." id="z2__AccessId" name="[2].AccessId" type="hidden" value="35618">
            SEARCH TICKETS
            <input data-val="true" data-val-required="The MenuId field is required." id="z2__MenuId" name="[2].MenuId" type="hidden" value="3">
            <input data-val="true" data-val-required="The MenuOrder field is required." id="z2__MenuOrder" name="[2].MenuOrder" type="hidden" value="1">
            <input data-val="true" data-val-required="The MenuType field is required." id="z2__MenuType" name="[2].MenuType" type="hidden" value="Menu">
            <input id="z2__UserId" name="[2].UserId" type="hidden" value="35618">
            <input data-val="true" data-val-required="The RoleId field is required." id="z2__RoleId" name="[2].RoleId" type="hidden" value="13">
            <input data-val="true" data-val-required="The AccessLevel field is required." id="z2__AccessLevel" name="[2].AccessLevel" type="hidden" value="User">
            <input data-val="true" data-val-required="The AccessType field is required." id="z2__AccessType" name="[2].AccessType" type="hidden" value="Menu">
            <input id="z2__BranchId" name="[2].BranchId" type="hidden" value="4">
            <input data-val="true" data-val-required="The ModuleId field is required." id="z2__ModuleId" name="[2].ModuleId" type="hidden" value="None">

          </td>
          <td class="align-center">
            <input checked="checked" class="chkFullAll menu" data-id="3" data-parent-id="2" data-type="Full" data-val="true" data-val-required="The IsFull field is required." id="z2__IsFull" name="[2].IsFull" type="checkbox" value="true">

          </td>
          <td class="align-center">
          <input checked="checked" class="chkListViewAll menu" data-id="3" data-parent-id="2" data-type="View" data-val="true" data-val-required="The IsList field is required." id="z2__IsList" name="[2].IsList" type="checkbox" value="true">
        </td>
          <td class="align-center">
            <input checked="checked" class="chkAddAll menu" data-id="3" data-parent-id="2" data-type="Add" data-val="true" data-val-required="The IsAdd field is required." id="z2__IsAdd" name="[2].IsAdd" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkEditAll menu" data-id="3" data-parent-id="2" data-type="Edit" data-val="true" data-val-required="The IsEdit field is required." id="z2__IsEdit" name="[2].IsEdit" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDeActiveAll menu" data-id="3" data-parent-id="2" data-type="DeActive" data-val="true" data-val-required="The IsDeActive field is required." id="z2__IsDeActive" name="[2].IsDeActive" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDeleteAll menu" data-id="3" data-parent-id="2" data-type="Delete" data-val="true" data-val-required="The IsDelete field is required." id="z2__IsDelete" name="[2].IsDelete" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkDetailsAll menu" data-id="3" data-parent-id="2" data-type="Details" data-val="true" data-val-required="The IsDetail field is required." id="z2__IsDetail" name="[2].IsDetail" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkReportAll menu" data-id="3" data-parent-id="2" data-type="Report" data-val="true" data-val-required="The IsReport field is required." id="z2__IsReport" name="[2].IsReport" type="checkbox" value="true">
          </td>
          <td class="align-center">
            <input checked="checked" class="chkActiveAll menu" data-id="3" data-parent-id="2" data-type="Active" data-val="true" data-val-required="The IsActive field is required." id="z2__IsActive" name="[2].IsActive" type="checkbox" value="true">
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <asset:javascript src="app-access.js"/>

  </form>
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
