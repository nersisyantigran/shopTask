<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'warehouse.label', default: 'Warehouse')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript>
            $(document).ready(function () {
            $('#dt').DataTable({
                sScrollY: "75%",
                sScrollX: "100%",
                bProcessing: true,
                bServerSide: true,
                sAjaxSource: "/Warehouse/dataTablesRendererWarehouseAccounting/${warehouseId}",
                bJQueryUI: false,
                bAutoWidth: false,
                sPaginationType: "full_numbers",
                aLengthMenu: [5, 10, 25, 50, 100, 200],
                iDisplayLength: 10,
                "aaSorting": [[0, 'desc']],
                aoColumnDefs: [
                    {
                        createdCell: function (td, cellData, rowData, row, col) {
                            $(td).attr('style', 'color: #071C76;');
                        },
                        bSearchable: false,
                        bSortable: false,
                        visible: true,
                        aTargets: [0]
                    },
                    {
                        createdCell: function (td, cellData, rowData, row, col) {
                            $(td).attr('style', 'color: #071C76;');
                        },
                        bSearchable: true,
                        bSortable: true,
                        visible: true,
                        aTargets: [1,2]
                    },{
                        render: function (data, type, full, meta) {
                            if (full) {
                                return '<a href="${createLink(controller: 'Warehouse', action: 'deleteWarehouseAccounting')}/' + full[3] + '"class="btn"><i class="fa-regular fa-trash-can fa-2x"></i></a>';
							} else {
								return data;
							}
						},
						width: 55,
						visible: true,
						aTargets: [3],
						bSearchable: false,
						bSortable: false
					},{
						render: function (data, type, full, meta) {
							if (full) {
                                return '<a href="${createLink(controller: 'Warehouse', action: 'deliverToShop')}/' + full[4] + '"class="btn"><i class="fa-solid fa-truck-fast fa-2x"></i></a>';
							} else {
								return data;
							}
						},
						width: 55,
						visible: true,
						aTargets: [4],
						bSearchable: false,
						bSortable: false
					}
				]
			});
		});
        </g:javascript>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-warehouse" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
                <div class="errors" role="alert">${flash.error}</div>
            </g:if>
            <g:hasErrors bean="${this.warehouse}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.warehouse}" var="error">
                        <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <ol class="property-list warehouse">
                <li class="fieldcontain">
                    <span id="code-label" class="property-label">Code</span>
                    <div class="property-value" aria-labelledby="code-label"><f:display bean="warehouse" property="code"/></div>
                </li>
                <li class="fieldcontain">
                    <span id="name-label" class="property-label">Name</span>
                    <div class="property-value" aria-labelledby="name-label"><f:display bean="warehouse" property="name"/></div>
                </li>
            </ol>
            <g:form resource="${this.warehouse}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.warehouse}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <g:link class="ui-icon-plus" controller="warehouse" action="addProducts" id="${this.warehouse.id}">Add products</g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    <table class="table-bordered" id="dt">
        <thead>
        <tr>
            <th>id</th>
            <th>Product</th>
            <th>count</th>
            <th>delete</th>
            <th>deliver</th>
        </tr>
        </thead>
    </table>
    </body>
</html>
