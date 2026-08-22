# Refine inquiry modal: compact text & box sizes (append-only override pass)
$ErrorActionPreference = 'Stop'
$path = Join-Path $PSScriptRoot '..\arkdin-html\assets\css\inquiry-modal.css'

$block = @'

/* ============================================================
   Refined Compact Sizing Pass v2 (smaller text & boxes)
   ============================================================ */
.rq-popup{max-width:780px !important;border-radius:16px !important;}
.rq-popup-close{width:34px !important;height:34px !important;font-size:15px !important;top:12px !important;right:12px !important;line-height:1 !important;}
.rq-popup-left{padding:26px 24px !important;}
.rq-brand{gap:10px !important;margin-bottom:14px !important;}
.rq-logo-big{width:44px !important;height:44px !important;}
.rq-brand-text strong{font-size:16px !important;}
.rq-tagline{font-size:11px !important;margin-top:2px !important;}
.rq-popup-image{max-width:100% !important;height:auto !important;max-height:140px !important;object-fit:contain !important;margin:0 0 14px !important;}
.rq-left-heading h3{font-size:18px !important;line-height:1.35 !important;margin-bottom:8px !important;}
.rq-left-heading p{font-size:12.5px !important;line-height:1.55 !important;}
.rq-contact-list{margin-top:14px !important;display:flex !important;flex-direction:column !important;gap:9px !important;}
.rq-contact-list li{font-size:12.5px !important;line-height:1.45 !important;padding:0 !important;}
.rq-contact-list li i,.rq-contact-list li svg{width:30px !important;height:30px !important;font-size:13px !important;flex:0 0 30px !important;}
.rq-popup-right{padding:26px 24px !important;}
.rq-popup-right h3,.rq-popup-right .rq-form-title{font-size:18px !important;margin-bottom:4px !important;}
.rq-popup-right p,.rq-popup-right .rq-form-subtitle{font-size:12.5px !important;margin-bottom:14px !important;}
.rq-popup label,.rq-popup-right label{font-size:12px !important;margin-bottom:5px !important;}
.rq-popup input,.rq-popup select,.rq-popup textarea,
.rq-popup-right input,.rq-popup-right select,.rq-popup-right textarea,
.rq-popup .form-control,.rq-popup-right .form-control{padding:9px 12px !important;font-size:13px !important;border-radius:8px !important;margin-bottom:10px !important;width:100% !important;box-sizing:border-box !important;}
.rq-popup textarea,.rq-popup-right textarea{min-height:70px !important;resize:vertical !important;}
.rq-popup button[type="submit"],.rq-popup-right button[type="submit"]{padding:11px 22px !important;font-size:13.5px !important;border-radius:8px !important;}
@media (max-width:767px){
  .rq-popup{max-width:94vw !important;}
  .rq-popup-left,.rq-popup-right{padding:20px 16px !important;}
  .rq-left-heading h3{font-size:16px !important;}
}
'@

if ((Get-Content $path -Raw) -notmatch 'Refined Compact Sizing Pass v2') {
    Add-Content -Path $path -Value $block -Encoding UTF8
    Write-Output 'Appended compact sizing overrides to inquiry-modal.css'
} else {
    Write-Output 'Compact sizing overrides already present; skipped.'
}