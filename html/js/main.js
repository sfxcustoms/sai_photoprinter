$(function () {
    function display(bool) {
        if (bool) {
            $("#showImage").show();
        } else {
            $("#showImage").hide();
        }
    }

    display(false)

    window.addEventListener('message', function (event) {
        var item = event.data;
        display(false)
        if (item.type === "showImage") {
            if (item.status == true) {
                display(true)
                document.getElementById("imgcontainer").innerHTML = '<img class="contain" style="width:80rem;height:80rem;" src="' + item.image + '" alt="' + item.image + '"></img>';
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post(`https://sai_photoprinter/ShowImageCallback`, JSON.stringify({}));
            return
        }
    };
})
