view: derived_table {
  derived_table: {
    sql: SELECT
        Date,
        max(MTD) as mtd_raw,
        max(QTD) as qtd_raw,
        max(YTD) as ytd_raw,
        max(Sales) as total_sales
      FROM rob.RGExample
      GROUP BY Date
       ;;
  }

  dimension_group: date {
     hidden: yes
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

  dimension: Join_Key_Raw {
    hidden: yes
    sql: ${TABLE}.Date;;
  }

  dimension: Join_Key {
    hidden: yes
    sql: DATE_ADD(${Join_Key_Raw}, INTERVAL 1 YEAR) ;;
  }

  dimension: mtd_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.mtd_raw ;;
  }

  measure: mtd {
    group_label: "LY Sales Metrics"
    label: "LY MTD"
    type: number
    sql: max(${mtd_raw}) ;;
    value_format_name: usd
  }

  dimension: qtd_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.qtd_raw ;;
  }

  measure: qtd {
    group_label: "LY Sales Metrics"
    label: "LY QTD"
    type: number
    sql: max(${qtd_raw}) ;;
    value_format_name: usd
  }

  dimension: sales {
    hidden: yes
    type: number
    sql: ${TABLE}.total_sales ;;
  }

  measure: LY_total_sales {
    group_label: "LY Sales Metrics"
    label: "LY Total Sales"
    type: sum
    value_format_name: usd
    sql: ${sales} ;;
  }

#   measure: LY_total_sales {
#     label: "LY Total Sales"
#     type: number
#     value_format_name: usd
#     sql: max(${sales}) ;;
#   }


  dimension: ytd_raw {
    hidden: yes
    sql: ${TABLE}.ytd_raw ;;
  }

  measure: ytd {
    group_label: "LY Sales Metrics"
    label: "LYTD"
    type: number
    sql: max(${ytd_raw}) ;;
    value_format_name: usd
  }


  }
