<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript>
            $(document).ready(function () {
			$('#dt').DataTable({
				sScrollY: "75%",
				sScrollX: "100%",
				bProcessing: true,
				bServerSide: true,
				sAjaxSource: "/Product/dataTablesRenderer",
				bJQueryUI: false,
				bAutoWidth: false,
				sPaginationType: "full_numbers",
				aLengthMenu: [5, 10, 25, 50, 100, 200],
				iDisplayLength: 10,
				"aaSorting": [[0, 'desc'], [1, 'asc'], [2, 'desc'],[3, 'asc'],[4, 'desc']],
				aoColumnDefs: [
					{
						render: function (data, type, full, meta) {
							if (full) {
                                return '<a href="${createLink(controller: 'Product', action: 'show')}/' + full[5] + '"class="btn"><i class="fa-brands fa-shopify fa-2x"></i></a>';
							} else {
								return data;
							}
						},
						width:55,
						visible: true,
						aTargets: [5],
						bSearchable: false,
						bSortable: true

					},	{
						render: function (data, type, full, meta) {
							if (full) {
								return '<a href="${createLink(controller: 'Product', action: 'show')}/' + full[5] + '"class="btn">' + data + '</a>';
							} else {
								return data;
							}
						},
						visible: true,
						bSearchable: true,
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
                        createdCell: function ( td, cellData, rowData, row, col) {
                            $(td).attr('style','width:100px;text-align: center;');
                        },
                        render: function (data, type, rowData, meta) {
                                    var date = data;
                                    if (date && date.length > 10) {
                                        return date.substr(0, 10);
                                    } else {
                                        return date;
                                    }
                        },
						aTargets: [3,4],
						bSearchable: true,
						visible: true,
					},
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
        <h1>PRODUCTS</h1>
    </div>
    <table class="table-bordered" id="dt">
        <thead>
        <tr>
            <th>code</th>
            <th>name</th>
            <th>price</th>
            <th>productionDate</th>
            <th>expirationDate</th>
            <th>id</th>
        </tr>
        </thead>
    </table>
    </body>
</html>