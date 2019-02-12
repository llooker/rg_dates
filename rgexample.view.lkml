view: dates {
  sql_table_name: rob.RGExample ;;

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

  dimension: Join_Key {
    sql: ${TABLE}.Date;;
  }



  dimension: mtd_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.MTD ;;
  }

  measure: mtd {
    type: number
    sql: max(${mtd_raw}) ;;
    value_format_name: usd
  }

  dimension: qtd_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.QTD ;;
  }

  measure: qtd {
    type: number
    sql: max(${qtd_raw}) ;;
    value_format_name: usd
  }

  dimension: sales {
    hidden: yes
    type: number
    sql: ${TABLE}.Sales ;;
  }

  measure: total_sales {
    type: sum
    value_format_name: usd
    sql: ${sales} ;;
  }

  dimension: ytd_raw {
    hidden: yes
    sql: ${TABLE}.YTD ;;
  }

  measure: ytd {
    type: number
    sql: max(${ytd_raw}) ;;
    value_format_name: usd
  }

}
