<%@ page import="com.bitsoft.cms.User; com.bitsoft.cms.Zone; com.bitsoft.cms.Circle; com.bitsoft.cms.Designation; com.bitsoft.cms.GlobalConfig" %>
<div class="form-group">
    <label><g:message code="name"/> *</label>
    <g:textField name="name" class="form-control" value="${circle?.name}" placeholder="Please Enter Name"/>
    <UIHelper:renderErrorMessage fieldName="name" model="${circle}" errorMessage="please.name"/>
</div>

<div class="form-group">
    <label>Zone</label>
    <UIHelper:domainSelect class="form-control" domain="${Zone}" name="zone" value="${circle?.zone ? user?.zone?.id : null}"/>
</div>

<div class="form-group">
    <label>Commissioner</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("Commissioner")) }}"  domain="${User}" name="commissioner" value="${circle?.commissioner ? circle?.commissioner?.id : null}"/>
</div>
<div class="form-group">
    <label>AC</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("AC")) }}" domain="${User}" name="ac" value="${circle?.ac ? circle?.ac?.id : null}"/>
</div>
<div class="form-group">
    <label>ADC</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("ADC")) }}" domain="${User}" name="adc" value="${circle?.adc ? circle?.adc?.id : null}"/>
</div>

<div class="form-group">
    <label>DC</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("DC")) }}" domain="${User}" name="dc" value="${circle?.dc ? circle?.dc?.id : null}"/>
</div>
<div class="form-group">
    <label>JDC</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("JDC")) }}" domain="${User}" name="jdc" value="${circle?.jdc ? circle?.jdc?.id : null}"/>
</div>
<div class="form-group">
    <label>JC</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("JC")) }}" domain="${User}" name="jc" value="${circle?.jc ? circle?.jc?.id : null}"/>
</div>
<div class="form-group">
    <label>RO</label>
    <UIHelper:domainSelect class="form-control" text="firstName" filter="${ { eq("designation", Designation.findByName("ARO")) }}" domain="${User}" name="aro" value="${circle?.aro ? circle?.aro?.id : null}"/>
</div>