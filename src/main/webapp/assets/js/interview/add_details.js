window.onload = function() {
    var htmls1 = '<div style="margin-right: 10px" class="icon"><span class="mdi mdi-minus-circle-outline"></span></div>';
    document.querySelectorAll(".ms-elem-selection").forEach(function(element) {
        element.insertAdjacentHTML("afterbegin", htmls1);
    })

    var htmls2 = '<div style="margin-right: 10px" class="icon"><span class="mdi mdi-plus-circle-o"></span></div>';
    document.querySelectorAll(".ms-elem-selectable").forEach(function(element) {
        element.insertAdjacentHTML("afterbegin", htmls2);
    })
}
