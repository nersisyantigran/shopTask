<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'shop.label', default: 'Shop')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
            $(document).ready(function () {
			$('#dt').DataTable({
				sScrollY: "75%",
				sScrollX: "100%",
				bProcessing: true,
				bServerSide: true,
				sAjaxSource: "/Shop/dataTablesRenderer",
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
						bSearchable: true,
						bSortable: true,
						visible: true,
						aTargets: [0,1,2]
					},{
						render: function (data, type, full, meta) {
							if (full) {
                                return '<a href="${createLink(controller: 'Shop', action: 'show')}/' + full[3] + '"class="btn"><i class="fa-solid fa-shop fa-2x">$</i></a>';
							} else {
								return data;
							}
						},
						width: 55,
						visible: true,
						aTargets: [3],
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
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
    <div style="margin: 10px">
        <h1>SHOPS</h1>
    </div>
    <table class="table-bordered" id="dt">
        <thead>
        <tr>
            <th>Code</th>
            <th>Address</th>
            <th>Name</th>
            <th></th>
        </tr>
        </thead>
    </table>
    </body>
</html>