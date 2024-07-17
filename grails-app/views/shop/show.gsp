<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'shop.label', default: 'Shop')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript>
            $(document).ready(function () {
			$('#dt').DataTable({
				sScrollY: "75%",
				sScrollX: "100%",
				bProcessing: true,
				bServerSide: true,
				sAjaxSource: "/Shop/dataTablesRendererShopAccounting/${shopId}",
				bJQueryUI: false,
				bAutoWidth: false,
				sPaginationType: "full_numbers",
				aLengthMenu: [5, 10, 25, 50, 100, 200],
				iDisplayLength: 10,
				"aaSorting": [[0, 'desc'],[2,'desc']],
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
                                return '<a href="${createLink(controller: 'Shop', action: 'sellProduct')}/' + full[3] + '"class="btn"><i class="fa-solid fa-money-bill-1-wave fa-2x"></i></a>';
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
                                return '<a href="${createLink(controller: 'Shop', action: 'returnToWarehouse')}/' + full[4] + '"class="btn"><i class="fa-solid fa-rotate-left fa-2x"></i></a>';
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
        <div id="show-shop" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
                <div class="errors" role="alert">${flash.error}</div>
            </g:if>
            <ol class="property-list shop">
                <li class="fieldcontain">
                    <span id="code-label" class="property-label">Code</span>
                    <div class="property-value" aria-labelledby="code-label"><f:display bean="shop" property="code"/></div>
                </li>
                <li class="fieldcontain">
                    <span id="name-label" class="property-label">Name</span>
                    <div class="property-value" aria-labelledby="name-label"><f:display bean="shop" property="name"/></div>
                </li>
                <li class="fieldcontain">
                    <span id="address-label" class="property-label">Address</span>
                    <div class="property-value" aria-labelledby="address-label"><f:display bean="shop" property="address"/></div>
                </li>
            </ol>
            <g:form resource="${this.shop}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.shop}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
                <th>sell</th>
                <th>return</th>
            </tr>
            </thead>
        </table>
    </body>
</html>
