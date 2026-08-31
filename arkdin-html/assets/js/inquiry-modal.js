/* =====================================================
   Inquiry Popup Modal — Arkdin AC Services
   Self-contained: injects modal markup, binds all
   "Inquire" buttons, handles open/close/submit.
   ===================================================== */
(function () {
  'use strict';

  /* ---------- Modal markup injection ---------- */
  var MODAL_HTML =
    '<div class="rq-inq-overlay" id="rqInqOverlay" role="dialog" aria-modal="true" aria-labelledby="rqInqTitle">' +
    '  <div class="rq-inq-modal">' +
    '    <div class="rq-inq-head">' +
    '      <span class="rq-inq-eyebrow"><i class="fa-solid fa-headset"></i> Get In Touch</span>' +
    '      <h3 class="rq-inq-title" id="rqInqTitle">Request an Inquiry</h3>' +
    '      <p class="rq-inq-sub">Fill in your details and our AC experts will call you back shortly.</p>' +
    '      <button type="button" class="rq-inq-close" id="rqInqClose" aria-label="Close inquiry form">' +
    '        <i class="fa-solid fa-xmark"></i>' +
    '      </button>' +
    '    </div>' +
    '    <div class="rq-inq-body">' +
    '      <form class="rq-inq-form" id="rqInqForm" novalidate>' +
    '        <div class="rq-inq-row">' +
    '          <div class="rq-inq-field">' +
    '            <label for="rqInqName">Full Name <span class="rq-inq-req">*</span></label>' +
    '            <input type="text" id="rqInqName" name="name" placeholder="Enter your name" required />' +
    '          </div>' +
    '          <div class="rq-inq-field">' +
    '            <label for="rqInqPhone">Phone Number <span class="rq-inq-req">*</span></label>' +
    '            <input type="tel" id="rqInqPhone" name="phone" placeholder="Enter phone number" pattern="[0-9+\\s-]{7,15}" required />' +
    '          </div>' +
    '        </div>' +
    '        <div class="rq-inq-field">' +
    '          <label for="rqInqEmail">Email Address</label>' +
    '          <input type="email" id="rqInqEmail" name="email" placeholder="Enter email address" />' +
    '        </div>' +
    '        <div class="rq-inq-field">' +
    '          <label for="rqInqService">Service Required <span class="rq-inq-req">*</span></label>' +
    '          <select id="rqInqService" name="service" required>' +
    '            <option value="" disabled selected>Select a service</option>' +
    '            <option value="AC Installation">AC Installation</option>' +
    '            <option value="AC Repair Service">AC Repair Service</option>' +
    '            <option value="Routine Maintenance">Routine Maintenance</option>' +
    '            <option value="AMC Plans">AMC Plans</option>' +
    '            <option value="Duct Cleaning & Sanitization">Duct Cleaning & Sanitization</option>' +
    '            <option value="HVAC Inspection">HVAC Inspection</option>' +
    '            <option value="Refrigeration Solutions">Refrigeration Solutions</option>' +
    '            <option value="Emergency Support">Emergency Support</option>' +
    '            <option value="AC Supplier">AC Supplier</option>' +
    '            <option value="Other">Other</option>' +
    '          </select>' +
    '        </div>' +
    '        <div class="rq-inq-field">' +
    '          <label for="rqInqMessage">Message</label>' +
    '          <textarea id="rqInqMessage" name="message" placeholder="Tell us about your requirement..."></textarea>' +
    '        </div>' +
    '        <button type="submit" class="rq-inq-submit">' +
    '          Submit Inquiry <i class="fa-solid fa-arrow-right"></i>' +
    '        </button>' +
    '        <p class="rq-inq-note">By submitting, you agree to be contacted by our team.</p>' +
    '      </form>' +
    '      <div class="rq-inq-success" id="rqInqSuccess">' +
    '        <div class="rq-inq-success-icon"><i class="fa-solid fa-check"></i></div>' +
    '        <h4>Inquiry Submitted!</h4>' +
    '        <p>Thank you for reaching out. Our team will contact you within 24 hours.</p>' +
    '        <button type="button" class="rq-inq-submit" id="rqInqDone">Done</button>' +
    '      </div>' +
    '    </div>' +
    '  </div>' +
    '</div>';

  var overlay = null;
  var lastFocused = null;

  function injectModal() {
    if (document.getElementById('rqInqOverlay')) return;
    var wrapper = document.createElement('div');
    wrapper.innerHTML = MODAL_HTML;
    document.body.appendChild(wrapper.firstElementChild);
    overlay = document.getElementById('rqInqOverlay');

    document.getElementById('rqInqClose').addEventListener('click', closeModal);
    document.getElementById('rqInqDone').addEventListener('click', closeModal);
    overlay.addEventListener('click', function (e) {
      if (e.target === overlay) closeModal();
    });
    document.getElementById('rqInqForm').addEventListener('submit', handleSubmit);
  }

  /* ---------- Open / Close ---------- */
  function openModal(serviceName) {
    injectModal();
    resetForm();
    if (serviceName) {
      var select = document.getElementById('rqInqService');
      for (var i = 0; i < select.options.length; i++) {
        if (select.options[i].text === serviceName) {
          select.value = select.options[i].value;
          break;
        }
      }
    }
    lastFocused = document.activeElement;
    overlay.classList.add('is-open');
    document.body.classList.add('rq-inq-no-scroll');
    setTimeout(function () {
      var first = document.getElementById('rqInqName');
      if (first) first.focus();
    }, 320);
  }

  function closeModal() {
    if (!overlay) return;
    overlay.classList.remove('is-open');
    document.body.classList.remove('rq-inq-no-scroll');
    if (lastFocused && typeof lastFocused.focus === 'function') {
      lastFocused.focus();
    }
  }

  function resetForm() {
    var form = document.getElementById('rqInqForm');
    var success = document.getElementById('rqInqSuccess');
    if (!form || !success) return;
    form.reset();
    form.classList.remove('is-hidden');
    success.classList.remove('is-visible');
  }

  /* ---------- Submit ---------- */
  function handleSubmit(e) {
    e.preventDefault();
    var form = e.target;
    if (!form.checkValidity()) {
      form.reportValidity ? form.reportValidity() : null;
      return;
    }
    // Static template: simulate submission. Replace with fetch() to a backend endpoint when available.
    var name = document.getElementById('rqInqName').value.trim();
    document.querySelector('#rqInqSuccess p').textContent =
      'Thank you' + (name ? ', ' + name : '') + '! Our team will contact you within 24 hours.';
    form.classList.add('is-hidden');
    document.getElementById('rqInqSuccess').classList.add('is-visible');
  }

  /* ---------- Bind Inquire buttons ---------- */
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

  /* ---------- Escape key ---------- */
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && overlay && overlay.classList.contains('is-open')) {
      closeModal();
    }
  });

  /* ---------- Init ---------- */
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
