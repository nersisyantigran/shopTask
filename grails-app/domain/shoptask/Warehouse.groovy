package shoptask

class Warehouse {
    String code
    String name

    static hasMany = [warehouseAccounting: WarehouseAccounting]

    static constraints = {
        code(unique: true)
    }
    @Override
    String toString() {
        return "${id}: ${name}"
    }
}

