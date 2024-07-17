<div class="fieldcontain ${hasErrors(bean: shop, field: 'code', 'error')} required">
    <label for="code">
        <g:message code="shop.code.label" default="Code" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="code" required="" value="${shop?.code}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: shop, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="shop.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${shop?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: shop, field: 'address', 'error')} required">
    <label for="address">
        <g:message code="shop.address.label" default="Address" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="address" required="" value="${shop?.address}"/>
</div>
