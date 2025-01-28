%{--
<%@ page import="com.bitsoft.mls.Circle; com.bitsoft.mls.Designation; com.bitsoft.mls.GlobalConfig" %>
<div class="form-group">
    <label><g:message code="first.name"/> *</label>
    <g:textField name="firstName" class="form-control" value="${user?.firstName}" placeholder="Please Enter First Name"/>
    <UIHelper:renderErrorMessage fieldName="firstName" model="${user}" errorMessage="please.enter.first.name"/>
</div>

<div class="form-group">
    <label><g:message code="last.name"/></label>
    <g:textField name="lastName" class="form-control" value="${user?.lastName}" placeholder="Please Last Name"/>
</div>

<div class="form-group">
    <label><g:message code="mobile"/></label>
    <g:textField name="mobile" class="form-control" value="${user?.mobile}" placeholder="Please  Mobile"/>
    <UIHelper:renderErrorMessage fieldName="firstName" model="${user}" errorMessage="please.enter.mobile"/>
</div>

<div class="form-group">
    <label><g:message code="address"/></label>
    <g:textField name="address" class="form-control" value="${user?.address}" placeholder="Please Address"/>
</div>

<div class="form-group">
    <label><g:message code="email.address"/> *</label>
    <g:field type="email" name="email" class="form-control" value="${user?.email}" placeholder="Please Enter Email"/>
    <UIHelper:renderErrorMessage fieldName="email" model="${user}" errorMessage="Your Email Address is not Valid / Already Exist in System"/>
</div>

<div class="form-group">
    <label>Designation</label>
    <UIHelper:domainSelect class="form-control" domain="${Designation}" name="designation" value="${user?.designation ? user?.designation?.id : null}"/>
</div>

--}%
%{--<div class="form-group">
    <label>Circles</label>
    <UIHelper:domainSelect multiple="true" class="form-control" domain="${Circle}" name="circles" value="${user?.circles ? user?.circles?.id : null}"/>
</div>--}%%{--


<g:if test="${!edit}">
    <div class="form-group">
        <label><g:message code="password"/> *</label>
        <g:passwordField name="password" class="form-control" value="${user?.password}" placeholder="Please Enter Password"/>
        <UIHelper:renderErrorMessage fieldName="password" model="${user}" errorMessage="Please Enter a Password."/>
    </div>
</g:if>
--}%
