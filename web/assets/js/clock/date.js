var monthNames = ["01", "02", "03", "04", "05", "06",
    "07", "08", "09", "10", "11", "12"
];
var dayNames = ["周日, ", "周一, ", "周二, ", "周三, ", "周四, ", "周五, ", "周六, "]

var newDate = new Date();
//newDate.setDate(newDate.getDate());
$('#Date').html(dayNames[newDate.getDay()] + " " + newDate.getDate() + ' /' + monthNames[newDate.getMonth()] + ' /' + newDate.getFullYear());
