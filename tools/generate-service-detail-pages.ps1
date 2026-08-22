# Generates individual service detail pages for all 8 core services,
# reusing the existing service-details.html template shell (header, footer, sidebar).
# Run: powershell -NoProfile -ExecutionPolicy Bypass -File tools\generate-service-detail-pages.ps1

$ErrorActionPreference = 'Stop'

$outDir = (Resolve-Path (Join-Path $PSScriptRoot '..\arkdin-html')).Path

$TOP = @'
<!DOCTYPE html>
<html class="no-js" lang="en">

  <!-- Head -->
    <head>
    <!-- Meta Tags -->
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="ThemeServices">
    <!-- Favicon Icon -->
    <link rel="icon" href="assets/img/favicon.png">
    <!-- Site Title -->
    <title>{{TITLE}} | RQ Air Conditioning</title>
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/fontawesome.min.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="assets/css/slick.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/services-custom.css" />
  </head>

  <body>
    <!-- preloader -->
    <div class="cs_preloader cs_accent_color">
  <div class="cs_preloader_in">
    <img src="assets/img/preloader_icon.svg" alt="Bione">
  </div>
</div>

    <!-- Start Header Section -->
    <header class="cs_site_header cs_style_1 cs_heading_color cs_sticky_header">
      <div class="cs_top_header">
        <div class="container">
          <div class="cs_top_header_in">
            <div class="cs_top_header_left">Welcome to Our RQ Air Conditioning & Services Company</div>
            <div class="cs_top_header_left">
              <div class="cs_header_social_links_wrap">
                <p class="mb-0">Follow Us On: </p>
                <div class="cs_header_social_links">
                  <a href="#" class="cs_social_btn cs_center">
                    <i class="fa-brands fa-linkedin-in"></i>
                  </a>
                  <a href="#" class="cs_social_btn cs_center">
                    <i class="fa-brands fa-twitter"></i>
                  </a>
                  <a href="#" class="cs_social_btn cs_center">
                    <i class="fa-brands fa-youtube"></i>
                  </a>
                  <a href="#" class="cs_social_btn cs_center">
                    <i class="fa-brands fa-facebook-f"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="cs_main_header cs_accent_bg">
        <div class="container">
          <div class="cs_main_header_in">
            <div class="cs_main_header_left">
              <a class="cs_site_branding" href="index.html">
                <img src="assets/img/logo.svg" alt="RQ Air Conditioning">
              </a>
            </div>
            <div class="cs_main_header_center">
              <div class="cs_nav">
                <ul class="cs_nav_list">
                  <li><a href="index.html">Home</a></li>
                  <li><a href="about-us.html">About Us</a></li>
                  <li><a href="service.html">Services</a></li>
                  <li><a href="contact.html">Contact</a></li>
                </ul>
              </div>
            </div>
            <div class="cs_main_header_right">
              <a href="contact.html" class="cs_btn cs_style_1">
                <span>Inquire</span>
                <svg width="14" height="13" viewBox="0 0 14 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M8.28125 0.71875L13.7812 5.96875C13.9271 6.11458 14 6.29167 14 6.5C14 6.70833 13.9271 6.88542 13.7812 7.03125L8.28125 12.2812C7.90625 12.5729 7.55208 12.5729 7.21875 12.2812C6.92708 11.9062 6.92708 11.5521 7.21875 11.2188L11.375 7.25H0.75C0.291667 7.20833 0.0416667 6.95833 0 6.5C0.0416667 6.04167 0.291667 5.79167 0.75 5.75H11.375L7.21875 1.78125C6.92708 1.44792 6.92708 1.09375 7.21875 0.71875C7.55208 0.427083 7.90625 0.427083 8.28125 0.71875Z" fill="currentColor"></path>
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>
    </header>
    <div class="cs_site_header_spacing_130"></div>
    <!-- End Header Section -->

    <!-- Start Page Heading -->

    <section class="cs_page_heading cs_bg_filed cs_center cs_primary_bg text-center" data-src="assets/img/page_heading_1.jpg">
  <div class="container">
    <h1 class="cs_white_color cs_semibold cs_mb_10 cs_fs_64">{{SERVICE}}</h1>
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="index.html">Home</a></li>
      <li class="breadcrumb-item"><a href="service.html">Services</a></li>
      <li class="breadcrumb-item active">{{SERVICE}}</li>
    </ol>
  </div>
