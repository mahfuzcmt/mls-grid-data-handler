
<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        Seat Plan Update
    </div>
    <div class="card-body">
        <g:form controller="zone" action="update">
            <g:hiddenField name="id" value="${zone.id}"/>
            <g:render template="form" model="[edit:'yes']"/>
            <div class="form-action-panel">
                <g:submitButton class="btn bg-gradient-info pull-end" name="update" value="${g.message(code: "update")}"/>
                <g:link controller="zone" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>
            </div>
        </g:form>
    </div>
</div>
