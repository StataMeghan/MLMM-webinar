clear
set linesize 90
webdoc init mlmm, replace logall
/*** 
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta
			name="viewport"
			content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
		/>
		<title>Intro to MLMM</title>

		<link rel="stylesheet" href="dist/reset.css" />
		<link rel="stylesheet" href="dist/reveal.css" />
		<link rel="stylesheet" href="stata-webinar.css" />

		<link rel="stylesheet" href="dist/monokai.css" />
	</head>
	<body>
		<div class="reveal">
			<div class="slides">
<section class="column-slide">
    <h1 style="font-size: 2em; font-weight: 500; margin-bottom: 0.2em; line-height: 1.2; text-transform: none;">
        Introduction to multilevel modeling using Stata
    </h1>
    <hr style="width: 15%; border: 2px solid #4CA6E8; margin: 40px auto; border-radius: 2px;">
        <p style="font-size: 1em; margin-bottom: 5px; color: #FFFFFF;">
            Meghan Cain, PhD
        </p>
        <p style="font-size: 0.9em; color: #E2E8F0; margin-bottom: 25px;">
            Director of Educational Services at StataCorp
        </p>
        <p style="font-size: 0.8em; color: #94A3B8; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 60px;">
            October 20, 2026
        </p>
    <img src="png/logo19-white.svg" alt="Stata Logo" style="width: 160px; margin: 0 auto; display: block; box-shadow: none; background: transparent;">
</section>

<section>
<h1>Outline</h1>
<div style="display: grid; grid-template-columns: 30vw 30vw 30vw; grid-template-rows: 30vh 30vh; justify-content: center; align-content: center; gap: 20px; flex-grow: 1;">
    
    <!-- Card 1 -->
    <div class="text-box" style="width: 100%; height: 100%; padding: 15px; margin: 0; box-sizing: border-box; display: flex; flex-direction: column; min-height: 0;">
        <p style="margin: 0 0 10px 0; font-size: 0.7em; font-weight: bold; text-align: center; flex-shrink: 0;">Nested data structures</p>
        <img src="png/nesting.svg" alt="Nested data" style="width: 100%; flex: 1 1 0; min-height: 0; object-fit: contain; margin: 0 auto; display: block; box-shadow: none;">
    </div>

    <!-- Card 2 -->
    <div class="text-box" style="width: 100%; height: 100%; padding: 15px; margin: 0; box-sizing: border-box; display: flex; flex-direction: column; min-height: 0;">
        <p style="margin: 0 0 10px 0; font-size: 0.7em; font-weight: bold; text-align: center; flex-shrink: 0;">Random effects</p>
        <img src="png/inference.svg" alt="Random effects" style="width: 100%; flex: 1 1 0; min-height: 0; object-fit: contain; margin: 0 auto; display: block; box-shadow: none;">
    </div>

    <!-- Card 3 -->
    <div class="text-box" style="width: 100%; height: 100%; padding: 15px; margin: 0; box-sizing: border-box; display: flex; flex-direction: column; min-height: 0;">
        <p style="margin: 0 0 10px 0; font-size: 0.7em; font-weight: bold; text-align: center; flex-shrink: 0;">Multilevel models</p>
        <img src="png/mlmm.svg" alt="Multilevel models" style="width: 100%; flex: 1 1 0; min-height: 0; object-fit: contain; margin: 0 auto; display: block; box-shadow: none;">
    </div>

    <!-- Card 4 (With Mini Stata Log) -->
    <div class="text-box" style="width: 100%; height: 100%; padding: 15px; margin: 0; box-sizing: border-box; display: flex; flex-direction: column; min-height: 0;">
        <p style="margin: 0 0 10px 0; font-size: 0.7em; font-weight: bold; text-align: center; flex-shrink: 0;">Basic syntax in Stata</p>
		
        <div class="stata-example" style="margin: 0 auto; padding: 10px; width: 90%; border-radius: 10px; flex: 1 1 0; min-height: 0; display: flex; align-items: center; justify-content: center;">
            <pre class="stlog" style="font-size: 0.35em; margin: 0;"><samp>. xtreg math homework 
			
. mixed math homework ///
	|| schid:
			</samp></pre>
	</div>		
    </div>

    <!-- Card 5 -->
    <div class="text-box" style="width: 100%; height: 100%; padding: 15px; margin: 0; box-sizing: border-box; display: flex; flex-direction: column; min-height: 0;">
        <p style="margin: 0 0 10px 0; font-size: 0.7em; font-weight: bold; text-align: center; flex-shrink: 0;">Model interpretation</p>
        <img src="mlmm_8.svg" alt="Interpretation" style="width: 100%; flex: 1 1 0; min-height: 0; object-fit: contain; margin: 0 auto; display: block; box-shadow: none;">
    </div>

    <!-- Card 6 -->
    <div class="text-box" style="width: 100%; height: 100%; padding: 15px; margin: 0; box-sizing: border-box; display: flex; flex-direction: column; min-height: 0;">
        <p style="margin: 0 0 10px 0; font-size: 0.7em; font-weight: bold; text-align: center; flex-shrink: 0;">Two examples</p>
        <img src="mlmm_12.svg" alt="Two examples" style="width: 100%; flex: 1 1 0; min-height: 0; object-fit: contain; margin: 0 auto; display: block; box-shadow: none;">
    </div>

</div>
</section>	

<section class="column-slide">
	<h1>Nested data structures</h1>
	<div class="twocolumn">
		<div>
		<img src="png/nesting.svg" alt="Nesting Data Structures Diagram">
		</div>
		<div>
			<ul>
				<li>Observations are grouped into higher-level units, called clusters or groups.</li>
				<li>Observations within a cluster are correlated.</li>
				<li>Classic nesting examples</li>
				<ul>
					<li>Students within schools</li>
					<li>Patients within doctors</li>
					<li>Employees within companies</li>
					<li>Repeated measurements within individuals</li>
				</ul>
				<li>Data can be collected at the observation level or the cluster level.</li>
			</ul>
		</div>
</section>
<section class="column-slide">
	<h1>The dataset</h1>
	<ul>
		<li>In this dataset, we have 519 students (level 1) nested within 23 schools (level 2).</li>
	</ul>
<div class="stata-example">
***/
use math 
list in 50/60, sepby(schid)
codebook schid
/*** 
</div>
</section>
<section class="column-slide">
	<h1>Linear regression</h1>
	<ul>
		<li>We can use linear regression to estimate the relationship between a student's math score and the number of hours they spend on math homework each week, controlling for socioeconomic status, the student-teacher ratio of their school, and whether their school is public or private.</li>
	</ul>	
	<div class="twocolumn">
		<div>
<div class="stata-example">
		***/
		regress math homework ses c.ratio##schtype
		/*** 
		</div>
		</div>
		<div>
		<div class="stata-example">
		***/
		quietly  margins, at(homework=(0/7)) plot
		webdoc graph, as(svg) 
		/*** 
		</div>
		</div>
	</div>
<div class="fragment fade-in-then-out pop-up-box">
        <p>Two problems:</p>
        <ol>
            <li>We have a nested data structure, which violates the independence assumption of linear regression.</li>
            <li>We want to answer questions about both the individual and cluster levels.</li>
        </ol>
    </div>
</section>
<section class="column-slide">
	<h1>Problem 1</h1>
	<ul>
		<li>Nested data structures violate the independence assumption of linear regression, leading to:</li>
		<ul>
			<li>biased standard errors</li>
			<li>biased test statistics</li>
			<li>inflated Type I error rates</li>
		</ul>
		<li>The easiest solution is to use cluster-robust standard errors to correct the standard errors and test statistics of the regression coefficients.</li>
	</ul>
	<div class="stata-example">
		***/
		regress math homework ses c.ratio##schtype, vce(cluster schid)
		/*** 
		</div>

</section>
<section class="column-slide">
	<h1>Problem 2</h1>
	<ul>
		<li>Linear regression doesn't allow us to answer questions about both the individual and cluster levels.</li>
		<li>For example, we might want to know:</li>
		<ul>
			<li>How much of a student's math score is dictated by their own characteristics versus the school they attend?</li>
			<li>Does the impact of a specialized math tutoring program on test scores vary from school to school?</li>
			<li>Does a student's own family income improve their grades, or does simply attending a school with a high average family income provide a separate, additional boost?</li>
		</ul>
		<li>The solution to this problem is to use multilevel/mixed-effects models (MLMMs).</li>
				<ul>
			<li>MLMMs provide correct standard errors and test statistics.</li>
			<li>MLMMs can model variation at both the individual and cluster levels.</li>
		</ul>
		<li>Also known as variance-component models or hierarchical linear models (HLM), this modeling framework incorporates both fixed and random effects.</li>
	</ul>
</section>
<section class="column-slide">
	<h1>Random effects</h1>
	<ul> 
		<li>Random effects are unobserved variables that capture the variation in the outcome variable at the cluster level. </li>
		<li>Just as we assume that the individuals are drawn from a population, we can also assume that the clusters are drawn from a population.
	</ul> 
		<img src="png/inference.svg" alt="Random Effects Diagram" style="width: 100%; max-height: 80vh; object-fit: contain;">
</section>

<section class="column-slide">
	<h1>Multilevel/mixed-effects models (MLMMs)</h1> 
	<div class="twocolumn">	
		<div>
		<p>MLMMs disaggregate the variance in the outcome variable into observation-level and cluster-level components.</p>
		<ul>
			<li><strong>Fixed-effect</strong> coefficients estimate average effects across all clusters.</li>
			<li><strong>Random-effect</strong> coefficients capture variation in the outcome variable at the cluster level.</li>
			<li><strong>Level-1 residuals</strong> capture the remaining variation in the outcome variable at the observation level.</li>
		</ul>
		$$y_{ij} = \beta_0 + \beta_1 x_{ij} + u_{0j} + u_{1j} x_{ij} + \epsilon_{ij}$$
		</div>
		<div>
			<img src="png/mlmm.svg" alt="MLMM Diagram" style="width: 100%; max-height: 80vh; object-fit: contain;">
		</div>
	</div>
</section>

<section class="column-slide">
	<h1>MLMMs in Stata</h1>
	<p>There are two commands in Stata to fit multilevel models: <span class="stata-code">xtreg</span> and <span class="stata-code">mixed</span></p>
		<div class="twocolumn"> 
		<div>
		<p>The <span class="stata-code">xtreg</span> command is simpler to use and is suitable for basic random-intercept models.</p> 
		<div class="stata-example">
			***/
			xtset schid
			xtreg math homework ses c.ratio##schtype, mle
			/*** 
			</div>
			</div>
			<div>
		<p>The <span class="stata-code">mixed</span> command is more flexible and allows for more complex model specifications.</p>
		<div class="stata-example">
			***/
			mixed math homework ses c.ratio##schtype || schid: , stddev
			estat icc
			/*** 
			</div>
	</div>
	</div>
</section>

<section class="column-slide">
	<h1>Interpretation of results</h1>
	<div class="twocolumn">
		<div>
			<p>We interpret the fixed-effect coefficients as the average expected change in the outcome with a one-unit increase in the predictor, holding all other predictors constant.</p>
			<div class="stata-example">
			***/
			quietly margins, at(homework=(0/7)) plot
			webdoc graph, as(svg)
			/***
			</div>
		</div>
		<div>
			<p>We interpret the random-effects as the difference between the average effect across all clusters and the effect in that particular cluster.</p>
			<div class="stata-example">
			***/
			predict u, reffects reses(s)
			egen tagme = tag(schid)
			egen rank = rank(u) if tagme
			serrbar u s rank if tagme, scale(1.96) yline(0) mvopts(mlabel(schid))
			webdoc graph, as(svg) 
			/***
			</div>
		</div>
</section>

<section class="column-slide">
	<h1>Random-intercept models</h1>
	<div class="twocolumn">
		<div>
		<div class="stata-example">
			***/
			mixed math homework || schid: , stddev
			/*** 
			</div>
		</div>
		<div>
		<div class="stata-example">
			***/
			predict yhat1, fitted
			sort schid homework
			twoway (line yhat1 homework, connect(ascending))
			webdoc graph, as(svg) 
			/***
			</div>
		</div>
</section>

<section class="column-slide">
	<h1>Random-slope models</h1>
		<div class="twocolumn">
		<div>
		<div class="stata-example">
			***/
			mixed math homework || schid: homework, cov(unstructured) stddev
			/*** 
			</div>
		</div>
		<div>
		<div class="stata-example">
			***/
			predict yhat2, fitted
			sort schid homework
			twoway (line yhat2 homework, connect(ascending))
			webdoc graph, as(svg) 
			/***
			</div>
		</div>
</section>



<section class="column-slide">
	<h1>What's next</h1>
	<ul>
		<li>Estimation options</li>
		<li>Model comparison</li>
		<li>Assumptions and diagnostics</li>
		<li>Level-1 covariance structures</li>
		<li>The disaggregated model</li>
		<li>Longitudinal data analysis</li>
		<li>Generalized linear mixed models</li>
		<li>Three-level models</li>
	</ul>
	<h2>Learn it all in the full course</h2>
	<ul>
		<li>Multilevel/mixed models using Stata</li>
		<li>November 17-20, 2026</li>
		<li>11am-2:30pm CT</li>
		<li><a href="https://instats.org/seminar/multilevelmixed-models-using-stata">Enroll now!</a></li>
	</ul>
</section>
<section style="height: 100%; position: relative;">
    
    <!-- This container holds both lines of text and centers them perfectly -->
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 100%; text-align: center;">
        <h1 style="font-size: 80px; margin-bottom: 20px;">Thank you!</h1>
        <p style="font-size: 30px; margin: 0;">Keep asking questions in the <a href="https://instats.org/seminar/introduction-to-multilevel-modeling-usin">Forum</a>.</p>
    </div>
    
    <!-- This anchors the logo to the bottom -->
    <img src="png/logo19-white.svg" alt="Stata Logo" style="width: 160px; position: absolute; bottom: 5%; left: 50%; transform: translateX(-50%); display: block; box-shadow: none; background: transparent;">

</section>
</div>
</div>		
		<script src="dist/reveal.js"></script>
		<script src="dist/notes.js"></script>
		<script src="dist/markdown.js"></script>
		<script src="dist/highlight.js"></script>
		<script src="dist/math.js"></script>
		<script>
			Reveal.initialize({
				hash: true,
				plugins: [RevealMarkdown, RevealHighlight, RevealNotes, RevealMath.MathJax3],
				width: "150%",
				height: "150%",
				

			});
		</script>
	</body>
</html>
