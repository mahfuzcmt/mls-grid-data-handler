<%@ page import="com.bitsoft.mls.GlobalConfig" %>
<div class="form-group">
    <label><g:message code="Name"/></label>
    <g:textField name="name" class="form-control" value="${zone?.name}" placeholder="Enter zone name"/>
</div>
<div class="form-group">
    <label>Zone No</label>
    <g:textField name="zoneNo" class="form-control" value="${zone?.zoneNo}" placeholder="Enter zone no"/>
</div>
<div class="form-group">
    <label>Address</label>
    <g:textArea name="address" class="form-control" value="${zone?.address}" placeholder="Enter zone address"/>
</div>

