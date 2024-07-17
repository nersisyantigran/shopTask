package shoptask
import grails.gorm.transactions.Transactional
import grails.validation.ValidationException
import org.springframework.scheduling.annotation.Scheduled


@Transactional
class ScheduledTaskService {
    ShopAccountingService shopAccountingService
    WarehouseAccountingService warehouseAccountingService

    @Scheduled(cron = "0 10 0 1/1 * ?")
     def returnExpiredProducts(){
        def today = new Date()
        def expiredShopAccountings = ShopAccounting.executeQuery('from ShopAccounting sa where sa.product.expirationDate <= :today and sa.count > 0',[today: today])
        expiredShopAccountings.each {expired->
            def warehouseAccounting = WarehouseAccounting.findByWarehouseAndProduct(expired.warehouse, expired.product)
            try {
                warehouseAccounting.count+=expired.count
                warehouseAccountingService.save(warehouseAccounting)
                try {
                    expired.count = 0
                    shopAccountingService.save(expired)

                } catch (ValidationException e) {
                    log.error("Failed to save expired ShopAccounting: ${expired.errors}", e)
                    throw new RuntimeException("Failed to save expired ShopAccounting", e)
                }
            } catch (ValidationException e) {
                log.error("Failed to save WarehouseAccounting: ${warehouseAccounting.errors}", e)
                throw new RuntimeException("Failed to save WarehouseAccounting", e)
            }
        }
    }
}
