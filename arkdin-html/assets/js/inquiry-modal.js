/* =====================================================
   RQ Air Conditioning — Inquiry / Quote Popup
   Injects the premium two-column quote popup on every
   page, binds all "Inquire" buttons, handles
   open/close/submit. Design CSS: assets/css/inquiry-modal.css
   ===================================================== */
(function () {
  'use strict';

  /* =====================================================
     MODAL MARKUP (matches inquiry-modal.css exactly)
     ===================================================== */
  var POPUP_HTML =
    '<div class="rq-popup-overlay" id="rqPopupOverlay" role="dialog" aria-modal="true" aria-labelledby="rqFormTitle">' +

    '<div class="rq-popup">' +

    '<button type="button" class="rq-popup-close" id="rqPopupClose" aria-label="Close Popup">' +
    '<i class="fa-solid fa-xmark"></i>' +
    '</button>' +

    /* ---------- LEFT SIDE ---------- */
    '<div class="rq-popup-left">' +

    '<div class="rq-brand">' +
'<img class="rq-logo-img" src="assets/img/logo.svg" alt="Arkdin Air Conditioning Logo">' +
    '</div>' +

    '<div class="rq-tagline">Cooling Comfort. Everyday.</div>' +

    '<div class="rq-popup-image">' +
    '<img src="https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=1000&q=90" alt="RQ Air Conditioning HVAC Technician">' +
    '</div>' +

    '<div class="rq-left-heading">' +
    '<h3>Reliable Cooling Solutions<br><span>for Every Space</span></h3>' +
    '</div>' +

    '<div class="rq-contact-list">' +

    '<div class="rq-contact-box">' +
    '<div class="rq-contact-icon"><i class="fa-solid fa-phone"></i></div>' +
    '<div class="rq-contact-text">' +
    '<span>Call Us</span>' +
    '<strong>+91 98193 76325</strong>' +
    '</div>' +
    '</div>' +

    '<div class="rq-contact-box">' +
    '<div class="rq-contact-icon"><i class="fa-regular fa-envelope"></i></div>' +
    '<div class="rq-contact-text">' +
    '<span>Email Us</span>' +
    '<strong>rqairconditioning@gmail.com</strong>' +
    '</div>' +
    '</div>' +

    '<div class="rq-contact-box">' +
    '<div class="rq-contact-icon"><i class="fa-solid fa-location-dot"></i></div>' +
    '<div class="rq-contact-text">' +
    '<span>Service Area</span>' +
    '<strong>Panvel, Navi Mumbai</strong>' +
    '</div>' +
    '</div>' +

    '</div>' +
    '</div>' +

    /* ---------- RIGHT SIDE FORM ---------- */
    '<div class="rq-popup-right">' +

    '<h2 class="rq-form-title" id="rqFormTitle">Request a Quote</h2>' +

    '<p class="rq-form-intro">Tell us about your cooling or HVAC service requirement and our team will get back to you shortly.</p>' +

    '<form class="rq-form" id="rqQuoteForm" novalidate>' +

    '<div class="rq-field">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-regular fa-user"></i></div>' +
    '<input type="text" id="rqInqName" name="full_name" placeholder="Full Name" required>' +
    '</div>' +
    '</div>' +

    '<div class="rq-field">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-regular fa-envelope"></i></div>' +
    '<input type="email" id="rqInqEmail" name="email" placeholder="Email Address" required>' +
    '</div>' +
    '</div>' +

    '<div class="rq-field">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-solid fa-phone"></i></div>' +
    '<input type="tel" id="rqInqPhone" name="phone" placeholder="Phone Number" required pattern="[0-9+\\s\\-]{7,18}">' +
    '</div>' +
    '</div>' +

    '<div class="rq-field">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-solid fa-screwdriver-wrench"></i></div>' +
    '<select id="rqInqService" name="service" required>' +
    '<option value="" selected disabled>Service Required</option>' +
    '<option>AC Repair & Service</option>' +
    '<option>AC Installation</option>' +
    '<option>Routine Maintenance</option>' +
    '<option>Duct Cleaning & Sanitization</option>' +
    '<option>Refrigeration Solutions</option>' +
    '<option>AMC Plans</option>' +
    '<option>HVAC Inspection</option>' +
    '<option>Emergency Support</option>' +
    '</select>' +
    '<i class="fa-solid fa-chevron-down rq-select-arrow"></i>' +
    '</div>' +
    '</div>' +

    '<div class="rq-field">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-solid fa-location-dot"></i></div>' +
    '<input type="text" name="location" placeholder="Location / Area" required>' +
    '</div>' +
    '</div>' +

    '<div class="rq-field">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-regular fa-calendar"></i></div>' +
    '<input type="text" name="service_date" id="rqServiceDate" placeholder="Preferred Service Date" onfocus="this.type=\'date\'" onblur="if(!this.value)this.type=\'text\'">' +
    '</div>' +
    '</div>' +

    '<div class="rq-field full">' +
    '<div class="rq-input-wrap">' +
    '<div class="rq-field-icon"><i class="fa-regular fa-message"></i></div>' +
    '<input type="text" name="subject" placeholder="Subject">' +
    '</div>' +
    '</div>' +

    '<div class="rq-field full">' +
    '<div class="rq-input-wrap rq-textarea">' +
    '<div class="rq-field-icon"><i class="fa-regular fa-message"></i></div>' +
    '<textarea name="message" placeholder="Message" required></textarea>' +
    '</div>' +
    '</div>' +

    '<div class="rq-success" id="rqSuccess">' +
    '<i class="fa-solid fa-circle-check"></i>' +
    '&nbsp;' +
    'Thank you. Your enquiry has been submitted successfully.' +
    '</div>' +

    '<button type="submit" class="rq-submit">' +
    '<i class="fa-regular fa-paper-plane"></i>' +
    'Send Enquiry' +
    '</button>' +

    '<div class="rq-secure-note">' +
    '<i class="fa-solid fa-shield-halved"></i>' +
    '<span>We will respond within 24 hours.</span>' +
    '</div>' +

    '</form>' +

    '</div>' +

    '</div>' +
    '</div>';

  var overlay = null;
  var lastFocused = null;
  var defaultSubmitHtml = null;

  /* =====================================================
     INJECT
     ===================================================== */
  function injectModal() {
    if (document.getElementById('rqPopupOverlay')) return;
    var wrapper = document.createElement('div');
    wrapper.innerHTML = POPUP_HTML;
    document.body.appendChild(wrapper.firstElementChild);
    overlay = document.getElementById('rqPopupOverlay');

    var submitBtn = overlay.querySelector('.rq-submit');
    if (submitBtn) defaultSubmitHtml = submitBtn.innerHTML;

    document.getElementById('rqPopupClose').addEventListener('click', closeModal);
    overlay.addEventListener('click', function (event) {
      if (event.target === overlay) closeModal();
    });
    document.getElementById('rqQuoteForm').addEventListener('submit', handleSubmit);
  }

  /* =====================================================
     OPEN / CLOSE
     ===================================================== */
  function openModal(serviceName) {
    injectModal();
    resetForm();
    if (serviceName) preselectService(serviceName);
    lastFocused = document.activeElement;
    overlay.classList.add('active');
    document.body.style.overflow = 'hidden';
    setTimeout(function () {
      var first = document.getElementById('rqInqName');
      if (first) first.focus();
    }, 380);
  }

  function closeModal() {
    if (!overlay) return;
    overlay.classList.remove('active');
    document.body.style.overflow = '';
    if (lastFocused && typeof lastFocused.focus === 'function') {
      lastFocused.focus();
    }
  }

  /* Preselect the service matching the current page/service name */
  function preselectService(serviceName) {
    var select = document.getElementById('rqInqService');
    if (!select) return;
    var norm = function (s) {
      return String(s).toLowerCase().replace(/[^a-z0-9]+/g, '');
    };
    var target = norm(serviceName);
    for (var i = 0; i < select.options.length; i++) {
      if (norm(select.options[i].text) === target) {
        select.selectedIndex = i;
        return;
      }
    }
    /* fallback: partial match (e.g. "AC Repair Service" -> "AC Repair & Service") */
    for (var j = 0; j < select.options.length; j++) {
      var opt = norm(select.options[j].text);
      if (opt && (opt.indexOf(target) !== -1 || target.indexOf(opt) !== -1)) {
        select.selectedIndex = j;
        return;
      }
    }
  }

  /* =====================================================
     RESET
     ===================================================== */
  function resetForm() {
    var form = document.getElementById('rqQuoteForm');
    var success = document.getElementById('rqSuccess');
    if (!form) return;
    form.reset();
    if (success) success.classList.remove('show');
    var btn = form.querySelector('.rq-submit');
    if (btn) {
      btn.disabled = false;
      if (defaultSubmitHtml) btn.innerHTML = defaultSubmitHtml;
    }
  }

  /* =====================================================
     SUBMIT
     ===================================================== */
  function handleSubmit(event) {
    event.preventDefault();

    var form = event.target;

    if (!form.checkValidity()) {
      form.reportValidity ? form.reportValidity() : null;
      return;
    }

    /*
    =====================================================
    HERE YOU CAN ADD YOUR AJAX / PHP / WORDPRESS
    SUBMISSION LOGIC
    =====================================================
    */

    var success = document.getElementById('rqSuccess');
    var name = document.getElementById('rqInqName').value.trim();
    if (success) {
      success.innerHTML =
        '<i class="fa-solid fa-circle-check"></i>&nbsp;Thank you' +
        (name ? ', ' + name : '') +
        '. Your enquiry has been submitted successfully.';
      success.classList.add('show');
    }

    var submitButton = form.querySelector('.rq-submit');
    if (!submitButton) return;

    submitButton.innerHTML = '<i class="fa-solid fa-check"></i> Enquiry Sent';
    submitButton.disabled = true;

    setTimeout(function () {
      form.reset();
      if (success) success.classList.remove('show');
      submitButton.innerHTML = defaultSubmitHtml;
      submitButton.disabled = false;
    }, 3500);
  }

  /* =====================================================
     BIND "INQUIRE" BUTTONS
     ===================================================== */
  function isInquireLink(a) {
    var text = (a.textContent || '').trim().toLowerCase();
    return text === 'inquire' || text === 'enquire';
  }

  function bindTriggers() {
    var links = document.querySelectorAll('a[href="contact.html"], a[href="#inquiry"]');
    Array.prototype.forEach.call(links, function (a) {
      if (!isInquireLink(a) || a.dataset.rqInqBound) return;
      a.dataset.rqInqBound = '1';
      a.setAttribute('href', '#inquiry');
      a.addEventListener('click', function (e) {
        e.preventDefault();
        openModal(currentServiceName());
      });
    });
  }

  /* Derive current service from page title, e.g. "AC Installation - ..." */
  function currentServiceName() {
    var t = (document.title || '').split('-')[0].trim();
    return t && t.toLowerCase() !== 'arkdin' ? t : '';
  }

  /* =====================================================
     ESC CLOSE
     ===================================================== */
  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' && overlay && overlay.classList.contains('active')) {
      closeModal();
    }
  });

  /* =====================================================
     INIT
     ===================================================== */
  function init() {
    bindTriggers();
    // Re-scan after short delay to catch dynamically rendered headers (if any)
    setTimeout(bindTriggers, 500);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();