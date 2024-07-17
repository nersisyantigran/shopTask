package shoptask

import grails.gorm.services.Service

@Service(ShopAccounting)
interface ShopAccountingService {

    ShopAccounting get(Serializable id)

    List<ShopAccounting> list(Map args)

    Long count()

    void delete(Serializable id)

    ShopAccounting save(ShopAccounting shopAccounting)
}
