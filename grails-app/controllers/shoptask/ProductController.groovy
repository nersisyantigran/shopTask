package shoptask
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class ProductController {

    ProductService productService
    DatatablesSourceService datatablesSourceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond productService.list(params), model: [productCount: productService.count()]
    }

    def show(Long id) {
        respond productService.get(id)
    }

    def create() {
        respond new Product(params)
    }

    def save() {
        Product product = new Product(params)
        def price = params.price as BigDecimal
        if (price <= BigDecimal.ZERO){
            product.errors.reject("The price must be greater than 0")
            respond product.errors, view: 'create'
            return
        }
        bindData(product, ['productionDate': params.date('productionDate', ['yyyy-MM-dd'])])
        bindData(product, ['expirationDate': params.date('expirationDate', ['yyyy-MM-dd'])])
        def now = new Date()
        if(product?.expirationDate && product?.productionDate?.after(product?.expirationDate)){
            product.errors.reject("Expiration Date of product[${product.expirationDate.format("yyyy-MM-dd")}] must be after than  Production Date [${product.productionDate.format("yyyy-MM-dd")}]")
            respond product.errors, view: 'create'
            return
        } else if (product?.productionDate?.after(now)){
            product.errors.reject("Production  Date of product[${product.expirationDate.format("yyyy-MM-dd")}] must be before [${now?.format("yyyy-MM-dd")}]")
            respond product.errors, view: 'create'
            return
        } else if (product?.expirationDate?.before(now)){
            product.errors.reject("Expiration  Date of product[${product.expirationDate.format("yyyy-MM-dd")}] must be afther than [${now?.format("yyyy-MM-dd")}]")
            respond product.errors, view: 'create'
            return
        }
        try {
            productService.save(product)
        } catch (ValidationException e) {
            respond product.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'product.label', default: 'Product'), product.id])
                redirect product
            }
            '*' { respond product, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond productService.get(id)
    }

    def update(Product product) {
        if (product == null) {
            notFound()
            return
        }
        def price = params.price as BigDecimal
        bindData(product, ['productionDate': params.date('productionDate', ['yyyy-MM-dd'])])
        bindData(product, ['expirationDate': params.date('expirationDate', ['yyyy-MM-dd'])])
        def now = new Date()
        if(product?.expirationDate && product?.productionDate?.after(product?.expirationDate)){
            product.errors.reject("Expiration Date of product[${product.expirationDate.format("yyyy-MM-dd")}] must be after than  Production Date [${product.productionDate.format("yyyy-MM-dd")}]")
            respond product.errors, view: 'edit'
            return
        } else if (product?.productionDate?.after(now)){
            product.errors.reject("Production  Date of product[${product.expirationDate.format("yyyy-MM-dd")}] must be before [${now?.format("yyyy-MM-dd")}]")
            respond product.errors, view: 'edit'
            return
        } else if (product?.expirationDate?.before(now)){
            product.errors.reject("Expiration  Date of product[${product.expirationDate.format("yyyy-MM-dd")}] must be afther than [${now?.format("yyyy-MM-dd")}]")
            respond product.errors, view: 'edit'
            return
        } else if (price <= BigDecimal.ZERO){
            product.errors.reject("The price must be greater than 0")
            respond product.errors, view: 'create'
            return
        }
        try {
            productService.save(product)
        } catch (ValidationException e) {
            respond product.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'product.label', default: 'Product'), product.id])
                redirect product
            }
            '*' { respond product, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        def product = productService.get(id)
        def shopAccountings = ShopAccounting.findAllByProduct(product)
        def warehouseAccounting = WarehouseAccounting.findAllByProduct(product)
        if (shopAccountings.size() > 0 || warehouseAccounting.size() > 0){
            shopAccountings.each {
                product.errors.reject("Product used in ${it.shop?.code} shope")
            }
            warehouseAccounting.each {
                product.errors.reject("Product used in ${it.warehouse?.code} warehouse")
            }
            respond product.errors, view: 'show'
            return
        }
        productService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'product.label', default: 'Product'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def dataTablesRenderer() {
        def propertiesToRender = ["code", "name", "price", "productionDate", "expirationDate", "id"]
        def entityName = 'Product'
        render datatablesSourceService.dataTablesSource(propertiesToRender, entityName, params)
    }
}
