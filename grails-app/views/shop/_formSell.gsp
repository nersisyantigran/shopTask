<%@ page import="shoptask.Shop; shoptask.Product" %>

<div class="fieldcontain ${hasErrors(bean: shop, field: 'count', 'error')} required">
    <label for="count">
        <g:message code="shop.count.label" default="Count"/>
        <span class="required-indicator">*</span>
    </label>
    <input type="number" required name="sellCount" min="1" step="1"/>
</div>


