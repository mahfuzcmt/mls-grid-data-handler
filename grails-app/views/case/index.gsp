
<meta name="layout" content="main"/>

<div class="common-list-table-view-ui col-lg-13 mt-4 col-13">
    <div class="card mb-4">
        <div class="card-header pb-0">
            <div class="row">
                <div class="col-lg-6 col-7">
                    <h6>Cases</h6>
                    <p class="text-sm mb-0">
                        <i class="fa fa-check text-info" aria-hidden="true"></i>
                        Manage Cases
                    </p>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                    <div class="btn-group">
                        <g:form controller="case" action="index" method="GET">
                            <div class="input-group" id="search-area">
                                <g:select name="colName" class="form-control" from="[status: 'STATUS']" value="${params?.colName}" optionKey="key" optionValue="value"/>
                                <UIHelper:status name="colValue" class="form-control" value="${params?.colValue}"/>
                                <span class="input-group-text text-body">
                                    <button class="btn btn-sm" type="submit"><i class="fas fa-search" aria-hidden="true"></i></button>
                                </span>
                            </div>
                        </g:form>
                    </div>

                    <div class="form-group">
                        <g:link controller="case" action="create" class="btn bg-gradient-success btn-sm pull-end"><g:message code="create"/></g:link>
                        <g:link controller="case" action="index" class="btn bg-gradient-info btn-sm pull-end"><g:message code="reload"/></g:link>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-body px-0 pb-2">
            <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                    <thead>
                    <tr>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">SL.	</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Organisation</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Commissioner</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">DC</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">AC</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">ADC</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">JC</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">RO</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Paid Revenue</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Next Hearing Date</th>
                        <th class="text-secondary opacity-7"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:if test="${casesList}">
                        <g:each in="${casesList}" var="caze">
                            <tr>
                                <td class="text-center text-sm"><span class="text-xs font-weight-bold">${caze.id}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.name}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.circle?.commissioner?.firstName} ${caze.organisation.circle?.commissioner?.lastName}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.circle?.dc?.firstName} ${caze.organisation.circle?.dc?.lastName}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.circle?.ac?.firstName} ${caze.organisation.circle?.ac?.lastName}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.circle?.adc?.firstName} ${caze.organisation.circle?.adc?.lastName}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.circle?.jc?.firstName} ${caze.organisation.circle?.jc?.lastName}</span></td>
                                <td class="text-center text-sm"><span class="">${caze.organisation.circle?.aro?.firstName} ${caze.organisation.circle?.aro?.lastName}</span></td>
                                <td class="text-center text-sm"><span class="badge badge-sm badge-primary price-amount-badge">${caze.paidRevenue}</span></td>
                                <td class="align-middle text-center text-sm"><span class="text-xs font-weight-bold"><span class="time-ticket-badge"><UIHelper:parseDateInFormat date="${caze.nextHearingDate}"/></span></td>

                                <td class="text-center">
                                    <div class="btn-group">
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top" title="Edit" controller="case" action="edit" class="btn btn-secondary" id="${caze.id}"><i class="fas fa-edit"></i></g:link>
                                        <g:link data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" controller="case" action="delete" id="${caze.id}" class="btn btn-secondary delete-confirmation"><i class="fas fa-trash"></i></g:link>
                                    </div>
                                </td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:else>
                        <g:render template="noDataFound" />
                    </g:else>
                    </tbody>
                </table>
                <div class="paginate">
                    <g:paginate total="${total ?: 0}" />
                </div>
            </div>
        </div>
    </div>
</div>



