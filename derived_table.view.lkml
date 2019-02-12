view: derived_table {
  derived_table: {
    sql: SELECT
        Date,
        max(MTD) as mtd_raw,
        max(QTD) as qtd_raw,
        max(YTD) as ytd_raw,
        sum(Sales) as total_sales,
      FROM ecomm.order_items
      GROUP BY Date
       ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date ;;
  }



  dimension: mtd_raw {
    type: number
    sql: ${TABLE}.MTD ;;
  }

  measure: mtd {
    sql: max(${mtd_raw}) ;;
  }

  dimension: qtd_raw {
    type: number
    sql: ${TABLE}.QTD ;;
  }

  measure: qtd {
    sql: max(${qtd_raw}) ;;
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.Sales ;;
  }

  measure: total_sales {
    type: sum
    value_format_name: usd
    sql: ${sales} ;;
  }

  dimension: ytd_raw {
    sql: ${TABLE}.ytd_raw ;;
  }

  measure: ytd {
    sql: max(${ytd_raw}) ;;
  }


  }