</section>
    <!-- End Page Heading -->

'@

$MID_TOP = @'
    <!-- Start Service Details -->
    <section>
      <div class="cs_height_120 cs_height_lg_80"></div>
      <div class="container">
        <div class="row cs_gap_y_60">
          <div class="col-lg-8">
            <div class="cs_pr_30">
              <div class="cs_service_details">
'@

$MID_BOT = @'
              </div>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="cs_right_sidebar">
              <div class="cs_sidebar_widget cs_color_1">
                <form action="#" class="cs_search_form">
                  <input type="text" placeholder="Enter Keyword" class="cs_search_input">
                  <button class="cs_search_submit_btn"><i class="fa-solid fa-search"></i></button>
                </form>
              </div>
              <div class="cs_sidebar_widget">
                <h2 class="cs_sidebar_widget_heading cs_fs_24 cs_semibold">Categories</h2>
                <ul class="cs_category_widget">
                  <li>
                    <a href="ac-repair-service.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>AC Repair & Service</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="ac-installation.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>AC Installation</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="routine-maintenance.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>Routine Maintenance</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="duct-cleaning-sanitization.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>Duct Cleaning & Sanitization</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="refrigeration-solutions.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>Refrigeration Solutions</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="amc-plans.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>AMC Plans</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="hvac-inspection.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>HVAC Inspection</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                  <li>
                    <a href="emergency-support.html">
                      <i class="fa-solid fa-folder-open"></i>
                      <span>Emergency Support</span>
                      <i class="fa-solid fa-arrow-right"></i>
                    </a>
                  </li>
                </ul>
              </div>
              <div class="cs_sidebar_widget">
                <h2 class="cs_sidebar_widget_heading cs_fs_24 cs_semibold">Download</h2>
                <div>
                  <a href="#" class="cs_btn cs_style_1 w-100 cs_mb_15">
                    <i class="fa-solid fa-file-pdf"></i>
                    <span>DOWNLOAD PDF</span>
                  </a>
                  <a href="#" class="cs_btn cs_style_1 cs_color_2 w-100">
                    <i class="fa-solid fa-file"></i>
                    <span>DOWNLOAD DOC</span>
                  </a>
                </div>
              </div>
              <div class="cs_sidebar_widget">
                <h2 class="cs_sidebar_widget_heading cs_fs_24 cs_semibold">Ask Question</h2>
                <form action="#">
                  <input type="text" class="cs_form_field cs_mb_15" placeholder="Your Name">
                  <input type="text" class="cs_form_field cs_mb_15" placeholder="Email Address">
                  <input type="text" class="cs_form_field cs_mb_15" placeholder="Phone Number">
                  <textarea cols="30" rows="3" class="cs_form_field cs_mb_15" placeholder="Write Message..."></textarea>
                  <button class="cs_btn cs_style_1 w-100" type="submit"><span>Ask Question Now</span></button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="cs_height_120 cs_height_lg_80"></div>
    </section>
    <!-- End Service Details -->

'@

