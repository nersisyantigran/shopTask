package shoptask

import grails.validation.ValidationException
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import static org.springframework.http.HttpStatus.*

class ShopController {

    private static final Logger LOGGER = LoggerFactory.getLogger(ShopController.class)
    ShopService shopService
    ShopAccountingService shopAccountingService
    WarehouseAccountingService warehouseAccountingService
    DatatablesSourceService datatablesSourceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond shopService.list(params), model: [shopCount: shopService.count()]
    }

    def show(Long id) {
        respond shopService.get(id), model: [shopId: id]
    }

    def create() {
        respond new Shop(params)
    }

    def save(Shop shop) {
        if (shop == null) {
            notFound()
            return
        }

        try {
            shopService.save(shop)
        } catch (ValidationException e) {
            respond shop.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'shop.label', default: 'Shop'), shop.id])
                redirect shop
            }
            '*' { respond shop, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond shopService.get(id)
    }

    def update(Shop shop) {
        if (shop == null) {
            notFound()
            return
        }

        try {
            shopService.save(shop)
        } catch (ValidationException e) {
            respond shop.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'shop.label', default: 'Shop'), shop.id])
                redirect shop
            }
            '*' { respond shop, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        def shop = shopService.get(id)
        def shopAccountings = ShopAccounting?.findAllByShop(shop)
        if (shopAccountings?.size() > 0){
            flash.error = "Can not delete because Shop has Shop accountings"
            redirect(action: 'show', id: id)
            return
        }

        shopService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'shop.label', default: 'Shop'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'shop.label', default: 'Shop'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def dataTablesRenderer() {
        def propertiesToRender = ["code", "address", "name", "id"]
        def entityName = 'Shop'
        render datatablesSourceService.dataTablesSource(propertiesToRender, entityName, params)
    }
    def dataTablesRendererShopAccounting() {
        def propertiesToRender = ["id", "product", "count", "id", "id"]
        def entityName = 'ShopAccounting'
        render datatablesSourceService.dataTablesSource(propertiesToRender, entityName, params)
    }

    def sellProduct(Long id) {
        [shopAccountingId: id]
    }

    def selling() {
        def shopAccounting = ShopAccounting.get(params?.long("shopAccountingId"))
        if (shopAccounting) {
            if (params.int("sellCount") && params.int("sellCount") > 0) {
                shopAccounting.count -= params.int("sellCount")
                try {
                    shopAccountingService.save(shopAccounting)
                    redirect(action: "show", id: shopAccounting?.shop?.id)
                } catch (ValidationException e) {
                    respond shopAccounting.errors, view: 'sellProduct'
                    return
                }
            } else {
                flash.error = "Sell Count must be a number greater than zero"
                redirect(action: "sellProduct", id: shopAccounting?.id)
            }
        } else {
            notFound()
            return
        }
    }

    def returnToWarehouse(Long id) {
        [shopAccountingId: id]
    }

    def returnProduct() {
        def shopAccounting = ShopAccounting.get(params?.long("shopAccountingId"))
        if (shopAccounting) {
            def warehouseAccounting = WarehouseAccounting.findByWarehouseAndProduct(shopAccounting?.warehouse, shopAccounting.product)
            if (!warehouseAccounting){
                flash.error = "Return Count must be a number greater than zero and not greater than ${shopAccounting?.count}"
                redirect(action: "returnToWarehouse", id: shopAccounting?.shop?.id)
                return
            }
            if (!params?.int("returnCount") || params?.int("returnCount") > shopAccounting?.count || params?.int("returnCount") <= 0 ){
                flash.error = "Return Count must be a number greater than zero and not greater than ${shopAccounting?.count}"
                redirect(action: "returnToWarehouse", id: shopAccounting?.shop?.id)
                return
            }
            shopAccounting.count -= params?.int("returnCount")
                try {
                    shopAccountingService.save(shopAccounting)
                    warehouseAccounting.count += params?.int("returnCount")
                    try {
                        warehouseAccountingService.save(warehouseAccounting)
                        redirect(action: "show", id: shopAccounting?.shop?.id)
                    } catch (ValidationException e) {
                        respond warehouseAccounting.errors, view: 'show'
                        return
                    }
                } catch (ValidationException e) {
                    respond shopAccounting.errors, view: 'show'
                    return
                }
        } else {
            notFound()
            return
        }
    }
}
