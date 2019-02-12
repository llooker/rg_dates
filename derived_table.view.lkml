view: derived_table {
  derived_table: {
    sql: SELECT
        Date,
        max(MTD) as mtd_raw,
        max(QTD) as qtd_raw,
        max(YTD) as ytd_raw,
        sum(Sales) as total_sales
      FROM rob.RGExample
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
    sql: ${TABLE}.mtd_raw ;;
  }

  measure: mtd {
    type: number
    sql: max(${mtd_raw}) ;;
    value_format_name: usd
  }

  dimension: qtd_raw {
    type: number
    sql: ${TABLE}.qtd_raw ;;
  }

  measure: qtd {
    type: number
    sql: max(${qtd_raw}) ;;
    value_format_name: usd
  }

  dimension: sales {
    type: number
    sql: ${TABLE}.total_sales ;;
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
    type: number
    sql: max(${ytd_raw}) ;;
    value_format_name: usd
  }


  }
