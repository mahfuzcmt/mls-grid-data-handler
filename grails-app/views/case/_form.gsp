<%@ page import="com.bitsoft.cms.Organisation; com.bitsoft.cms.Bank; com.bitsoft.cms.Reason; com.bitsoft.cms.Challan; com.bitsoft.cms.Constant" %>
<asset:javascript src="case.js"/>
<!-- Tabs navigation -->
<ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="basic-info-tab" data-toggle="tab" href="#basic-info" role="tab" aria-controls="basic-info" aria-selected="true">Basic</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="scn-tab" data-toggle="tab" href="#scn" role="tab" aria-controls="scn" aria-selected="false">SCN</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="hearing-tab" data-toggle="tab" href="#hearing" role="tab" aria-controls="hearing" aria-selected="false">Hearing</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="judgmentOrder-tab" data-toggle="tab" href="#judgmentOrder" role="tab" aria-controls="judgmentOrder" aria-selected="false">Judgment Order</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="judgmentOrderPaid-tab" data-toggle="tab" href="#judgmentOrderPaid" role="tab" aria-controls="judgmentOrderPaid" aria-selected="false">Judgment Order Paid</a>
    </li>
</ul>

<div class="tab-content" id="myTabContent">
    <div class="tab-pane fade show active" id="basic-info" role="tabpanel" aria-labelledby="basic-info-tab">
    <!-- Basic Info Form -->
        <g:form action="[controller: 'orgCase', action: 'save']" method="post">
            <!-- Basic Info Fields -->
            <div class="form-group">
                <label><g:message code="case.file.no"/></label>
                <g:textField name="caseFileNo" class="form-control" value="${caseInstance?.caseFileNo}" placeholder="Please Enter Case File No"/>
            </div>

            <div class="form-group">
                <label><g:message code="organisation"/></label>
                <UIHelper:domainSelect class="form-control" domain="${Organisation}" name="organisation" value="${caseInstance?.organisation?.id}"/>
            </div>
            <div class="form-group">
                <label>Description</label>
                <g:textArea name="description" class="form-control" value="${caseInstance?.description}" placeholder="Please Enter Description"/>
            </div>

          %{--  <div id="banks-container">
                <h4>Banks</h4>
            <!-- Render existing bank entries if caseInstance has banks -->
                <g:each in="${caseInstance?.banks}" var="bank">
                    <div class="bank-entry" style="display: flex; flex-wrap: nowrap; align-items: center;">
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newBanks.name" value="${bank?.name}" class="form-control" placeholder="Bank Name"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newBanks.branch" value="${bank?.branch}" class="form-control" placeholder="Branch"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newBanks.address" value="${bank?.address}" class="form-control" placeholder="Address"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newBanks.accountNo" value="${bank?.accountNo}" class="form-control" placeholder="Account No"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newBanks.holderName" value="${bank?.holderName}" class="form-control" placeholder="Holder Name"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textArea name="newBanks.note" value="${bank?.note}" class="form-control" placeholder="Note"/>
                        </div>
                        <button type="button" class="btn btn-danger remove-existing-bank" style="flex: 0 0 auto;">Remove</button>
                    </div>
                </g:each>
            <!-- Hidden template for new bank entry -->
                <div class="bank-entry" id="bank-entry-template" style="display: none; flex-wrap: nowrap; align-items: center;">
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newBanks.name" class="form-control" placeholder="Bank Name"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newBanks.branch" class="form-control" placeholder="Branch"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newBanks.address" class="form-control" placeholder="Address"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newBanks.accountNo" class="form-control" placeholder="Account No"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newBanks.holderName" class="form-control" placeholder="Holder Name"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textArea name="newBanks.note" class="form-control" placeholder="Note"/>
                    </div>
                    <button type="button" class="btn btn-danger remove-bank" style="flex: 0 0 auto;">Remove</button>
                </div>
            </div>

            <button type="button" class="btn btn-primary btn-sm" id="add-bank">Add Bank</button>

            <div id="challans-container">
                <h4>Challans</h4>
            <!-- Render existing challan entries if caseInstance has challans -->
                <g:each in="${caseInstance?.challans}" var="challan">
                    <div class="challan-entry" style="display: flex; flex-wrap: nowrap; align-items: center;">
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newChallans.no" value="${challan?.no}" class="form-control" placeholder="Challan No"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textField name="newChallans.bankName" value="${challan?.bankName}" class="form-control" placeholder="Challan Bank Name"/>
                        </div>
                        <div class="form-group" style="flex: 1;">
                            <g:textArea name="newChallans.note" value="${challan?.note}" class="form-control" placeholder="Note"/>
                        </div>
                        <button type="button" class="btn btn-danger remove-existing-challan" style="flex: 0 0 auto;">Remove</button>
                    </div>
                </g:each>
            <!-- Hidden template for new challan entry -->
                <div class="challan-entry" id="challan-entry-template" style="display: none; flex-wrap: nowrap; align-items: center;">
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newChallans.no" class="form-control" placeholder="Challan No"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textField name="newChallans.bankName" class="form-control" placeholder="Challan Bank Name"/>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <g:textArea name="newChallans.note" class="form-control" placeholder="Note"/>
                    </div>
                    <button type="button" class="btn btn-danger remove-challan" style="flex: 0 0 auto;">Remove</button>
                </div>
            </div>
            <button type="button" class="btn btn-primary btn-sm" id="add-challan">Add Challan</button>--}%

            <div class="form-group">
                <label><g:message code="reasons"/></label>
                <UIHelper:domainSelect multiple="true" text="reason" class="form-control" domain="${Reason}" name="reasons" value="${caseInstance?.reasons?.id}"/>
            </div>
            <div class="form-group">
                <label>Status</label>
                <UIHelper:status value="${caseInstance}"/>
                <UIHelper:renderErrorMessage fieldName="status" model="${caseInstance}" errorMessage="please.select.type"/>
            </div>
            <div class="form-group">
                <label>Type</label>
                <UIHelper:status clazz="case-type" value="${caseInstance}" name="type" select="${Constant.CASE_TYPE}"/>
                <UIHelper:renderErrorMessage fieldName="status" model="${caseInstance}" errorMessage="please.select.type"/>
            </div>

            <div class="form-group" id="hearing-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Next Hearing Date</label>
                <input name="nextHearingDate" class="form-control" type="date" value="${caseInstance?.nextHearingDate}" id="example-datetime-local-input" onfocus="focused(this)"/>
            </div>

            <div class="form-group">
                <g:submitButton name="save" value="Save Basic" class="btn btn-primary"/>
            </div>
        </g:form>
    </div>

    <div class="tab-pane fade" id="scn" role="tabpanel" aria-labelledby="scn-tab">
    <!-- SCN Form -->
        <g:form action="[controller: 'orgCase', action: 'saveScn']" method="post">
            <!-- SCN Form Fields -->
            <div class="form-group">
                <label>Document No</label>
                <g:textField name="scn.docNo" value="${orgCase?.scn?.docNo}" class="form-control" placeholder="Enter Document No"/>
            </div>

            <div class="form-group">
                <label>Subject</label>
                <g:textArea name="scn.subject" value="${orgCase?.scn?.subject}" class="form-control" placeholder="Enter Subject"/>
            </div>

            <div class="form-group">
                <label>Status</label>
                <UIHelper:status clazz="case-status" value="" name="scn.status" select="${Constant.CASE_STATUS}"/>
                <UIHelper:renderErrorMessage fieldName="status" model="${orgCase?.scn}" errorMessage="please.select.type"/>
            </div>

            <div class="form-group">
                <label>Amount</label>
                <g:textField name="scn.amount" type="number" step="0.01" value="${orgCase?.scn?.amount}" class="form-control" placeholder="Enter Amount"/>
            </div>

            <div>
                <label>Resolved</label>
                <label class="control-label">
                    <input data-val="true"${orgCase?.scn?.isResolved == "true" ? 'checked="checked"' : ''}  data-val-required="The Value field is required." name="scn.isResolved" type="radio" value="true">
                    <span class="radio-text">Yes</span>
                </label>
                <label class="control-label">
                    <input ${orgCase?.scn?.isResolved == "false" ? 'checked="checked"' : ''} name="scn.isResolved" type="radio" value="false">
                    <span class="radio-text">No</span>
                </label>
            </div>


            <div class="form-group" id="date-container">
                <label for="example-datetime-local-input" class="form-control-label">Date</label>
                <input name="date" class="form-control" type="date" value="${caseInstance?.scn?.date}"  onfocus="focused(this)"/>
            </div>

            <div class="form-group" id="response-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Response Date</label>
                <input name="responseDate" class="form-control" type="date" value="${caseInstance?.scn?.responseDate}"  onfocus="focused(this)"/>
            </div>

            <div class="form-group" id="response-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Extended Date</label>
                <input name="extendedDate" class="form-control" type="date" value="${caseInstance?.scn?.extendedDate}"  onfocus="focused(this)"/>
            </div>

            <!-- Submit Button -->
            <div class="form-group">
                <g:submitButton name="save" value="Save SCN" class="btn btn-primary"/>
            </div>
        </g:form>

    </div>

    <div class="tab-pane fade" id="hearing" role="tabpanel" aria-labelledby="hearing-tab">
    <!-- Hearing Form -->
        <g:form action="[controller: 'orgCase', action: 'saveHearing']" method="post">


            <div class="form-group" id="hearing-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Hearing Date</label>
                <input name="hearing.date" class="form-control" type="date" value="${orgCase?.hearing?.date}"  onfocus="focused(this)"/>
            </div>

            <div class="form-group">
                <label>Status</label>
                <UIHelper:status clazz="case-status" value="" name="hearing.status" select="${Constant.CASE_STATUS}"/>
                <UIHelper:renderErrorMessage fieldName="status" model="${orgCase?.hearing}" errorMessage="please.select.type"/>
            </div>
            <div class="form-group">
                <g:submitButton name="save" value="Save Hearing" class="btn btn-primary"/>
            </div>
        </g:form>
    </div>

    <div class="tab-pane fade" id="judgmentOrder" role="tabpanel" aria-labelledby="judgmentOrder-tab">
    <!-- Judgment Order Form -->
        <g:form action="[controller: 'orgCase', action: 'saveJudgmentOrder']" method="post">
            <div class="form-group" id="hearing-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Hearing Date</label>
                <input name="judgmentOrder.date" class="form-control" type="date" value="${orgCase?.judgmentOrder?.date}"  onfocus="focused(this)"/>
            </div>
            <div class="form-group" id="extended-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Extended Date</label>
                <input name="judgmentOrder.extendedDate" class="form-control" type="date" value="${orgCase?.judgmentOrder?.extendedDate}"  onfocus="focused(this)"/>
            </div>
            <div class="form-group">
                <label>Order No</label>
                <g:textField name="judgmentOrder.orderNo" value="${orgCase?.judgmentOrder?.orderNo}" class="form-control" placeholder="Enter Order No"/>
            </div>
            <div class="form-group">
                <label>Ordered By</label>
                <g:textField name="judgmentOrder.orderedBy" value="${orgCase?.judgmentOrder?.orderedBy}" class="form-control" placeholder="Enter Ordered By"/>
            </div>
            <div class="form-group">
                <label>Status</label>
                <UIHelper:status clazz="case-status" value="" name="judgmentOrder.status" select="${Constant.CASE_STATUS}"/>
                <UIHelper:renderErrorMessage fieldName="status" model="${orgCase?.judgmentOrder}" errorMessage="please.select.type"/>
            </div>
            <div class="form-group">
                <label>Payment Status</label>
                <UIHelper:status clazz="case-status" value="" name="judgmentOrder.paymentStatus" select="${Constant.PAYMENT_STATUS}"/>
                <UIHelper:renderErrorMessage fieldName="paymentStatus" model="${orgCase?.judgmentOrder}" errorMessage="please.select.type"/>
            </div>
            <div class="form-group">
                <g:submitButton name="save" value="Save Judgment Order" class="btn btn-primary"/>
            </div>
        </g:form>
    </div>

    <div class="tab-pane fade" id="judgmentOrderPaid" role="tabpanel" aria-labelledby="judgmentOrderPaid-tab">
    <!-- Judgment Order Paid Form -->
        <g:form action="[controller: 'orgCase', action: 'saveJudgmentOrderPaid']" method="post">
            <!-- Judgment Order Paid Form Fields -->
            <div class="form-group">
                <label>Purpose</label>
                <g:textField name="judgmentOrderPaid.purpose" value="${orgCase?.judgmentOrderPaid?.purpose}" class="form-control" placeholder="Enter Purpose"/>
            </div>
            <div class="form-group">
                <label>VAT</label>
                <g:textField name="judgmentOrderPaid.vat" value="${orgCase?.judgmentOrderPaid?.vat}" class="form-control" placeholder="Enter VAT"/>
            </div>
            <div class="form-group">
                <label>Penalty</label>
                <g:textField name="judgmentOrderPaid.penalty" value="${orgCase?.judgmentOrderPaid?.penalty}" class="form-control" placeholder="Enter penalty"/>
            </div>
            <div class="form-group">
                <label>Regulatory Duty</label>
                <g:textField name="judgmentOrderPaid.regulatoryDuty" value="${orgCase?.judgmentOrderPaid?.regulatoryDuty}" class="form-control" placeholder="Enter Regulatory Duty"/>
            </div>
            <div class="form-group">
                <label>Supplementary Duty</label>
                <g:textField name="judgmentOrderPaid.supplementaryDuty" value="${orgCase?.judgmentOrderPaid?.supplementaryDuty}" class="form-control" placeholder="Enter Supplementary Duty"/>
            </div>
            <div class="form-group">
                <label>Purpose</label>
                <g:textField name="judgmentOrderPaid.purpose" value="${orgCase?.judgmentOrderPaid?.purpose}" class="form-control" placeholder="Enter purpose"/>
            </div>


            <div class="form-group" id="hearing-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Hearing Date</label>
                <input name="judgmentOrderPaid.date" class="form-control" type="date" value="${orgCase?.judgmentOrderPaid?.date}"  onfocus="focused(this)"/>
            </div>
            <div class="form-group" id="penaltyDate-date-container">
                <label for="example-datetime-local-input" class="form-control-label">Penalty Date</label>
                <input name="judgmentOrderPaid.penaltyDate" class="form-control" type="date" value="${orgCase?.judgmentOrderPaid?.penaltyDate}"  onfocus="focused(this)"/>
            </div>

            <div class="form-group">
                <label>Status</label>
                <UIHelper:status clazz="case-status" value="" name="judgmentOrderPaid.status" select="${Constant.CASE_STATUS}"/>
                <UIHelper:renderErrorMessage fieldName="status" model="${orgCase?.judgmentOrderPaid}" errorMessage="please.select.type"/>
            </div>
            <div class="form-group">
                <label>Payment Status</label>
                <UIHelper:status clazz="case-status" value="" name="judgmentOrderPaid.paymentStatus" select="${Constant.PAYMENT_STATUS}"/>
                <UIHelper:renderErrorMessage fieldName="paymentStatus" model="${orgCase?.judgmentOrderPaid}" errorMessage="please.select.type"/>
            </div>
            <div class="form-group">
                <g:submitButton name="save" value="Save Judgment Order Payment" class="btn btn-primary"/>
            </div>

            <!-- More Judgment Order Paid fields -->
        </g:form>
    </div>
</div>
