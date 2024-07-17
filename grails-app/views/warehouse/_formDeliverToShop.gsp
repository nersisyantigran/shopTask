<%@ page import="shoptask.Shop; shoptask.Product" %>
<div class="fieldcontain ${hasErrors(bean: warehouseAccounting, field: 'shop', 'error')} required">
    <label for="shop">
        <g:message code="warehouseAccounting.shop.label" default="shop"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="shop"
              name="shop"
              from="${Shop.list()}"
              optionKey="id"
              required=""
              value=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: warehouseAccounting, field: 'count', 'error')} required">
    <label for="count">
        <g:message code="warehouseAccounting.count.label" default="Count"/>
        <span class="required-indicator">*</span>
    </label>
    <input type="number" required="" name="count" min="1" step="1"/>
</div>


