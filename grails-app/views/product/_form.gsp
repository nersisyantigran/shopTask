<div class="fieldcontain ${hasErrors(bean: product, field: 'code', 'error')} required">
    <label for="code">
        <g:message code="product.code.label" default="Code" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="code" required="" value="${product?.code}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="product.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" required="" value="${product?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'price', 'error')} required">
    <label for="price">
        <g:message code="product.price.label" default="Price" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="price" required="" value="${product?.price}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'productionDate', 'error')} required">
    <label for="productionDate">
        <g:message code="product.productionDate.label" default="ProductionDate" />
        <span class="required-indicator">*</span>
    </label>
    <input type="date" name="productionDate" required value="">
</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'expirationDate', 'error')} required">
    <label for="expirationDate">
        <g:message code="product.expirationDate.label" default="ExpirationDate" />
        <span class="required-indicator">*</span>
    </label>
        <input type="date" name="expirationDate" value="">
</div>


