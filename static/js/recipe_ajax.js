$(document).ready(function () {
    // Event listener for category clicks
    $('.category-link').on('click', function (e) {
        e.preventDefault();  // Prevent default anchor behavior
        var categoryId = $(this).data('category-id');  // Get the category ID

        // AJAX request to fetch recipes for the selected category
        $.ajax({
            url: '/recipes_by_category/' + categoryId,
            method: 'GET',
            success: function (response) {
                // Inject the recipes HTML into the container
                $('#recipe-container').html(response.recipes_html);
            },
            error: function (error) {
                console.log('Error:', error);
            }
        });
    });
});
