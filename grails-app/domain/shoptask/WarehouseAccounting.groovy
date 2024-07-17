package shoptask

class WarehouseAccounting {

    Integer count
    Product product

    static belongsTo = [warehouse:Warehouse]
    static constraints = {
    }
}
