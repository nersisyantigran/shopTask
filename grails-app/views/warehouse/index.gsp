<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'warehouse.label', default: 'Warehouse')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
            $(document).ready(function () {
			$('#dt').DataTable({
				sScrollY: "75%",
				sScrollX: "100%",
				bProcessing: true,
				bServerSide: true,
				sAjaxSource: "/Warehouse/dataTablesRenderer",
				bJQueryUI: false,
				bAutoWidth: false,
				sPaginationType: "full_numbers",
				aLengthMenu: [5, 10, 25, 50, 100, 200],
				iDisplayLength: 10,
				"aaSorting": [[0, 'desc'], [1, 'asc']],
				aoColumnDefs: [
					{
						render: function (data, type, full, meta) {
							if (full) {
                                return '<a href="${createLink(controller: 'Warehouse', action: 'show')}/' + full[2] + '"class="btn"><i class="fa-solid fa-warehouse fa-2x"></i></a>';
							} else {
								return data;
							}
						},
						width: 55,
						visible: true,
						aTargets: [2],
						bSearchable: false,
						bSortable: true
					},
					{
						createdCell: function (td, cellData, rowData, row, col) {
							$(td).attr('style', 'color: #071C76;');
						},
						bSearchable: true,
						bSortable: true,
						visible: true,
						aTargets: [0,1]
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
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div style="margin: 10px">
            <h1>WAREHOUSES</h1>
        </div>
        <div id="list-warehouse" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table class="table-bordered" id="dt">
                <thead>
                <tr>
                    <th>code</th>
                    <th>name</th>
                    <th></th>
                </tr>
                </thead>
            </table>
        </div>
    </body>
</html>