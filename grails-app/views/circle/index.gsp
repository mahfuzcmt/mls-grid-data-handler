%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="common-list-table-view-ui col-lg-13 mt-4 col-13">
    <div class="card mb-4">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Circles</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                       Manage Circles
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="circle" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[name: 'NAME']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <g:textField placeholder="search here" name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="circle" action="create" class="btn bg-gradient-success btn-sm pull-end"><g:message code="create"/></g:link>
                        <g:link controller="circle" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Name</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Commissioner</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">DC</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">AC</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ADC</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">JC</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">JDC</th>
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ARO</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${circles}" var="circle">
                        <tr>
                            <td class="text-sm">
                                <div class="d-flex px-2 py-1">
                                    <div class="d-flex flex-column justify-content-center">
                                        <h6 class="mb-0 text-sm">${circle.name}</h6>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.commissioner?.firstName} ${circle.commissioner?.lastName}</span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.dc?.firstName} ${circle.dc?.lastName}</span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.ac?.firstName} ${circle.ac?.lastName}</span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.adc?.firstName} ${circle.adc?.lastName}</span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.jc?.firstName} ${circle.jc?.lastName}</span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.jdc?.firstName} ${circle.jdc?.lastName}</span></td>
                            <td class="text-center text-sm"><span class="d-flex px-2 py-1 text-xs font-weight-bold">${circle.aro?.firstName} ${circle.aro?.lastName}</span></td>
                            <td class="text-center">
                                <div class="btn-group">
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Details" controller="circle" action="details" class="btn btn-secondary" id="${circle.id}"><i class="fas fa-eye"></i></g:link>
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Edit" controller="circle" action="edit" class="btn btn-secondary" id="${circle.id}"><i class="fas fa-edit"></i></g:link>
                                    <g:link data-bs-toggle="tooltip" data-bs-placement="top"  title="Delete" controller="circle" action="delete" id="${circle.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="paginate">
                    <g:paginate total="${total ?: 0}" />
                </div>
            </div>
        </div>
    </div>
</div>
