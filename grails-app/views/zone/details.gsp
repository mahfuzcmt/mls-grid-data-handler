<meta name="layout" content="main"/>
<div class="card">
    <div class="card-header">
        Zone -  ${zone.name}
    </div>
    <div class="card-body">
        <div class="seat-design-map-ui">
        <div class="row">
            <div class="col-md-offset-7 col-md-4 col-sm-offset-7 col-sm-4 col-xs-offset-7 col-xs-4 bus-steering-wheel">
                <i class="fa fa-steering-wheel"></i>
            </div>
        </div>
        <g:if test="${zone}">
           Coming...
        </g:if>
        </div>
        <div class="form-action-panel top-right-corner">
            <g:link controller="zone" action="index" class="btn btn-secondary">Back</g:link>
        </div>
    </div>
</div>
