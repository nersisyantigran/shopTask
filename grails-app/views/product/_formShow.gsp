<div class="fieldcontain ${hasErrors(bean: product, field: 'code', 'error')} required">
    <label for="code">
        <g:message code="product.code.label" default="Code" />
        <span>&nbsp;&nbsp;${product?.code}</span>
    </label>
</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'name', 'error')} required">
    <label for="name">
        <g:message code="product.name.label" default="Name" />
        <span>&nbsp;&nbsp;${product?.name}</span>
    </label>
</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'price', 'error')} required">
    <label for="price">
        <g:message code="product.price.label" default="Price" />
        <span>&nbsp;&nbsp;${product?.price}</span>
    </label>
</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'productionDate', 'error')} required">
    <label for="productionDate">
        <g:message code="product.productionDate.label" default="ProductionDate" />
        <span>&nbsp;&nbsp;${product?.productionDate?.toString()?.take(10)}</span>
    </label>
</div>

<div class="fieldcontain ${hasErrors(bean: product, field: 'expirationDate', 'error')} required">
    <label for="expirationDate">
        <g:message code="product.expirationDate.label" default="ExpirationDate" />
        <span>&nbsp;&nbsp;${product?.expirationDate?.toString()?.take(10)}</span>
    </label>
</div>


