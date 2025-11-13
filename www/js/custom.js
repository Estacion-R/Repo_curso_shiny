// =============================================================================
// JavaScript Personalizado - Galería de Apps Shiny Estación R
// =============================================================================

// Ejecutar cuando el DOM esté listo
$(document).ready(function() {

  // Animación de fade-in para elementos
  $('.card').addClass('fade-in');

  // Smooth scroll para navegación
  $('a[href^="#"]').on('click', function(event) {
    var target = $(this.getAttribute('href'));
    if(target.length) {
      event.preventDefault();
      $('html, body').stop().animate({
        scrollTop: target.offset().top - 70
      }, 800);
    }
  });

  // Tooltip de Bootstrap
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // Mejoras para cards con hover
  $('.card').on('mouseenter', function() {
    $(this).find('.card-footer').addClass('bg-light');
  }).on('mouseleave', function() {
    $(this).find('.card-footer').removeClass('bg-light');
  });

  // Tracking de clicks en links externos (opcional)
  $('a[target="_blank"]').on('click', function() {
    var href = $(this).attr('href');
    console.log('Click externo a: ' + href);
    // Aquí podrías agregar tracking de analytics si lo necesitas
  });

});

// Función para copiar URL al clipboard
function copyToClipboard(text) {
  navigator.clipboard.writeText(text).then(function() {
    console.log('URL copiada al portapapeles');
    // Mostrar notificación (opcional)
  }, function(err) {
    console.error('Error al copiar: ', err);
  });
}

// Función para compartir en redes sociales
function shareOnSocial(platform, url, title) {
  var shareUrl = '';

  switch(platform) {
    case 'twitter':
      shareUrl = 'https://twitter.com/intent/tweet?url=' + encodeURIComponent(url) + '&text=' + encodeURIComponent(title);
      break;
    case 'facebook':
      shareUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url);
      break;
    case 'linkedin':
      shareUrl = 'https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(url);
      break;
  }

  if(shareUrl) {
    window.open(shareUrl, '_blank', 'width=600,height=400');
  }
}
