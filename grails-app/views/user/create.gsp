<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        <g:message code="user" args="['Create']"/>
    </div>
    <div class="card-body">
        <g:form controller="user" action="save">

            <g:render template="form"/>
            <div class="form-action-panel">
                <g:submitButton class="btn bg-gradient-success pull-end" name="save" value="ADD"/>
                <g:link controller="user" id="kanban-cancel-item" action="index" class="btn bg-gradient-light pull-end me-2"><g:message code="cancel"/></g:link>

            </div>
        </g:form>
    </div>
</div>
