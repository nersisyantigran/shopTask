<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'warehouse.label', default: 'Warehouse')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
</head>
<body>
<g:if test="${flash.message}">
  <div class="message" role="status">${flash.message}</div>
</g:if>
<g:if test="${flash.error}">
  <div class="error" role="alert">${flash.error}</div>
</g:if>
<g:hasErrors bean="${this.warehouseAccounting}">
  <ul class="errors" role="alert">
    <g:eachError bean="${this.warehouseAccounting}" var="error">
      <li <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
    </g:eachError>
  </ul>
</g:hasErrors>
<g:form  action="adding" method="POST">
  <g:hiddenField name="warehouseId" value="${warehouseId}" />
  <fieldset class="form">
    <g:render template="formAddProduct"/>
  </fieldset>
  <fieldset class="buttons">
    <g:submitButton name="add" class="btn btn-success" value="${message(code: 'default.button.add.label', default: 'Add')}" />
  </fieldset>
</g:form>
</body>
</html>