<div class="fieldcontain ${hasErrors(bean: warehouse, field: 'code', 'error')} required">
    <label for="code">
        <g:message code="warehouse.code.label" default="Code" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="code" required="" value="${warehouseInstance?.code}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: warehouse, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="warehouse.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${warehouse?.name}"/>

</div>
