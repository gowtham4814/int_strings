$(document).ready(function() {
    const post = $('#post').text().trim();
    const topic = $('#topic').text().trim();
    $.ajax({
        type: 'POST',
        headers: {
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
        },
        url: 'http://127.0.0.1:3000/topics/' + topic + '/posts/' + post + '/read_post',
    });
});
$(document).ready(function() {
    $("#checked").on("click", function() {
        this.value = 0;
        $("#form").submit();
    });
});

$(document).ready(function() {
    $('.edit-button').click(function() {
        var $comment = $(this).closest('.comment');
        $(this).parent().parent().hide();
        $comment.find('.edit').show();
    });
    $('.back-button').click(function() {
        $(this).parent().parent().hide();
        $(this).parent().parent().prev('.view').show();
    });
});

const radioButtons = document.querySelectorAll('input[type="radio"]');
radioButtons.forEach(radioButton => {
    radioButton.addEventListener('click', () => {
        const form = radioButton.closest('form');
        form.submit();
    });
});