$BOTTOM = @'
    <!-- Start Footer -->
    <footer class="cs_footer cs_style_1">
  <div class="cs_footer_top">
    <div class="container">
      <div class="cs_footer_top_in">
        <div class="cs_social_btns cs_style_1">
          <a href="#" class="cs_social_btn cs_center">
            <i class="fa-brands fa-linkedin-in"></i>
          </a>
          <a href="#" class="cs_social_btn cs_center">
            <i class="fa-brands fa-twitter"></i>
          </a>
          <a href="#" class="cs_social_btn cs_center">
            <i class="fa-brands fa-youtube"></i>
          </a>
          <a href="#" class="cs_social_btn cs_center">
            <i class="fa-brands fa-facebook-f"></i>
          </a>
        </div>
        <div class="cs_footer_logo wow zoomIn" data-wow-duration="0.9s" data-wow-delay="0.25s"><img src="assets/img/footer_logo.svg" alt="RQ Air Conditioning"></div>
        <div class="cs_footer_contact_card">
          <div class="cs_footer_contact_card_icon cs_white_bg cs_center">
            <img src="assets/img/icons/call.svg" alt="">
          </div>
          <div>
            <p class="cs_white_color cs_fs_14 mb-0">Need Any Cleaning Help</p>
            <h3 class="mb-0 cs_fs_24 cs_semibold cs_white_color"><a href="tel:+919819376325">+91 98193 76325</a></h3>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="cs_main_footer cs_bg_filed cs_primary_bg cs_white_color" data-src="assets/img/footer_bg_1.jpg">
    <div class="container">
      <div class="cs_footer_row cs_type_1">
        <div class="cs_footer_col">
          <div class="cs_footer_widget">
            <h2 class="cs_footer_widget_title cs_fs_24 cs_semibold cs_white_color cs_mb_10">Our Service</h2>
            <div class="cs_footer_widget_seperator">
              <span class="cs_accent_bg"></span>
              <span class="cs_white_bg"></span>
              <span class="cs_white_bg"></span>
            </div>
            <ul class="cs_footer_menu_2">
              <li><a href="service-details.html">Rapid Cool Installation</a></li>
              <li><a href="service-details.html">Air Flow Optimization</a></li>
              <li><a href="service-details.html">Rapid Drain Unclogging</a></li>
              <li><a href="service-details.html">Frost Guard Emergency</a></li>
              <li><a href="service-details.html">Breeze Balance Calibration</a></li>
            </ul>
          </div>
        </div>
        <div class="cs_footer_col">
          <div class="cs_footer_widget">
            <h2 class="cs_footer_widget_title cs_fs_24 cs_semibold cs_white_color cs_mb_10">Working Hours:</h2>
            <div class="cs_footer_widget_seperator">
              <span class="cs_accent_bg"></span>
              <span class="cs_white_bg"></span>
              <span class="cs_white_bg"></span>
            </div>
            <ul class="cs_working_hours">
              <li>
                <span>Thu - Fri</span>
                <span>9:00 AM - 7:00 PM</span>
              </li>
              <li>
                <span>Mon - Wed</span>
                <span>8:00 AM - 10:00 PM</span>
              </li>
              <li>
                <span>Saturday</span>
                <span>7:00 AM - 9:00 PM</span>
              </li>
              <li>
                <span>Sunday</span>
                <span>Close</span>
              </li>
            </ul>
          </div>
        </div>
        <div class="cs_footer_col">
          <div class="cs_footer_widget">
            <h2 class="cs_footer_widget_title cs_fs_24 cs_semibold cs_white_color cs_mb_10">Quick links</h2>
            <div class="cs_footer_widget_seperator">
              <span class="cs_accent_bg"></span>
              <span class="cs_white_bg"></span>
              <span class="cs_white_bg"></span>
            </div>
            <ul class="cs_footer_menu_2">
              <li><a href="index.html">Home</a></li>
              <li><a href="about-us.html">About </a></li>
              <li><a href="service.html">Services</a></li>
              <li><a href="blog.html">Blog</a></li>
              <li><a href="contact.html">Contact</a></li>
            </ul>
          </div>
        </div>
        <div class="cs_footer_col">
          <div class="cs_footer_widget">
            <h2 class="cs_footer_widget_title cs_fs_24 cs_semibold cs_white_color cs_mb_10">Recent Post</h2>
            <div class="cs_footer_widget_seperator">
              <span class="cs_accent_bg"></span>
              <span class="cs_white_bg"></span>
              <span class="cs_white_bg"></span>
            </div>
            <ul class="cs_recent_post_widget">
              <li>
                <div class="cs_recent_post">
                  <a href="blog-details.html" class="cs_recent_post_thumb">
                    <img src="assets/img/recent_post_1.jpg" alt="">
                  </a>
                  <div class="cs_recent_post_right">
                    <p class="cs_recent_posted_by cs_fs_14">
                      <i class="fa-solid fa-calendar-alt"></i>
                      12 May, 2024
                    </p>
                    <h3 class="cs_white_color cs_fs_18 cs_medium mb-0">
                      <a href="blog-details.html">Outdoor and Landscape Lighting</a>
                    </h3>
                  </div>
                </div>
              </li>
              <li>
                <div class="cs_recent_post">
                  <a href="blog-details.html" class="cs_recent_post_thumb">
                    <img src="assets/img/recent_post_2.jpg" alt="">
                  </a>
                  <div class="cs_recent_post_right">
                    <p class="cs_recent_posted_by cs_fs_14">
                      <i class="fa-solid fa-calendar-alt"></i>
                      10 May, 2024
                    </p>
                    <h3 class="cs_white_color cs_fs_18 cs_medium mb-0">
                      <a href="blog-details.html">Panel Upgrades and Maintenance</a>
                    </h3>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="cs_footer_bottom cs_accent_bg cs_white_color">
    <div class="container">
      <div class="cs_footer_bottom_in">
        <div class="cs_footer_copyright">Copyright@ 2024 <a href="#">RQ Air Conditioning</a>. All Rights Reserved.</div>
        <ul class="cs_footer_menu cs_mp_0">
          <li><a href="#">Setting & Privacy </a></li>
          <li><a href="#">FAQ</a></li>
          <li><a href="#">Support</a></li>
        </ul>
      </div>
    </div>
  </div>
