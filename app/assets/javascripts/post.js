 /*
       * Open the drawer when the menu ison is clicked.
       */
       var menu = document.querySelector('#menu');
       var main = document.querySelector('.view_query_chain');
       var drawer = document.querySelector('#drawer');

       menu.addEventListener('click', function(e) {
       	drawer.classList.toggle('open');
       	e.stopPropagation();
       });
       main.addEventListener('click', function() {
       	drawer.classList.remove('open');
       });