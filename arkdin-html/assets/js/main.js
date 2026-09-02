(function ($) {
  'use strict';

  /*--------------------------------------------------------------
    Utility
  --------------------------------------------------------------*/
  $.exists = function (selector) {
    return $(selector).length > 0;
  };

  /*--------------------------------------------------------------
    Init
  --------------------------------------------------------------*/
  $(window).on('load', function () {
    preloader();
  });

  $(function () {
    mainNav();
    stickyHeader();
    dynamicBackground();
    slickInit();
    modalVideo();
    accordian();
    tabs();
    progressBar();
    review();
    if ($.exists('.wow')) new WOW().init();
    if ($.exists('.player')) $('.player').YTPlayer();
  });

  /*--------------------------------------------------------------
    1. Preloader
  --------------------------------------------------------------*/
  function preloader() {
    $('.cs_preloader').fadeOut();
    $('.cs_preloader_in').delay(150).fadeOut('slow');
  }

  /*--------------------------------------------------------------
    2. Mobile Menu
  --------------------------------------------------------------*/
  function mainNav() {
    $('.cs_nav').append('<span class="cs_menu_toggle"><span></span></span>');
    $('.menu-item-has-children').append('<span class="cs_menu_dropdown_toggle"><span></span></span>');
    $('.cs_menu_toggle').on('click', function () {
      $(this).toggleClass('cs_toggle_active').siblings('.cs_nav_list').toggleClass('cs_active');
    });
    $('body').find('.cs_side_header, .cs_toolbox').addClass('cs_has_main_nav');
    $('.cs_menu_dropdown_toggle').on('click', function () {
      $(this).toggleClass('active').siblings('ul').slideToggle();
      $(this).parent().toggleClass('active');
    });
  }

  /*--------------------------------------------------------------
    3. Sticky Header
  --------------------------------------------------------------*/
  function stickyHeader() {
    const $window = $(window);
    let lastScrollTop = 0;
    const $header = $('.cs_sticky_header');
    const headerHeight = $header.outerHeight() + 20;

    $window.on('scroll.stickyHeader', function () {
      const windowTop = $window.scrollTop();
      if (windowTop >= headerHeight) {
        $header.addClass('cs_gescout_sticky');
      } else {
        $header.removeClass('cs_gescout_sticky cs_gescout_show');
      }
      if ($header.hasClass('cs_gescout_sticky')) {
        $header.toggleClass('cs_gescout_show', windowTop < lastScrollTop);
      }
      lastScrollTop = windowTop;
    });
  }

  /*--------------------------------------------------------------
    4. Dynamic Background
  --------------------------------------------------------------*/
  function dynamicBackground() {
    $('[data-src]').each(function () {
      const src = $(this).attr('data-src');
      $(this).css({ 'background-image': `url(${src})` });
    });
  }

  /*--------------------------------------------------------------
    5. Slick Slider
  --------------------------------------------------------------*/
  function slickInit() {
    if ($.exists('.cs_slider')) {
      $('.cs_slider').each(function () {
        const $ts = $(this).find('.cs_slider_container');
        const $slickActive = $(this).find('.cs_slider_wrapper');
        let autoPlayVar = parseInt($ts.attr('data-autoplay'), 10);
        let autoplaySpdVar = autoPlayVar > 1 ? autoPlayVar : 3000;
        autoPlayVar = autoPlayVar > 1 ? 1 : autoPlayVar;

        const speedVar = parseInt($ts.attr('data-speed'), 10);
        const loopVar = Boolean(parseInt($ts.attr('data-loop'), 10));
        const centerVar = Boolean(parseInt($ts.attr('data-center'), 10));
        const variableWidthVar = Boolean(parseInt($ts.attr('data-variable-width'), 10));
        const paginaiton = $(this).find('.cs_pagination').hasClass('cs_pagination');
        let slidesPerView = $ts.attr('data-slides-per-view');

        let lgPoint = 1, mdPoint = 1, smPoint = 1, xsPoint = 1;
        if (slidesPerView === 'responsive') {
          slidesPerView = parseInt($ts.attr('data-add-slides'), 10);
          lgPoint = parseInt($ts.attr('data-lg-slides'), 10);
          mdPoint = parseInt($ts.attr('data-md-slides'), 10);
          smPoint = parseInt($ts.attr('data-sm-slides'), 10);
          xsPoint = parseInt($ts.attr('data-xs-slides'), 10);
        } else {
          slidesPerView = parseInt(slidesPerView, 10);
        }

        const fadeVar = parseInt($ts.attr('data-fade-slide')) === 1;

        $slickActive.slick({
          autoplay: autoPlayVar,
          dots: paginaiton,
          centerPadding: '28%',
          speed: speedVar,
          infinite: loopVar,
          autoplaySpeed: autoplaySpdVar,
          centerMode: centerVar,
          fade: fadeVar,
          prevArrow: $(this).find('.cs_left_arrow'),
          nextArrow: $(this).find('.cs_right_arrow'),
          appendDots: $(this).find('.cs_pagination'),
          slidesToShow: slidesPerView,
          variableWidth: variableWidthVar,
          swipeToSlide: true,
          responsive: [
            { breakpoint: 1200, settings: { slidesToShow: lgPoint } },
            { breakpoint: 992, settings: { slidesToShow: mdPoint } },
            { breakpoint: 768, settings: { slidesToShow: smPoint } },
            { breakpoint: 576, settings: { slidesToShow: xsPoint } },
          ],
        });
      });
    }

    $('.cs_service_product_thumb').slick({
      slidesToShow: 1,
      slidesToScroll: 1,
      arrows: false,
      asNavFor: '.cs_service_product_nav',
      appendDots: $('.cs_pagination_2'),
    });

    $('.cs_service_product_nav').slick({
      slidesToShow: 4,
      slidesToScroll: 1,
      asNavFor: '.cs_service_product_thumb',
      focusOnSelect: true,
      prevArrow: $('.cs_service_product_nav_left_arrow'),
      nextArrow: $('.cs_service_product_nav_right_arrow'),
      responsive: [
        { breakpoint: 1400, settings: { slidesToShow: 4 } },
        { breakpoint: 1199, settings: { slidesToShow: 3 } },
        { breakpoint: 991, settings: { slidesToShow: 2 } },
        { breakpoint: 575, settings: { slidesToShow: 1 } },
      ],
    });
  }

  /*--------------------------------------------------------------
    6. Modal Video
  --------------------------------------------------------------*/
  function modalVideo() {
    if ($.exists('.cs_video_open')) {
      $('body').append(`
        <div class="cs_video_popup">
          <div class="cs_video_popup-overlay"></div>
          <div class="cs_video_popup-content">
            <div class="cs_video_popup-layer"></div>
            <div class="cs_video_popup-container">
              <div class="cs_video_popup-align">
                <div class="embed-responsive embed-responsive-16by9">
                  <iframe class="embed-responsive-item" src="about:blank"></iframe>
                </div>
              </div>
              <div class="cs_video_popup-close"></div>
            </div>
          </div>
        </div>
      `);

      $(document).on('click', '.cs_video_open', function (e) {
        e.preventDefault();
        const video = $(this).attr('href');
        $('.cs_video_popup-container iframe').attr('src', `${video}`);
        $('.cs_video_popup').addClass('active');
      });

      $('.cs_video_popup-close, .cs_video_popup-layer').on('click', function (e) {
        e.preventDefault();
        $('.cs_video_popup').removeClass('active');
        $('html').removeClass('overflow-hidden');
        $('.cs_video_popup-container iframe').attr('src', 'about:blank');
      });
    }
  }

  /*--------------------------------------------------------------
    7. Accordian
  --------------------------------------------------------------*/
  function accordian() {
    $('.cs_accordian').children('.cs_accordian_body').hide();
    $('.cs_accordian.active').children('.cs_accordian_body').show();
    $('.cs_accordian_head').on('click', function () {
      $(this)
        .parent('.cs_accordian')
        .siblings()
        .children('.cs_accordian_body')
        .slideUp(250);
      $(this).siblings('.cs_accordian_body').slideDown(250);
      $(this).parents('.cs_accordian').addClass('active').siblings().removeClass('active');
    });
  }

  /*--------------------------------------------------------------
    8. Tabs
  --------------------------------------------------------------*/
  function tabs() {
    $('.cs_tabs .cs_tab_links a').on('click', function (e) {
      e.preventDefault();
      const currentAttrValue = $(this).attr('href');
      $('.cs_tabs ' + currentAttrValue).fadeIn(400).siblings().hide();
      $(this).parents('li').addClass('active').siblings().removeClass('active');
    });
  }

  /*--------------------------------------------------------------
    9. Progress Bar
  --------------------------------------------------------------*/
  function progressBar() {
    if ($.exists('.cs_progress')) {
      $('.cs_progress').each(function () {
        const progressPercentage = $(this).data('progress') + '%';
        $(this).find('.cs_progress_in').css('width', progressPercentage);
      });
    }
  }

  /*--------------------------------------------------------------
    10. Review
  --------------------------------------------------------------*/
  function review() {
    if ($.exists('.cs_rating')) {
      $('.cs_rating').each(function () {
        const review = $(this).data('rating');
        const reviewVal = review * 20 + '%';
        $(this).find('.cs_rating_percentage').css('width', reviewVal);
      });
    }
  }

})(jQuery);

  // Global Web3Forms AJAX Submission Handler
  document.addEventListener('submit', function(e) {
    var form = e.target;
    
    // Check if it's a web3forms form
    if (form.getAttribute('action') === 'https://api.web3forms.com/submit') {
      e.preventDefault();
      
      var submitBtn = form.querySelector('button[type="submit"]');
      var originalBtnText = submitBtn ? submitBtn.innerHTML : '';
      if (submitBtn) {
        submitBtn.innerHTML = 'Sending...';
        submitBtn.disabled = true;
      }
      
      var formData = new FormData(form);
      
      fetch('https://api.web3forms.com/submit', {
        method: 'POST',
        body: formData
      })
      .then(function(response) { return response.json(); })
      .then(function(json) {
        if (json.success) {
          var nameField = form.querySelector('[name="name"]');
          var name = nameField ? nameField.value.trim() : '';
          
          // Show beautiful popup
          showSuccessPopup(name);
          form.reset();
        } else {
          alert('Something went wrong: ' + json.message);
        }
      })
      .catch(function(error) {
        alert('Error submitting the form.');
      })
      .finally(function() {
        if (submitBtn) {
          submitBtn.innerHTML = originalBtnText;
          submitBtn.disabled = false;
        }
      });
    }
  });

  function showSuccessPopup(name) {
    var existingOverlay = document.getElementById('rqGlobalSuccessOverlay');
    if (existingOverlay) {
      existingOverlay.remove();
    }
    var html = '<div class="rq-inq-overlay is-open" id="rqGlobalSuccessOverlay" style="z-index:99999; display: flex; align-items: center; justify-content: center; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.6);">' +
               '  <div class="rq-inq-modal" style="background: #fff; border-radius: 20px; padding: 40px; max-width: 400px; width: 90%; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">' +
               '    <div style="font-size: 50px; color: #1fb141; margin-bottom: 20px;"><i class="fa-solid fa-circle-check"></i></div>' +
               '    <h3 style="margin-bottom: 15px; font-size: 26px; color: #03122b; font-weight: 700;">Message Sent!</h3>' +
               '    <p style="color: #4b5563; margin-bottom: 25px; line-height: 1.6; font-size: 16px;">Thank you' + (name ? ' <b>' + name + '</b>' : '') + '! We have received your message and will contact you shortly.</p>' +
               '    <button type="button" onclick="document.getElementById(\'rqGlobalSuccessOverlay\').remove()" style="background: #1fb141; color: #fff; border: none; padding: 12px 25px; font-size: 16px; border-radius: 30px; cursor: pointer; font-weight: 600; width: 100%; transition: all 0.3s ease;">Close</button>' +
               '  </div>' +
               '</div>';
    var div = document.createElement('div');
    div.innerHTML = html;
    document.body.appendChild(div.firstElementChild);
  }