</footer>
    <!-- End Footer -->

    <!-- Script -->
        <script src="assets/js/jquery-3.6.0.min.js"></script>
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/jquery.slick.min.js"></script>
    <script src="assets/js/main.js"></script>

  </body>
</html>
'@

function New-CheckItem([string]$Text) {
  return @"
                  <li>
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <circle cx="8" cy="8" r="7" stroke="currentColor" stroke-width="1.5"/>
                      <path d="M5 8.25L7.15 10.4L11.1 5.9" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    $Text
                  </li>
"@
}

function New-Faq([string]$Question, [string]$Answer, [bool]$Active) {
  $cls = ''
  if ($Active) { $cls = ' active' }
  return @"
                  <div class="cs_accordian$cls">
                    <div class="cs_accordian_head">
                      <h2 class="cs_accordian_title cs_fs_18 cs_medium mb-0">$Question</h2>
                      <span class="cs_accordian_toggle"></span>
                    </div>
                    <div class="cs_accordian_body">
                      <p>$Answer</p>
                    </div>
                  </div><!-- .cs_accordian -->
"@
}

$services = @(
  @{
    File = 'ac-repair-service.html'
    Name = 'AC Repair & Service'
    Main = @'
                <img src="assets/img/services-photos/service_repair.jpg" alt="AC Repair & Service">
                <h2 class="cs_fs_48 cs_mb_20">Fast & Reliable AC Repair</h2>
                <p class="cs_mb_25">When your air conditioner breaks down, every hour counts. Our certified technicians reach you fast, diagnose the exact fault, and restore cooling using genuine spare parts and proven repair practices &mdash; for split, window, cassette and ducted systems alike.</p>
                <h3 class="cs_fs_30 cs_mb_15">Complete Repair Solutions</h3>
                <p class="cs_mb_25">From gas leaks and compressor failures to PCB faults, sensor errors and drainage problems, we handle every type of AC issue. Every job begins with a systematic inspection followed by a clear, written quotation &mdash; so you approve the cost before any work starts.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_installation.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_maintenance.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">We service all major brands and models, and every completed repair is tested end-to-end so your system delivers consistent cooling from day one.</p>
                <h3 class="cs_fs_30 cs_mb_15">What You Get With Every Repair</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">Our goal is not just to fix today&rsquo;s fault but to keep it fixed. We share honest guidance on usage, upkeep and efficiency so your AC serves you reliably for years.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Expert fault diagnosis','Genuine spare parts','Same-day service','All brands covered','Warranty-backed repairs')
    Faqs = @(
      @('How quickly can you attend to a repair request?','Requests received during working hours are usually attended the same day. For urgent breakdowns, our emergency team is available round the clock.'),
      @('Do you repair all AC brands and types?','Yes. We repair split, window, cassette and ducted systems across all major brands, using genuine or OEM-equivalent spare parts.'),
      @('How is the repair cost decided?','After a fixed-fee diagnostic inspection, you receive a transparent written quote. Work starts only after your approval &mdash; no hidden charges.'),
      @('Do you provide a warranty on repairs?','Yes. Repaired faults and replaced parts carry a workmanship warranty, the terms of which are clearly mentioned on your job sheet.')
    )
  },
  @{
    File = 'ac-installation.html'
    Name = 'AC Installation'
    Main = @'
                <img src="assets/img/services-photos/service_installation.jpg" alt="AC Installation">
                <h2 class="cs_fs_48 cs_mb_20">Professional AC Installation</h2>
                <p class="cs_mb_25">A great AC experience starts with a correct installation. From site assessment and load calculation to precision mounting and final testing, our team installs energy-efficient systems that cool better and last longer.</p>
                <h3 class="cs_fs_30 cs_mb_15">Done Right The First Time</h3>
                <p class="cs_mb_25">Wrong sizing, poor piping or careless mounting cause most cooling complaints and higher power bills. We follow manufacturer specifications and best practices at every step, ensuring optimal airflow, drainage and safety.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_repair.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_maintenance.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">Whether it is a single split unit for your bedroom or a complete multi-unit setup for an office floor, we deliver neat, on-time installations with full cleanup after work.</p>
                <h3 class="cs_fs_30 cs_mb_15">What You Get With Every Installation</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">We treat your space like our own &mdash; protecting floors and furniture, working cleanly, and walking you through operation and care tips before we leave.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Free site assessment','Right tonnage selection','Precision mounting & piping','Neat cable & drain management','Post-installation testing')
    Faqs = @(
      @('Split or window AC &mdash; which one should I choose?','It depends on your room layout, wall space, budget and aesthetics. During our free site assessment we recommend the option that fits your space best.'),
      @('How do I know the right tonnage for my room?','We calculate the heat load based on room size, insulation, sunlight exposure and occupancy, so you never pay for more capacity than you need.'),
      @('How long does a typical installation take?','A standard split AC installation takes about 3 to 5 hours. Larger or ducted projects are scheduled with a clear timeline in advance.'),
      @('Will you remove and dispose of my old AC?','Yes. On request we safely dismantle your old unit and dispose of it responsibly as part of the replacement installation.')
    )
  },
  @{
    File = 'routine-maintenance.html'
    Name = 'Routine Maintenance'
    Main = @'
                <img src="assets/img/services-photos/service_maintenance.jpg" alt="Routine Maintenance">
                <h2 class="cs_fs_48 cs_mb_20">Routine AC Maintenance</h2>
                <p class="cs_mb_25">Regular maintenance keeps your air conditioner efficient, quiet and dependable. Our planned service visits prevent sudden breakdowns, reduce power consumption and extend the life of your system.</p>
                <h3 class="cs_fs_30 cs_mb_15">What Our Maintenance Covers</h3>
                <p class="cs_mb_25">Each visit includes filter cleaning or replacement, condenser and evaporator coil cleaning, refrigerant pressure checks, electrical and thermostat calibration, and a full cooling performance test.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_repair.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_installation.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">You receive a simple performance report after every visit, so you always know the health of your system and what to expect next season.</p>
                <h3 class="cs_fs_30 cs_mb_15">Benefits Of Scheduled Maintenance</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">Our maintenance plans are designed around your schedule, not ours. Choose convenient slots and we will remind you when the next service is due.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Lower electricity bills','Fewer breakdowns','Better air quality','Longer equipment life','Consistent cooling performance')
    Faqs = @(
      @('How often should AC maintenance be done?','At least twice a year for homes &mdash; ideally before summer and after monsoon. Heavy-use and commercial systems benefit from quarterly servicing.'),
      @('What is included in a maintenance visit?','Filter and coil cleaning, refrigerant level check, electrical inspection, thermostat calibration, drain flushing and a complete performance test.'),
      @('Will regular maintenance really save money?','Yes. A clean, well-tuned system consumes noticeably less power and helps you avoid expensive emergency repairs later.'),
      @('Can I automate maintenance with an AMC plan?','Absolutely. Our AMC plans schedule every visit automatically and add priority support whenever you need help between services.')
    )
  },
  @{
    File = 'duct-cleaning-sanitization.html'
    Name = 'Duct Cleaning & Sanitization'
    Main = @'
                <img src="assets/img/services-photos/service_duct_cleaning.jpg" alt="Duct Cleaning & Sanitization">
                <h2 class="cs_fs_48 cs_mb_20">Healthier Air With Clean Ducts</h2>
                <p class="cs_mb_25">Dust, allergens and mold hiding inside ductwork quietly degrade the air you breathe. Our deep duct cleaning and sanitization restores clean airflow and a fresher indoor environment.</p>
                <h3 class="cs_fs_30 cs_mb_15">Our Cleaning Process</h3>
                <p class="cs_mb_25">We inspect the duct network, then use rotary soft-brush agitation with high-powered HEPA vacuuming to dislodge and extract accumulated dust and debris &mdash; without damaging your ducting.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_maintenance.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_inspection.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">After cleaning, we apply safe anti-bacterial sanitizing agents to inhibit mold and microbial growth, leaving your ducts hygienic and odor-free.</p>
                <h3 class="cs_fs_30 cs_mb_15">What You Get With Every Service</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">Cleaner ducts mean fewer allergies, less dusting and better cooling efficiency. We show you before-and-after evidence so you can see the difference yourself.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Deep duct vacuuming','Anti-bacterial sanitization','Dust & debris removal','Odor elimination','Improved airflow & air quality')
    Faqs = @(
      @('How often should air ducts be cleaned?','Every 12 to 24 months for most spaces &mdash; sooner after renovations, water leaks, or if you notice dust, odor or allergy symptoms.'),
      @('Is duct cleaning safe for my system?','Yes. We use soft-brush rotary tools and HEPA-filtered vacuums designed to clean thoroughly without harming ducts or insulation.'),
      @('What sanitizing agents do you use?','Only approved, low-toxicity anti-bacterial agents. Spaces are safe for children and pets once the treated surfaces are dry.'),
      @('How long does the service take?','Most homes take 2 to 4 hours. Larger or commercial duct networks are surveyed first and scheduled with a clear timeline.')
    )
  },
  @{
    File = 'refrigeration-solutions.html'
    Name = 'Refrigeration Solutions'
    Main = @'
                <img src="assets/img/services-photos/service_refrigeration.jpg" alt="Refrigeration Solutions">
                <h2 class="cs_fs_48 cs_mb_20">Commercial Refrigeration Solutions</h2>
                <p class="cs_mb_25">From restaurants and cloud kitchens to cold storage and pharmaceutical facilities, we design, install and maintain refrigeration systems that protect your products and your margins.</p>
                <h3 class="cs_fs_30 cs_mb_15">Tailored To Your Business</h3>
                <p class="cs_mb_25">Every facility has different temperature, load and space requirements. We begin with a site survey and load calculation, then engineer a solution sized precisely for your operation &mdash; no overspending on capacity you don&rsquo;t need.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_installation.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_amc_team.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">Our installations use commercial-grade components with precise temperature control, and we back them with preventive maintenance and round-the-clock breakdown support.</p>
                <h3 class="cs_fs_30 cs_mb_15">What You Get With Every Project</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">Downtime in refrigeration is lost inventory. Our priority response and monitoring practices keep your critical systems running when it matters most.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Custom system design','Commercial-grade equipment','Precise temperature control','Energy optimization','Preventive maintenance support')
    Faqs = @(
      @('Which businesses do you serve?','Restaurants, bakeries, supermarkets, cold storage units, laboratories, pharmaceutical facilities and food processing plants.'),
      @('Can you design a completely custom setup?','Yes. We handle everything from single display chillers to turnkey cold rooms &mdash; survey, design, installation and commissioning.'),
      @('Do you maintain existing refrigeration plants?','Yes. We take over and maintain systems of any make through preventive contracts with guaranteed response times.'),
      @('Will upgrading reduce my power bills?','Modern energy-efficient equipment combined with proper sizing and controls can significantly cut refrigeration power costs.')
    )
  },
  @{
    File = 'amc-plans.html'
    Name = 'AMC Plans'
    Main = @'
                <img src="assets/img/services-photos/service_amc_team.jpg" alt="AMC Plans">
                <h2 class="cs_fs_48 cs_mb_20">Worry-Free AMC Plans</h2>
                <p class="cs_mb_25">An Annual Maintenance Contract puts your comfort on autopilot. Scheduled preventive visits, priority breakdown response and predictable costs &mdash; all under one simple yearly plan.</p>
                <h3 class="cs_fs_30 cs_mb_15">How Our AMC Works</h3>
                <p class="cs_mb_25">Based on your plan, our team visits at fixed intervals to service your systems before problems appear. Between visits, you get priority scheduling and discounted spares whenever something needs attention.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_maintenance.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_emergency.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">Every visit is documented with a service report, giving you a complete maintenance history for each unit &mdash; useful for warranties, audits and resale.</p>
                <h3 class="cs_fs_30 cs_mb_15">What Your AMC Includes</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">With an AMC, you stop worrying about service dates, sudden failures and unpredictable repair bills. We track everything so you don&rsquo;t have to.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Scheduled preventive visits','Priority breakdown response','Labor & minor repairs covered','Discounted genuine spares','Detailed service reports')
    Faqs = @(
      @('What exactly is an Annual Maintenance Contract?','It is a yearly agreement in which we maintain your AC or refrigeration systems through scheduled visits and support you with priority assistance on breakdowns.'),
      @('How many visits are included in a year?','Depending on the plan, you get quarterly or half-yearly preventive visits. Custom frequencies are available for commercial clients.'),
      @('What is covered under the AMC?','Preventive maintenance, labor and minor repairs are covered as per your plan. Major spares are provided at discounted rates.'),
      @('Can I upgrade or renew my plan later?','Yes. You can upgrade your coverage at any time, and we send renewal reminders well before your plan expires.')
    )
  },
  @{
    File = 'hvac-inspection.html'
    Name = 'HVAC Inspection'
    Main = @'
                <img src="assets/img/services-photos/service_inspection.jpg" alt="HVAC Inspection">
                <h2 class="cs_fs_48 cs_mb_20">Thorough HVAC Inspections</h2>
                <p class="cs_mb_25">A professional inspection reveals what everyday operation hides &mdash; safety risks, efficiency losses and early-stage faults. Our detailed audits keep your HVAC systems compliant, efficient and dependable.</p>
                <h3 class="cs_fs_30 cs_mb_15">What We Inspect</h3>
                <p class="cs_mb_25">Our engineers examine mechanical condition, electrical connections, refrigerant health, airflow balance, drainage and safety controls &mdash; cross-checked against manufacturer specs and safety standards.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_duct_cleaning.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_repair.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">You receive a structured report with photographic evidence, measured readings and a prioritized action plan, so you know exactly what to fix now and what can wait.</p>
                <h3 class="cs_fs_30 cs_mb_15">What You Get With Every Inspection</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">Whether it is a home pre-summer check or a facility-wide commercial audit, we give you clarity &mdash; honest findings, fair priorities and zero scare tactics.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Complete system scan','Safety & compliance checks','Energy efficiency audit','Fault detection with photos','Prioritized action plan')
    Faqs = @(
      @('Why is a professional HVAC inspection important?','It uncovers safety hazards, hidden inefficiencies and developing faults early &mdash; preventing costly breakdowns and keeping occupants safe.'),
      @('What does the inspection cover?','Mechanical and electrical condition, refrigerant levels, airflow, drainage, thermostat accuracy and safety controls, plus an overall efficiency review.'),
      @('Will I receive a documented report?','Yes. Every inspection concludes with a written report including photographs, readings and prioritized recommendations.'),
      @('Are inspections useful for commercial facilities?','Very. Regular inspections support compliance documentation, protect warranties and deliver measurable energy savings at scale.')
    )
  },
  @{
    File = 'emergency-support.html'
    Name = 'Emergency Support'
    Main = @'
                <img src="assets/img/services-photos/service_emergency.jpg" alt="Emergency Support">
                <h2 class="cs_fs_48 cs_mb_20">24/7 Emergency Support</h2>
                <p class="cs_mb_25">Cooling failures don&rsquo;t wait for office hours &mdash; and neither do we. Our emergency team is on call round the clock, every day of the year, to bring your system back fast.</p>
                <h3 class="cs_fs_30 cs_mb_15">Rapid Response, Real Fixes</h3>
                <p class="cs_mb_25">Call our emergency line and a trained technician is dispatched with the tools and common spares needed for on-the-spot resolution. Most emergencies are stabilized in a single visit.</p>
                <div class="row">
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_repair.jpg" alt="">
                  </div>
                  <div class="col-lg-6">
                    <img src="assets/img/services-photos/service_amc_team.jpg" alt="">
                  </div>
                </div>
                <p class="cs_mb_25">If a fault needs parts or extended work, we arrange temporary cooling measures where possible and schedule the permanent fix at the earliest slot.</p>
                <h3 class="cs_fs_30 cs_mb_15">What You Get With Emergency Service</h3>
                <ul class="cs_list cs_style_1 cs_mp_0 cs_fs_18 cs_medium cs_heading_font">
{CHECKS}
                </ul>
                <h3 class="cs_fs_30 cs_mb_15">We help you with the dedication & affection</h3>
                <p class="cs_mb_25">Emergencies are stressful enough. We keep communication clear &mdash; arrival times, costs and next steps confirmed upfront, with no surprises.</p>
                <div class="cs_accordians cs_style_1">
{FAQS}
                </div>
'@
    Checks = @('Round-the-clock availability','Rapid response dispatch','On-call expert technicians','Temporary cooling solutions','Permanent follow-up fix')
    Faqs = @(
      @('How fast is your emergency response?','We dispatch immediately on confirmation. Typical arrival times depend on your location and traffic, and are communicated upfront when you call.'),
      @('Is support really available 24/7?','Yes &mdash; nights, weekends and holidays included. Our emergency phone line is answered live at all hours.'),
      @('Are emergency call-outs charged differently?','Emergency visits carry a clearly stated call-out rate shared before dispatch. Any further costs are quoted and approved before work proceeds.'),
      @('What if the problem cannot be fixed on the spot?','We stabilize the situation &mdash; restoring partial cooling where possible &mdash; and schedule the complete repair with required parts at the earliest slot.')
    )
  }
)

$created = 0
foreach ($s in $services) {
  $checksHtml = ''
  foreach ($c in $s.Checks) { $checksHtml += (New-CheckItem $c) }

  $faqsHtml = ''
  for ($i = 0; $i -lt $s.Faqs.Count; $i++) {
    $faqsHtml += (New-Faq $s.Faqs[$i][0] $s.Faqs[$i][1] ($i -eq 0))
  }

  $main = $s.Main.Replace('{CHECKS}', $checksHtml).Replace('{FAQS}', $faqsHtml)
  $html = $TOP.Replace('{{TITLE}}', $s.Name).Replace('{{SERVICE}}', $s.Name) + $MID_TOP + $main + $MID_BOT + $BOTTOM

  $target = Join-Path $outDir $s.File
  Set-Content -Path $target -Value $html -Encoding UTF8
  Write-Output ("Created: " + $s.File)
  $created++
}

Write-Output ("Done. " + $created + " service detail pages generated in " + $outDir)