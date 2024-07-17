package shoptask

import grails.gorm.services.Service
import grails.gorm.transactions.Transactional

@Service(WarehouseAccounting)
interface WarehouseAccountingService {

    WarehouseAccounting get(Serializable id)

    List<WarehouseAccounting> list(Map args)

    Long count()

    void delete(Serializable id)

    WarehouseAccounting save(WarehouseAccounting warehouseAccounting)
}
