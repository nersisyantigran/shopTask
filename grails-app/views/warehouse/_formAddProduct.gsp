<%@ page import="shoptask.Product" %>
<div class="fieldcontain ${hasErrors(bean: warehouseAccounting, field: 'product', 'error')} required">
    <label for="name">
        <g:message code="warehouse.product.label" default="Product"/>
        <span class="required-indicator">*</span>
    </label>
    <g:select id="product"
              name="product"
              from="${Product.list()}"
              optionKey="id"
              required=""
              value=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: warehouseAccounting, field: 'count', 'error')} required">
    <label for="count">
        <g:message code="warehouse.count.label" default="Count"/>
        <span class="required-indicator">*</span>
    </label>
    <input type="number" name="count" min="1" step="1"/>
</div>


