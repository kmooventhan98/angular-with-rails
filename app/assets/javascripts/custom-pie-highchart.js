function generate_pie_chart(div_id, SubCategories, entries ){
  var div_id = "#" + div_id ;

  var entries = entries ;

  $(div_id).highcharts({
    chart: {
      type: "pie",
      height: 300
    },
    title: {
      text: $(div_id).data("name")
    },
    subtitle: {
      text: entries + pluralize(' Entry', entries, false)
    },
    tooltip: {
      pointFormat: "{point.percentage:.1f}%"
    },
    plotOptions: {
      series: {
        cursor: "pointer",
        dataLabels: {
          enabled: true,
          format: "{point.name}<br>({point.y} {point.entry_lbl}, {point.percentage:.1f}%)"
        },
        showInLegend: false
      }
    },
    series: [
      {
        type: "pie",
        name: div_id,
        data: SubCategories
      }
    ],
    exporting: {
      enabled: false
    },
    credits: {
      enabled: false
    }
  });
}