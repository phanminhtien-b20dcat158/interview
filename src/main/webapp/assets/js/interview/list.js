$(document).ready(function() {
    var table = $('#table1').DataTable({
        pageLength: 10,
        dom: "<'row'<'col-sm-6 text-left'l><'col-sm-6 text-right'f>>" +
            "<'row be-datatable-body'<'col-sm-12'tr>>" +
            "<'row be-datatable-footer'<'col-sm-5'i><'col-sm-7'p>>",
        columnDefs: [
            { orderable: false, targets: [5, 6, 7, 8] }
        ]
    });
});
