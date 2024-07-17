package shoptask

import grails.converters.JSON
import grails.transaction.Transactional
import grails.core.GrailsApplication
import grails.core.support.GrailsApplicationAware

@Transactional
class DatatablesSourceService implements GrailsApplicationAware {

    GrailsApplication grailsApplication

    def dataTablesSource(propertiesToRender, entityName, params) {
        boolean someFilter = false
        Class clazz = grailsApplication.domainClasses.find {it.clazz.simpleName == entityName}.clazz

        def filters = []
        propertiesToRender.eachWithIndex { prop, idx ->
            def sSearchField = params["sSearch_${idx}"]
            if (sSearchField != '') {
                someFilter = true
                filters << "dt.${prop} = '${sSearchField}'"
            }
            if (params.sSearch) {
                if (params["bSearchable_${idx}"] == 'true') {
                    filters << "dt.${prop} like :filter"
                }
            }
        }
        def filter = filters.join(" OR ")

        def dataToRender = [:]
        dataToRender.sEcho = params.sEcho
        dataToRender.aaData = []  // Array of data.

        dataToRender.iTotalRecords = clazz.count()
        dataToRender.iTotalDisplayRecords = dataToRender.iTotalRecords

        def query = new StringBuilder("from ${entityName} as dt where dt.id is not null")
        def appendToQuery = ""
        if (entityName == "WarehouseAccounting"){
            appendToQuery=" and warehouse_id = ${params.id}"
        } else if (entityName == "ShopAccounting"){
            appendToQuery=" and shop_id = ${params.id}"
        }

        query.append(appendToQuery)
        if (params.sSearch) {
            query.append(" and (${filter})")
        } else if (someFilter) {
            query.append(" and (${filter})")
        }
        def sortingCols = params?.iSortingCols as int
        def orderBy =  new StringBuilder()
        (0..sortingCols-1).each {
            if(it>0) {
                orderBy.append(",")
            }
            def sortDir = params["sSortDir_${it}"]?.equalsIgnoreCase('asc') ? 'asc' : 'desc'
            def sortProperty = propertiesToRender[params["iSortCol_${it}"] as int]
            orderBy.append("dt.${sortProperty} ${sortDir}")
        }
        query.append(" order by ${orderBy}")

        def records
        if (params.sSearch) {
            String sSearch = params.sSearch
            // Revise the number of total display records after applying the filter
            def countQuery = new StringBuilder("select count(*) from ${entityName} as dt where dt.id is not null")
            countQuery.append(appendToQuery).append(" and (${filter})")
            def result = clazz.executeQuery(countQuery.toString(), [filter: "%${sSearch}%"])
            if (result) {
                dataToRender.iTotalDisplayRecords = result[0]
            }
            records = clazz.findAll(query.toString(), [filter: "%${sSearch}%"], [max: params.iDisplayLength as int, offset: params.iDisplayStart as int])
        } else if (someFilter) {
            // Revise the number of total display records after applying the filter
            def countQuery = new StringBuilder("select count(*) from ${entityName} as dt where dt.id is not null")
            countQuery.append(appendToQuery).append(" and (${filter})")
            def result = clazz.executeQuery(countQuery.toString())
            if (result) {
                dataToRender.iTotalDisplayRecords = result[0]
            }
            records = clazz.findAll(query.toString(), [max: params.iDisplayLength as int, offset: params.iDisplayStart as int])
        } else {
            // Revise the number of total display records after applying the filter
            def countQuery = new StringBuilder("select count(*) from ${entityName} as dt where dt.id is not null")
            countQuery.append(appendToQuery)
            def result = clazz.executeQuery(countQuery.toString())
            if (result) {
                dataToRender.iTotalDisplayRecords = result[0]
            }
            records = clazz.findAll(query.toString(), [max: params.iDisplayLength as int, offset: params.iDisplayStart as int])
        }

        records?.each { r ->
            def data = []
            propertiesToRender.each { f ->
                data.add((r["${f}"] instanceof BigDecimal)?r["${f}"]:r["${f}"]?.toString())
            }
            dataToRender.aaData << data
        }
        return dataToRender as JSON
    }
}
