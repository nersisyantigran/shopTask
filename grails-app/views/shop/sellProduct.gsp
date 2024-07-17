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
    <div class="errors" role="alert">${flash.error}</div>
  </g:if>
  <g:form  action="selling" method="POST">
  <fieldset class="form">
    <g:hiddenField name="shopAccountingId" value="${shopAccountingId}"/>
    <g:render template="formSell"/>
  </fieldset>
  <fieldset class="buttons">
    <button style="margin-left: 20px; border: none;" title="${message(code: 'default.button.sell.label', default: 'Sell')}"><i class="fa-solid fa-money-bill-trend-up fa-2x"></i></button>
  </fieldset>
</g:form>
</body>
</html>