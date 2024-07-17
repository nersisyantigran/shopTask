<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta name="layout" content="main"/>
      <g:set var="entityName" value="${message(code: 'warehouse.label', default: 'Warehouse')}"/>
      <title><g:message code="default.create.label" args="[entityName]"/></title>
  </head>

  <body>
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
    <g:form action="delivering" method="POST">
        <fieldset class="form">
            <g:hiddenField name="warehouseAccountingId" value="${warehouseAccountingId}"/>
            <g:render template="formDeliverToShop"/>
        </fieldset>
        <fieldset class="buttons">
            <button style="margin-left: 20px; border: none;"
                    title="${message(code: 'default.button.deliver.label', default: 'Deliver')}"><i
                    class="fa-solid fa-truck-fast fa-2x"></i></button>
        </fieldset>
    </g:form>
  </body>
</html>