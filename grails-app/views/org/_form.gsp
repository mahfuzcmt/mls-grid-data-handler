<%@ page import="com.bitsoft.cms.Circle; com.bitsoft.cms.Organisation; com.bitsoft.cms.Bank; com.bitsoft.cms.Reason; com.bitsoft.cms.Challan; com.bitsoft.cms.Constant" %>
<div class="form-group">
    <label><g:message code="name"/></label>
    <g:textField name="name" class="form-control" value="${organisation?.name}" placeholder="Please Enter Name"/>
</div>
<div class="form-group">
    <label><g:message code="address"/></label>
    <g:textArea name="address" class="form-control" value="${organisation?.address}" placeholder="Please Enter Address"/>
</div>
<div class="form-group">
    <label>GB</label>
    <g:textField name="gb" class="form-control" value="${organisation?.gb}" placeholder="Please Enter GB"/>
</div>
<div class="form-group">
    <label>BIN</label>
    <g:textField name="bin" class="form-control" value="${organisation?.bin}" placeholder="Please Enter BIN"/>
</div>
<div class="form-group">
    <label>Status</label>
    <UIHelper:status value="${organisation}"/>
    <UIHelper:renderErrorMessage fieldName="status" model="${organisation}" errorMessage="please.select.status"/>
</div>

<div class="form-group">
    <label>Circle</label>
    <UIHelper:domainSelect class="form-control" domain="${Circle}" name="circle" value="${organisation?.circle?.id}"/>
</div>

