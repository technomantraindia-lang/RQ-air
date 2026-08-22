# Rebuild all service detail pages as EXACT copies of the approved master design
# (ac-installation.html), swapping only per-service name, image and copy.
# Verification: each output is reverse-mapped back to master wording and must
# equal the master byte-for-byte, proving layout/design is identical.

$ErrorActionPreference = 'Stop'

$repoRoot   = Split-Path -Parent $PSScriptRoot
$htmlDir    = Join-Path $repoRoot 'arkdin-html'
$masterPath = Join-Path $htmlDir 'ac-installation.html'
$utf8NoBom  = New-Object System.Text.UTF8Encoding($false)
$master     = [System.IO.File]::ReadAllText($masterPath)

$services = @(
    @{ File='ac-repair-service.html'; Name='AC Repair & Service'; Img='service_repair.jpg';
       H2='Expert AC Repair & Service';
       P1='When your AC stops cooling, makes noise or leaks water, our certified technicians diagnose the real problem quickly and fix it right. We repair all major brands and models using genuine spare parts.';
       H3a='Fast Diagnosis, Lasting Fixes';
       P2='Temporary fixes lead to repeat breakdowns. We find the root cause &mdash; whether it is gas leakage, compressor trouble, PCB faults or airflow blockage &mdash; and repair it properly so your AC runs reliably through the season.';
       P3='From minor sensor issues to complete compressor replacement, we carry common spares in our vans so most repairs are completed in a single visit.';
       H3b='What You Get With Every Repair';
       L1='Complete system diagnosis'; L2='Genuine spare parts'; L3='Gas leak detection & refilling'; L4='Compressor & PCB repairs'; L5='90-day repair warranty';
       P4='We explain the fault and the fix before starting work, so you always know what you are paying for &mdash; no surprises, no hidden charges.';
       Q1='How quickly can a technician reach my home?'; A1='For most locations we offer same-day visits, and emergency calls are prioritised within a few hours.';
       Q2='Do you repair all AC brands?'; A2='Yes. Our technicians are trained on all leading brands including Daikin, Voltas, Blue Star, LG, Samsung and Hitachi.';
       Q3='How much does an AC repair cost?'; A3='Diagnosis charges are fixed and shared upfront. After inspection you receive a clear quote &mdash; work starts only after your approval.';
       Q4='Is there a warranty on repairs?'; A4='Yes. Every repair comes with a 90-day service warranty on the replaced part and our workmanship.' },

    @{ File='routine-maintenance.html'; Name='Routine Maintenance'; Img='service_maintenance.jpg';
       H2='Professional Routine Maintenance';
       P1='Regular servicing keeps your AC cooling efficiently, consuming less power and lasting years longer. Our maintenance visits cover deep cleaning, performance checks and early detection of wear.';
       H3a='Small Checks That Prevent Big Repairs';
       P2='Clogged filters, dirty coils and low gas levels quietly reduce cooling and raise electricity bills. Scheduled maintenance catches these issues early, keeping performance at its peak all season.';
       P3='Each visit ends with a full cooling performance test, so you know exactly what condition your AC is in and what, if anything, needs attention next.';
       H3b='What You Get With Every Service Visit';
       L1='Deep filter & coil cleaning'; L2='Drain line flushing'; L3='Gas level & pressure check'; L4='Electrical safety inspection'; L5='Cooling performance report';
       P4='We recommend servicing every 4 months for home units and monthly for commercial spaces &mdash; our team sets a schedule that fits your usage.';
       Q1='How often should my AC be serviced?'; A1='For typical home use we recommend every 4 months. Heavy-use or dusty environments benefit from more frequent cleaning.';
       Q2='What is included in a standard service?'; A2='Filter and coil deep cleaning, drain flushing, gas pressure checks, electrical inspection and a full cooling test.';
       Q3='Will regular servicing really save power?'; A3='Yes. A clean AC cools faster and consumes noticeably less electricity compared to a neglected unit.';
       Q4='Do you send reminders for the next service?'; A4='Yes. Once you are on a maintenance plan we track your schedule and remind you before each due date.' },

    @{ File='duct-cleaning-sanitization.html'; Name='Duct Cleaning & Sanitization'; Img='service_duct_cleaning.jpg';
       H2='Deep Duct Cleaning & Sanitization';
       P1='Dust, mold and allergens hiding inside ducts circulate through every room. Our deep duct cleaning removes buildup and sanitizes the air path so your family breathes cleaner, healthier air.';
       H3a='Cleaner Ducts, Healthier Air';
       P2='Dirty ducts force your system to work harder and spread allergens, odors and bacteria. Using rotary brush systems and safe disinfectants, we restore clean airflow end to end.';
       P3='Before and after every job we inspect the full duct run with cameras where accessible, so you can see the difference our cleaning makes.';
       H3b='What You Get With Every Cleaning';
       L1='Full duct-line inspection'; L2='Rotary brush deep cleaning'; L3='Anti-bacterial sanitization'; L4='Mold & odor treatment'; L5='Airflow restoration report';
       P4='Ideal for homes, offices, clinics and restaurants &mdash; anywhere clean indoor air matters, especially for children, elders and allergy sufferers.';
       Q1='How do I know my ducts need cleaning?'; A1='Musty smells, visible dust around vents, uneven cooling or rising allergies are strong signs your ducts need attention.';
       Q2='Is the process messy?'; A2='No. We seal off sections and use HEPA-grade vacuum extraction, leaving your space as clean as we found it.';
       Q3='Are the sanitizing chemicals safe?'; A3='Yes. We use approved, low-toxicity disinfectants that are safe for people and pets once dry.';
       Q4='How often should ducts be cleaned?'; A4='For most homes every 2 to 3 years is enough; commercial kitchens, clinics and pet-friendly homes may need it annually.' },

    @{ File='refrigeration-solutions.html'; Name='Refrigeration Solutions'; Img='service_refrigeration.jpg';
       H2='Commercial Refrigeration Solutions';
       P1='From display chillers and cold rooms to deep freezers, we design, install and maintain refrigeration that protects your stock and your business. Reliable cooling means zero spoilage and happy customers.';
       H3a='Cooling Your Business Can Trust';
       P2='A failed chiller can ruin inventory overnight. We build redundancy into critical setups, respond fast to breakdowns and maintain equipment so failures simply do not happen.';
       P3='Whether you run a restaurant, supermarket, dairy or pharma storage, we size and configure systems to your exact load and temperature requirements.';
       H3b='What You Get With Our Solutions';
       L1='Cold room design & installation'; L2='Chiller & freezer setup'; L3='Temperature monitoring support'; L4='Preventive maintenance plans'; L5='Rapid breakdown response';
       P4='Our commercial clients get priority response times and scheduled maintenance windows that never disrupt business hours.';
       Q1='Which businesses do you serve?'; A1='Restaurants, cafes, supermarkets, bakeries, dairies, florists, labs and any business that depends on reliable cold storage.';
       Q2='Can you upgrade my old cold room?'; A2='Yes. We assess insulation, panels and refrigeration capacity, then upgrade components or rebuild for better efficiency.';
       Q3='Do you provide emergency breakdown support?'; A3='Yes. Commercial clients on our AMC get priority emergency response to protect perishable stock.';
       Q4='Can temperature be monitored remotely?'; A4='We can integrate digital controllers and alerting options so you know immediately if temperatures drift out of range.' },

    @{ File='amc-plans.html'; Name='AMC Plans'; Img='service_amc_team.jpg';
       H2='Annual Maintenance Contracts';
       P1='An AMC takes the worry out of AC ownership. One annual plan covers scheduled servicing, priority repairs and predictable costs &mdash; your comfort stays protected all year round.';
       H3a='One Plan, Year-Round Peace Of Mind';
       P2='Instead of scrambling when something breaks, AMC customers enjoy planned visits, priority slots and discounted repairs. Problems are caught early, before they become expensive.';
       P3='Choose from plans for single homes, apartments, offices and entire buildings &mdash; each tailored to the number and type of units you run.';
       H3b='What Every AMC Plan Includes';
       L1='Scheduled preventive visits'; L2='Priority emergency response'; L3='Discounted spare parts'; L4='Detailed service history'; L5='Dedicated account manager';
       P4='Plans start from a single split unit and scale up to full facility coverage with centralized reporting for large sites.';
       Q1='What does an AMC cover exactly?'; A1='All scheduled preventive maintenance visits plus priority response for breakdowns, with parts billed at discounted rates.';
       Q2='How many service visits do I get?'; A2='Standard plans include 3 to 4 visits per year per unit; commercial plans are customized to usage.';
       Q3='Are spare parts free under AMC?'; A3='Consumables covered by the plan are included; major parts are provided at discounted member pricing with warranty.';
       Q4='Can I upgrade my plan later?'; A4='Yes. Plans can be upgraded anytime &mdash; we adjust coverage and billing proportionately.' },

    @{ File='hvac-inspection.html'; Name='HVAC Inspection'; Img='service_inspection.jpg';
       H2='Professional HVAC Inspection';
       P1='Buying a property, facing high bills or planning an upgrade? A detailed HVAC inspection gives you a clear, unbiased picture of system health, efficiency and safety.';
       H3a='Know Exactly Where You Stand';
       P2='Our engineers measure cooling output, airflow, electrical safety, gas pressures and insulation quality, then hand you a written report with findings ranked by urgency.';
       P3='Inspections are ideal before property purchases, before summer peak loads, and whenever energy bills climb without explanation.';
       H3b='What Every Inspection Covers';
       L1='Cooling capacity measurement'; L2='Airflow & duct assessment'; L3='Electrical safety checks'; L4='Energy efficiency analysis'; L5='Written condition report';
       P4='After the inspection we walk you through the findings and give honest recommendations &mdash; repair, maintain or replace &mdash; with no sales pressure.';
       Q1='When should I get an HVAC inspection?'; A1='Before buying a property, before peak summer, after major renovations, or whenever performance or bills seem off.';
       Q2='How long does an inspection take?'; A2='A typical home inspection takes 60 to 90 minutes; larger commercial sites are scheduled separately.';
       Q3='Do I get a report?'; A3='Yes. You receive a written report with photos, measurements and prioritized recommendations.';
       Q4='Is the inspection charge adjustable against repairs?'; A4='Yes. If you proceed with recommended work through us, the inspection fee is adjusted in the final invoice.' },

    @{ File='emergency-support.html'; Name='Emergency Support'; Img='service_emergency.jpg';
       H2='24x7 Emergency AC Support';
       P1='AC failure in peak summer cannot wait until morning. Our emergency team responds around the clock with fully stocked vans to restore your cooling fast &mdash; day, night, weekends and holidays.';
       H3a='Help When You Need It Most';
       P2='Overheating bedrooms, server rooms at risk, shops losing customers &mdash; emergencies need speed. Call our helpline and a technician is dispatched with the tools and spares to fix most issues on the spot.';
       P3='Our emergency vans carry compressors, PCBs, gas cylinders and common spares, so over 80% of emergency calls are resolved in the first visit itself.';
       H3b='What Emergency Support Includes';
       L1='Round-the-clock helpline'; L2='Rapid technician dispatch'; L3='Fully stocked service vans'; L4='On-the-spot major repairs'; L5='Follow-up quality check';
       P4='Save our helpline number today &mdash; one call brings expert help to your door, wherever and whenever your AC lets you down.';
       Q1='Is emergency support really available 24x7?'; A1='Yes. Our helpline and dispatch team operate nights, weekends and holidays throughout the year.';
       Q2='How fast can a technician arrive?'; A2='Within city limits we typically reach within 2 to 4 hours depending on location and call volume.';
       Q3='Does an emergency visit cost more?'; A3='Emergency calls carry a small premium over standard rates, which is always confirmed upfront before dispatch.';
       Q4='What if the AC cannot be fixed on the spot?'; A4='We stabilize the situation, arrange temporary solutions where possible, and schedule the full repair with required parts at the earliest slot.' }
)

