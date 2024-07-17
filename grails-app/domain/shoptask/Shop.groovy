package shoptask

class Shop {
    String code
    String name
    String address

    static hasMany = [shopAccounting: ShopAccounting]

    static constraints = {
        code(unique: true)
    }
    @Override
    String toString() {
        return "${id}: ${name}"
    }
}
