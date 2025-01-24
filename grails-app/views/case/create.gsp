<meta name="layout" content="main"/>
<div class="card">
    <div class="card-header">
        Save Case
    </div>
    <div class="card-body">
        <g:form controller="case" action="save" enctype="multipart/form-data">
            <g:render template="form"/>
            <div class="form-action-panel">
               %{-- <g:submitButton class="btn bg-gradient-success pull-end" name="save" value="Save Case"/>--}%
                <g:link controller="case" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