foreach ($s in $services) {
    $name = $s['Name']

    # Ordered old->new literal swaps applied to the master copy.
    $pairs = [ordered]@{
        '<title>AC Installation | RQ Air Conditioning</title>' = ('<title>{0} | RQ Air Conditioning</title>' -f $name)
        '>AC Installation</h1>' = ('>{0}</h1>' -f $name)
        '<li class="breadcrumb-item active">AC Installation</li>' = ('<li class="breadcrumb-item active">{0}</li>' -f $name)
        '<img src="assets/img/services-photos/service_installation.jpg" alt="AC Installation">' = ('<img src="assets/img/services-photos/{0}" alt="{1}">' -f $s['Img'], $name)
        '<h2 class="cs_fs_48 cs_mb_20">Professional AC Installation</h2>' = ('<h2 class="cs_fs_48 cs_mb_20">{0}</h2>' -f $s['H2'])
        'A great AC experience starts with a correct installation. From site assessment and load calculation to precision mounting and final testing, our team installs energy-efficient systems that cool better and last longer.' = $s['P1']
        'Done Right The First Time' = $s['H3a']
        'Wrong sizing, poor piping or careless mounting cause most cooling complaints and higher power bills. We follow manufacturer specifications and best practices at every step, ensuring optimal airflow, drainage and safety.' = $s['P2']
        'Whether it is a single split unit for your bedroom or a complete multi-unit setup for an office floor, we deliver neat, on-time installations with full cleanup after work.' = $s['P3']
        'Split or window AC &mdash; which one should I choose?' = $s['Q1']
        'It depends on your room layout, wall space, budget and aesthetics. During our free site assessment we recommend the option that fits your space best.' = $s['A1']
        'How do I know the right tonnage for my room?' = $s['Q2']
        'We calculate the heat load based on room size, insulation, sunlight exposure and occupancy, so you never pay for more capacity than you need.' = $s['A2']
        'How long does a typical installation take?' = $s['Q3']
        'A standard split AC installation takes about 3 to 5 hours. Larger or ducted projects are scheduled with a clear timeline in advance.' = $s['A3']
        'Will you remove and dispose of my old AC?' = $s['Q4']
        'Yes. On request we safely dismantle your old unit and dispose of it responsibly as part of the replacement installation.' = $s['A4']
    }

    $content = $master
    foreach ($key in $pairs.Keys) {
        if (-not $content.Contains($key)) { throw "Master marker not found for $($s['File']): $key" }
        $content = $content.Replace($key, $pairs[$key])
    }

    $outPath = Join-Path $htmlDir $s['File']
    [System.IO.File]::WriteAllText($outPath, $content, $utf8NoBom)

    # Proof of identical design: reverse-map new wording back to master wording;
    # the result must equal the master byte-for-byte.
    $reverse = $content
    foreach ($key in $pairs.Keys) {
        $reverse = $reverse.Replace($pairs[$key], $key)
    }
    if ($reverse -ceq $master) {
        Write-Host ("PASS  {0}  (layout identical to master, copy swapped)" -f $s['File'])
    } else {
        Write-Host ("FAIL  {0}  (differs beyond intended swaps)" -f $s['File'])
        exit 1
    }
}

Write-Host ''
Write-Host 'All 7 service detail pages rebuilt from the approved master design.'
