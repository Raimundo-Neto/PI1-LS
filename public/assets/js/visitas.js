google.charts.load('current', {packages: ['corechart', 'bar']});
google.charts.setOnLoadCallback(drawColColors);

function drawColColors() {
    var data = new google.visualization.DataTable();
    data.addColumn('timeofday', 'Time of Day');
    data.addColumn('number', 'Agosto');
    data.addColumn('number', 'Setembro');

    data.addRows([
        [{v: [1,0,0], f:''}, 5, 7],
        [{v: [2, 0, 0], f: ''}, 2, .5],
        [{v: [3, 0, 0], f:''}, 3, 1],
        [{v: [4, 0, 0], f: ''}, 4, 2.25],
        [{v: [5, 0, 0], f: ''}, 5, 2.25],
        [{v: [6, 0, 0], f: ''}, 6, 3],
        [{v: [7, 0, 0], f: ''}, 7, 4],


    ]);

    var options = {
        title: 'Visitas no mês Agosto (X)  Visitas no mês Setembro',
        colors: ['#f4511e', '#33ac71'],
        hAxis: {
            title: 'Dias do Mes',
            format: 'd/m',
            viewWindow: {
                min: [0],
                max: [8]
            }
        },
        vAxis: {
            title: 'Rating (scale of 1-10)'
        }
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
    chart.draw(data, options);
}
