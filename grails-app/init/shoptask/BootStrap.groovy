package shoptask

class BootStrap {
    ScheduledTaskService scheduledTaskService
    def init = { servletContext ->
        scheduledTaskService.returnExpiredProducts()
    }
    def destroy = {
    }
}
