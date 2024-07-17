package shoptask

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class WarehouseController {

    WarehouseService warehouseService
    WarehouseAccountingService warehouseAccountingService
    ShopAccountingService shopAccountingService
    DatatablesSourceService datatablesSourceService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond warehouseService.list(params), model: [warehouseCount: warehouseService.count()]
    }

    def show(Long id) {
        respond warehouseService.get(id), model: [warehouseId: id]
    }

    def create() {
        respond new Warehouse(params)
    }

    def save(Warehouse warehouse) {
        if (warehouse == null) {
            notFound()
            return
        }

        try {
            warehouseService.save(warehouse)
        } catch (ValidationException e) {
            respond warehouse.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'warehouse.label', default: 'Warehouse'), warehouse.id])
                redirect warehouse
            }
            '*' { respond warehouse, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond warehouseService.get(id)
    }

    def update(Warehouse warehouse) {
        if (warehouse == null) {
            notFound()
            return
        }

        try {
            warehouseService.save(warehouse)
        } catch (ValidationException e) {
            respond warehouse.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'warehouse.label', default: 'Warehouse'), warehouse.id])
                redirect warehouse
            }
            '*' { respond warehouse, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        def warehouse = warehouseService.get(id)
        def warehouseAccountings = WarehouseAccounting?.findAllByWarehouse(warehouse)
        def shopAccountings = ShopAccounting?.findAllByWarehouse(warehouse)
        if (warehouseAccountings?.size() > 0){
            flash.error = "Can not delete because Warehouse has Warehouse accountings"
            redirect(action: 'show', id: id)
            return
        } else if (shopAccountings?.size() > 0){
            flash.error = "Can not delete because Warehouse used in Shop accountings"
            redirect(action: 'show', id: id)
            return
        }

        warehouseService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'warehouse.label', default: 'Warehouse'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'warehouse.label', default: 'Warehouse'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }

    def addProducts(Long id) {
        [warehouseId: id]
    }

    def adding() {
        def warehouse = Warehouse.get(params.warehouseId)
        def product = Product.get(params.product)
        def now = new Date()
        if (!product){
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'product.label', default: 'Product'), params.product])
            redirect(action: "show", id: params.warehouseId)
        } else if (!warehouse){
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'warehouse.label', default: 'Warehouse'), params.warehouseId])
            redirect(action: "show", id: params.warehouseId)
        } else if (params.int("count") <= 0){
            flash.error = "The count must be greater than zero"
            redirect(action: "show", id: params.warehouseId)
        } else {
            def warehouseAccounting = WarehouseAccounting.findByWarehouseAndProduct(warehouse, product)
            if (warehouseAccounting) {
                warehouseAccounting?.count += params.int("count")
                try {
                    warehouseAccountingService.save(warehouseAccounting)
                    flash.message = "${params.int("count")} ${product?.name} aded"
                    redirect(action: "addProducts", id: params.warehouseId)
                } catch (ValidationException e) {
                    respond warehouseAccounting.errors, view: 'show'
                    return
                }
            } else {
                warehouseAccounting = new WarehouseAccounting()
                warehouseAccounting.product = product
                warehouseAccounting.warehouse = warehouse
                warehouseAccounting.count = params.int("count")
                try {
                    warehouseAccountingService.save(warehouseAccounting)
                    flash.message = "${params.int("count")} ${product?.name} aded"
                    redirect(action: "addProducts", id: params.warehouseId)
                } catch (ValidationException e) {
                    respond warehouseAccounting.errors, view: 'show'
                    return
                }
            }
        }
    }

    def dataTablesRenderer() {
        def propertiesToRender = ["code", "name","id"]
        def entityName = 'Warehouse'
        render datatablesSourceService.dataTablesSource(propertiesToRender, entityName, params)
    }

    def dataTablesRendererWarehouseAccounting() {
        def propertiesToRender = ["id", "product", "count", "id", "id"]
        def entityName = 'WarehouseAccounting'
        render datatablesSourceService.dataTablesSource(propertiesToRender, entityName, params)
    }


    def deleteWarehouseAccounting(Long id) {
        if (id == null) {
            notFound()
            return
        }
        Warehouse warehouse = WarehouseAccounting.get(id).warehouse
        warehouseAccountingService.delete(id)
        redirect(action: "show", id: warehouse?.id)
    }

    def deliverToShop(Long id) {
        [warehouseAccountingId: id]
    }

    def delivering() {
        def shop = Shop?.get(params.long("shop"))
        def warehouseAccounting = WarehouseAccounting.get(params.long("warehouseAccountingId"))
        def product = warehouseAccounting.product
        def shopAccounting = ShopAccounting.findByShopAndProductAndWarehouse(shop, product,warehouseAccounting?.warehouse)
        if (!warehouseAccounting){
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'warehouseAccounting.label', default: 'WarehouseAccounting'), params.warehouseAccountingId])
            redirect(action: "show", id: params.warehouseId)
        } else if (!shop){
            flash.error = message(code: 'default.not.found.message', args: [message(code: 'shop.label', default: 'Shop'), params.shop])
            redirect(action: "show", id: params.warehouseId)
        } else if (!params.int("count") || params.int("count") < 0 || params.int("count") > warehouseAccounting.count){
            flash.error = "There are not so much products you xan deliver maximum ${warehouseAccounting.count} products"
            redirect(action: "deliverToShop", id: params.warehouseAccountingId)
        } else{
            if (shopAccounting) {
                try {
                    shopAccounting.count += params.int("count")
                    shopAccountingService.save(shopAccounting)
                    try {
                        warehouseAccounting.count -= params.int("count")
                        warehouseAccountingService.save(warehouseAccounting)
                        redirect(action: "show", id: warehouseAccounting?.warehouse?.id)
                    } catch (ValidationException e) {
                        respond warehouseAccounting.errors, view: 'show'
                        return
                    }
                } catch (ValidationException e) {
                    respond shopAccounting.errors, view: 'show'
                    return
                }
            } else {
                shopAccounting = new ShopAccounting()
                shopAccounting.product = product
                shopAccounting.shop = shop
                shopAccounting.warehouse = warehouseAccounting?.warehouse
                shopAccounting.count = params.int("count")
                try {
                    shopAccountingService.save(shopAccounting)
                    try {
                        warehouseAccounting.count -= params.int("count")
                        warehouseAccountingService.save(warehouseAccounting)
                        redirect(action: "show", id: warehouseAccounting?.warehouse?.id)
                    } catch (ValidationException e) {
                        respond warehouseAccounting.errors, view: 'show'
                        return
                    }
                } catch (ValidationException e) {
                    respond shopAccounting.errors, view: 'show'
                    return
                }
            }
        }
    }
}
