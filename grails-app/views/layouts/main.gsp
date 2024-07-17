<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="logo.ico" type="image/x-ico"/>

    <asset:stylesheet src="application.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <g:layoutHead/>
</head>

<body>
<header style="margin: 30px">
    <div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom">
        <nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
            <g:link class="me-3 py-2 link-body-emphasis text-decoration-none" controller="product" action="index">PRODUCT</g:link>
            <g:link class="me-3 py-2 link-body-emphasis text-decoration-none" controller="warehouse" action="index">WAREHOUSE</g:link>
            <g:link class="me-3 py-2 link-body-emphasis text-decoration-none" controller="shop" action="index">SHOP</g:link>
        </nav>
    </div>
</header>
<g:layoutBody/>

<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>

<asset:javascript src="application.js"/>

</body>
</html>
