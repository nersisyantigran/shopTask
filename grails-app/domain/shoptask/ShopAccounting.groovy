package shoptask

class ShopAccounting {

    Integer count
    Product product
    Warehouse warehouse

    static belongsTo = [shop: Shop]
    static constraints = {
    }
}
