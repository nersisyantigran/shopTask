package shoptask

class Product {
    String code
    String name
    BigDecimal price
    Date productionDate
    Date expirationDate

    static constraints = {
        code(unique: true)
        expirationDate(nullable: true)
    }

    @Override
    String toString() {
        return "${id}: ${name}"
    }
}
